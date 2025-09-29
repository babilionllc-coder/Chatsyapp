import 'package:get/get.dart';

import '../controllers/code_review_agent_controller.dart';

class CodeReviewAgentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CodeReviewAgentController>(
      () => CodeReviewAgentController(),
    );
  }
}
