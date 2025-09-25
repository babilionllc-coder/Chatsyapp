import 'package:get/get.dart';

import '../controllers/camera_custom_controller.dart';

class CameraCustomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CameraCustomController>(
      () => CameraCustomController(),
    );
  }
}
