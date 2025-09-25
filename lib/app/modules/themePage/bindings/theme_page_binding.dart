import 'package:get/get.dart';

import '../controllers/theme_page_controller.dart';

class ThemePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemePageController>(
      () => ThemePageController(),
    );
  }
}
