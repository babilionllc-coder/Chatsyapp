import 'package:get/get.dart';

import '../controllers/qa_agent_controller.dart';

class QaAgentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QaAgentController>(
      () => QaAgentController(),
    );
  }
}
