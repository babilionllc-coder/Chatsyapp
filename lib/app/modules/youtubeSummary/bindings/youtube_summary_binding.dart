import 'package:get/get.dart';

import '../controllers/youtube_summary_controller.dart';

class YoutubeSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YoutubeSummaryController>(
      () => YoutubeSummaryController(),
    );
  }
}
