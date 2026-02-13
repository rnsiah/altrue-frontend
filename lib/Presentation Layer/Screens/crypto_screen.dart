import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class WalletChoiceScreen extends StatefulWidget {
  const WalletChoiceScreen({super.key});

  @override
  State<WalletChoiceScreen> createState() => _WalletChoiceScreenState();
}

class _WalletChoiceScreenState extends State<WalletChoiceScreen> {
  String? _selectedOption; // 'create' or 'connect'

  void _onContinue() {
    if (_selectedOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a wallet option')),
      );
      return;
    }

    if (_selectedOption == 'create') {
      // Navigate to Create Wallet flow
      context.go('/userprofile/createWallet');
    } else if (_selectedOption == 'connect') {
      // Navigate to Connect Wallet flow
      context.go('/userprofile/connectWallet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Choose Wallet Option')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How would you like to use blockchain features?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Create Wallet option
            CheckboxListTile(
              title: const Text('Create a New Wallet'),
              subtitle: const Text('We will generate a secure wallet for you inside the app.'),
              value: _selectedOption == 'create',
              onChanged: (value) {
                setState(() {
                  _selectedOption = value! ? 'create' : null;
                });
              },
            ),

            // Connect Wallet option
            CheckboxListTile(
              title: const Text('Connect Existing Wallet'),
              subtitle: const Text('Use WalletConnect to link your current wallet (MetaMask, Trust, etc.).'),
              value: _selectedOption == 'connect',
              onChanged: (value) {
                setState(() {
                  _selectedOption = value! ? 'connect' : null;
                });
              },
            ),

            const Spacer(),

            // Continue button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _onContinue,
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
