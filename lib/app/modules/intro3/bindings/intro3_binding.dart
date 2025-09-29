import 'package:get/get.dart';

import '../controllers/intro3_controller.dart';

class Intro3Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Intro3Controller>(
      () => Intro3Controller(),
    );
  }
}
