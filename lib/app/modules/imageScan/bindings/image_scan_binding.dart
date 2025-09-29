import 'package:get/get.dart';

import '../controllers/image_scan_controller.dart';

class ImageScanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageScanController>(
      () => ImageScanController(),
    );
  }
}
