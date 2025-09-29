import 'package:get/get.dart';

import '../controllers/reason_controller.dart';

class ReasonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReasonController>(
      () => ReasonController(),
    );
  }
}
