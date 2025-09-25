import 'package:get/get.dart';

import '../controllers/offer_screen_controller.dart';

class OfferScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfferScreenController>(
      () => OfferScreenController(),
    );
  }
}
