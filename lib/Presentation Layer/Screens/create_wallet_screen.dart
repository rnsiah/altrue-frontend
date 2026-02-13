import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:wallet/wallet.dart' as wallet;

class CreateWalletScreen extends StatefulWidget {
  const CreateWalletScreen({super.key});

  @override
  State<CreateWalletScreen> createState() => _CreateWalletScreenState();
}

class _CreateWalletScreenState extends State<CreateWalletScreen> {
  final _pinController = TextEditingController();
  final _secureStorage = const FlutterSecureStorage();

  dynamic _mnemonic;
  String? _ethAddress;
  bool _walletCreated = false;

  /// Generates a new wallet (mnemonic + ETH address)
  void _generateWallet() {
    final mnemonicList = wallet.generateMnemonic();
    final mnemonic = mnemonicList.join(' '); // Convert list to single string
    final seed = wallet.mnemonicToSeed(mnemonicList);

    final master = wallet.ExtendedPrivateKey.master(seed, wallet.xprv);
    final root = master.forPath("m/44'/60'/0'/0/0");
    final privateKey =
        wallet.PrivateKey((root as wallet.ExtendedPrivateKey).key);
    final publicKey = wallet.ethereum.createPublicKey(privateKey);
    final ethAddress = wallet.ethereum.createAddress(publicKey);

    setState(() {
      _mnemonic = mnemonic;
      _ethAddress = ethAddress;
      _walletCreated = true;
    });
  }

  /// Encrypt mnemonic with user's PIN
  String _encryptMnemonic(String mnemonic, String pin) {
    // Derive a 32-byte key from PIN (simple, not PBKDF2 here)
    final keyBytes = utf8.encode(pin.padRight(32, '0')).sublist(0, 32);
    final key = encrypt.Key(keyBytes);
    final iv = encrypt.IV.fromLength(16);

    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(mnemonic, iv: iv);
    return encrypted.base64;
  }

  /// Save encrypted mnemonic & address to secure storage
  Future<void> _saveWallet() async {
    if (_mnemonic == null || _pinController.text.isEmpty) return;

    final encryptedMnemonic =
        _encryptMnemonic(_mnemonic!, _pinController.text);

    await _secureStorage.write(key: 'encrypted_mnemonic', value: encryptedMnemonic);
    await _secureStorage.write(key: 'eth_address', value: _ethAddress);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Wallet saved securely!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Wallet')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_walletCreated) ...[
              ElevatedButton(
                onPressed: _generateWallet,
                child: const Text('Generate Wallet'),
              ),
            ] else ...[
              const Text('Your Ethereum Address:'),
              Text(_ethAddress ?? '', style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text('Your Recovery Phrase (Write this down):'),
              Text(_mnemonic ?? '',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.red)),
              const SizedBox(height: 20),
              TextField(
                controller: _pinController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Set a PIN for encryption',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveWallet,
                child: const Text('Save Wallet Securely'),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
