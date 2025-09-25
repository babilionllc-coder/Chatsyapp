import 'package:get/get.dart';

import '../../intro1Screen/models/get_intro_details_model.dart';

class Intro3Controller extends GetxController {
  GetIntroData getIntroData = GetIntroData();

  @override
  void onInit() {
    if (Get.arguments != null) {
      getIntroData = Get.arguments['data'];
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
