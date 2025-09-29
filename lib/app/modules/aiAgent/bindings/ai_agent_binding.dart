import 'package:get/get.dart';

import '../controllers/ai_agent_controller.dart';

class AiAgentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AiAgentController>(
      () => AiAgentController(),
    );
  }
}
