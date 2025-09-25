import 'package:get/get.dart';

import '../controllers/assistants_page_controller.dart';

class AssistantsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AssistantsPageController>(
      () => AssistantsPageController(),
    );
  }
}
