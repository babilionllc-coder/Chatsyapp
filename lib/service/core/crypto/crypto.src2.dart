part of 'crypto.dart';

class _CryptoHelper extends CryptoHelper with _DecryptionMixin {
  _CryptoHelper.internal();

  static final _CryptoHelper _instance = _CryptoHelper.internal();
}
