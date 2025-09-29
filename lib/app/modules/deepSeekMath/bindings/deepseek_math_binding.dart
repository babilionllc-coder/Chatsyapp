import 'package:get/get.dart';

import '../controllers/deepseek_math_controller.dart';

class DeepseekMathBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeepseekMathController>(
      () => DeepseekMathController(),
    );
  }
}
