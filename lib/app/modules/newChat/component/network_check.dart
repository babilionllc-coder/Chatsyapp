import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkCheck {
  final Connectivity connectivity = Connectivity();
  Future<bool> checkNetwork() async {
    List<ConnectivityResult> result = await connectivity.checkConnectivity();
    result.skip(1);

    if (result.isNotEmpty) {
      if (result.last == ConnectivityResult.wifi || result.last == ConnectivityResult.mobile) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
