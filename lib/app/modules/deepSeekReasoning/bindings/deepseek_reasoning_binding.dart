import 'package:get/get.dart';

import '../controllers/deepseek_reasoning_controller.dart';

class DeepseekReasoningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeepseekReasoningController>(
      () => DeepseekReasoningController(),
    );
  }
}
