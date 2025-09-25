import 'package:get/get.dart';

import '../controllers/real_time_web_controller.dart';

class RealTimeWebBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RealTimeWebController>(
      () => RealTimeWebController(),
    );
  }
}
