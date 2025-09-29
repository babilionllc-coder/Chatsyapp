import 'package:get/get.dart';

import '../controllers/prompt_chat_controller.dart';

class PromptChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PromptChatController>(
      () => PromptChatController(),
    );
  }
}
