import 'package:get/get.dart';

import '../controllers/whats_new_controller.dart';

class WhatsNewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WhatsNewController>(
      () => WhatsNewController(),
    );
  }
}
