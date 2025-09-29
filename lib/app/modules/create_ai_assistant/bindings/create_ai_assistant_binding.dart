import 'package:get/get.dart';

import '../controllers/create_ai_assistant_controller.dart';

class CreateAiAssistantBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateAiAssistantController>(
      () => CreateAiAssistantController(),
    );
  }
}
