import 'package:encrypt/encrypt.dart';

class EncryptData{

  final key = Key.fromLength(32);
  final iv = IV.fromLength(16);

  String encrypted(String data){
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(data, iv: iv);

    return encrypted.base64;
  }

  String decrypted(Encrypted data){
    final encrypter = Encrypter(AES(key));
    final decrypted = encrypter.decrypt(data, iv: iv);

    return decrypted;
  }
}