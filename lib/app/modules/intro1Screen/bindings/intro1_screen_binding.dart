import 'package:get/get.dart';

import '../controllers/intro1_screen_controller.dart';

class Intro1ScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Intro1ScreenController>(
      () => Intro1ScreenController(),
    );
  }
}
