import 'package:get/get.dart';

import '../controllers/social_screen_controller.dart';

class SocialScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SocialScreenController>(
      () => SocialScreenController(),
    );
  }
}
