import 'package:get/get.dart';

import '../controllers/translation_page_controller.dart';

class TranslationPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TranslationPageController>(
      () => TranslationPageController(),
    );
  }
}
