import 'package:get/get.dart';

import '../controllers/voice_page_controller.dart';

class VoicePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoicePageController>(
      () => VoicePageController(),
    );
  }
}
