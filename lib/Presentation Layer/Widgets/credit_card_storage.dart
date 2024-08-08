import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CreditCardStorage {
  static const _storage = FlutterSecureStorage(iOptions: IOSOptions());
  static const _keyPrefix = 'credit_card_';

  static Future<void> saveCreditCard({
    required String cardNumber,
    required String expiryDate,
    required String cvvCode,
    required String cardHolderName,
  }) async {
    await _storage.write(
      key: '$_keyPrefix$cardNumber',
      value: cardNumber,
    );
    await _storage.write(key: '$_keyPrefix$expiryDate', value: expiryDate);
    await _storage.write(key: '$_keyPrefix$cvvCode', value: cvvCode);
    await _storage.write(
        key: '$_keyPrefix$cardHolderName', value: cardHolderName);
  }

  static Future<Map<String, String?>> getCreditCard() async {
    final cardNumber = await _storage.read(key: '$_keyPrefix.cardNumber');
    final expiryDate = await _storage.read(key: '$_keyPrefix.expiryDate');
    final cardHolderName =
        await _storage.read(key: '$_keyPrefix.cardHolderName');
    final cvvCode = await _storage.read(key: '$_keyPrefix.cvvCode');

    return {
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cardHolderName': cardHolderName,
      'cvvCode': cvvCode,
    };
  }
}
