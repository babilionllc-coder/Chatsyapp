import 'package:get/get.dart';

import '../controllers/chat_gpt_controller.dart';

class ChatGptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatGptController>(
      () => ChatGptController(),
    );
  }
}
