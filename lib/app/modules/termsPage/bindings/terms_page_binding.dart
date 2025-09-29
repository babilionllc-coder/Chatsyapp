import 'package:get/get.dart';

import '../controllers/terms_page_controller.dart';

class TermsPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermsPageController>(
      () => TermsPageController(),
    );
  }
}
