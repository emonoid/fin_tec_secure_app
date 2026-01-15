// encryption_service.dart
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

class EncryptionService {
  static const String publicKeyPEM = String.fromEnvironment(
    "PUBLIC_KEY_PEM_FOR_ENCRYPTION",
  );

  late final RSAPublicKey publicKey;
  late final Encrypter encrypter;

  EncryptionService() {
    publicKey = RSAKeyParser().parse(publicKeyPEM) as RSAPublicKey;
    encrypter = Encrypter(RSA(publicKey: publicKey));
  }

  String encryptData(String plainText) {
    final encrypted = encrypter.encrypt(plainText);
    return encrypted.base64;
  }

  Map<String, dynamic> encryptApiPayload(
    Map<String, dynamic> data,
    List<String> sensitiveFields,
  ) {
    final result = Map<String, dynamic>.from(data);

    for (final field in sensitiveFields) {
      if (result.containsKey(field) && result[field] != null) {
        result[field] = encryptData(result[field].toString());
      }
    }

    return result;
  }

  Map<String, String> encryptWithAES(String plainText) {
    final aesKey = Key.fromSecureRandom(32);
    final iv = IV.fromSecureRandom(16);

    final aesEncrypter = Encrypter(AES(aesKey));
    final encryptedData = aesEncrypter.encrypt(plainText, iv: iv);

    final encryptedKey = encrypter.encrypt(aesKey.base64);

    return {
      'data': encryptedData.base64,
      'key': encryptedKey.base64,
      'iv': iv.base64,
    };
  }
}
