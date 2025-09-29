import 'package:get/get.dart';

import '../controllers/intro2_screen_controller.dart';

class Intro2ScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Intro2ScreenController>(
      () => Intro2ScreenController(),
    );
  }
}
