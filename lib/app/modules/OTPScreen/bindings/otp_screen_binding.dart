import 'package:get/get.dart';

import '../controllers/otp_screen_controller.dart';

class OTPScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OTPScreenController>(
      () => OTPScreenController(),
    );
  }
}
