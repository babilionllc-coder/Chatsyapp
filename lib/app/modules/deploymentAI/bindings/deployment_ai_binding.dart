import 'package:get/get.dart';

import '../controllers/deployment_ai_controller.dart';

class DeploymentAiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeploymentAiController>(
      () => DeploymentAiController(),
    );
  }
}
