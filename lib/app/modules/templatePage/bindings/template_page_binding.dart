import 'package:get/get.dart';

import '../controllers/template_page_controller.dart';

class TemplatePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TemplatePageController>(
      () => TemplatePageController(),
    );
  }
}
