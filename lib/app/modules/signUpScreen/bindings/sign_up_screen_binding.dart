import 'package:get/get.dart';

import '../controllers/sign_up_screen_controller.dart';

class SignUpScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpScreenController>(
      () => SignUpScreenController(),
    );
  }
}
