import 'package:get/get.dart';

import '../controllers/intro7_screen_controller.dart';

class Intro7ScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Intro7ScreenController>(
      () => Intro7ScreenController(),
    );
  }
}
