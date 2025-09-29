import 'package:get/get.dart';

import '../controllers/deepseek_coder_controller.dart';

class DeepseekCoderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeepseekCoderController>(
      () => DeepseekCoderController(),
    );
  }
}
