import 'package:get/get.dart';

import '../controllers/image_show_controller.dart';

class ImageShowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageShowController>(
      () => ImageShowController(),
    );
  }
}
