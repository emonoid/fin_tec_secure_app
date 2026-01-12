// import 'package:encrypt/encrypt.dart' as encrypt;

// class Encryption {
//   static final key = encrypt.Key.fromLength(32);
//   static final iv = encrypt.IV.fromLength(16);
//   static final encrypter = encrypt.Encrypter(encrypt.AES(key));

//   static encryptAES({password}) {
//     final encrypted = encrypter.encrypt(password, iv: iv);

//     return encrypted.base64;
//   }

//   static decryptAES({password}) {

//     return encrypter.decrypt64(password, iv: iv);
//   }
// }