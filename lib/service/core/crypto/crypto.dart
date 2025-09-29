import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:chatsy/extension.dart';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

part 'crypto.src.dart';
part 'crypto.src2.dart';
part 'crypto.src3.dart';

abstract class CryptoHelper extends Decryption {
  static final CryptoHelper instance = _CryptoHelper._instance;

  @override
  String encryptDecrypt(String input) {
    throw UnimplementedError('encryptDecrypt has not been implemented.');
  }
}
