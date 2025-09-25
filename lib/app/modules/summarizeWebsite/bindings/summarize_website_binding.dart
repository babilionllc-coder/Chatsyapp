import 'package:get/get.dart';

import '../controllers/summarize_website_controller.dart';

class SummarizeWebsiteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SummarizeWebsiteController>(
      () => SummarizeWebsiteController(),
    );
  }
}
