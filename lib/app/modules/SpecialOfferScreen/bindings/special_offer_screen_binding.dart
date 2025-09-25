import 'package:get/get.dart';

import '../controllers/special_offer_screen_controller.dart';

class SpecialOfferScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpecialOfferScreenController>(
      () => SpecialOfferScreenController(),
    );
  }
}
