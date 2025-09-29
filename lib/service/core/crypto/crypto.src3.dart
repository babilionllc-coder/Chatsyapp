part of 'crypto.dart';

mixin _DecryptionMixin on Decryption {
  @override
  String encryptDecrypt(String input) {
    try {
      return CryptoHelper2.decryptData(input);
    } catch (e) {
      debugger();
      e.log;
      return input;
    }
  }

  // String _getSha256(String input) {
  //   final bytes = utf8.encode(input);
  //   final digest = sha256.convert(bytes);
  //   return digest.toString();
  // }
}

class CryptoHelper2 {
  CryptoHelper2._();

  static const _secretKey = 'AAHMKkmphitechCCH2HMKkmphitechBB';
  static const _secretIv = 'mk_secret_iv';

  static String encryptData(String plainText) {
    final key = sha256.convert(utf8.encode(_secretKey)).bytes;
    final iv = sha256.convert(utf8.encode(_secretIv)).bytes.sublist(0, 16);

    final encrypter = encrypt.Encrypter(
      encrypt.AES(
        encrypt.Key(Uint8List.fromList(key)),
        mode: encrypt.AESMode.cbc,
        padding: 'PKCS7',
      ),
    );

    final encrypted = encrypter.encrypt(plainText, iv: encrypt.IV(Uint8List.fromList(iv)));

    return encrypted.base64;
  }

  static String decryptData(String encryptedText) {
    try {
      final key = sha256.convert(utf8.encode(_secretKey)).bytes;
      final iv = sha256.convert(utf8.encode(_secretIv)).bytes.sublist(0, 16);

      final encrypter = encrypt.Encrypter(
        encrypt.AES(
          encrypt.Key(Uint8List.fromList(key)),
          mode: encrypt.AESMode.cbc,
          padding: 'PKCS7',
        ),
      );

      return encrypter.decrypt64(encryptedText, iv: encrypt.IV(Uint8List.fromList(iv)));
    } catch (e) {
      debugger();
      print("Decryption error: $e");
      return encryptedText;
    }
  }
}
