import 'dart:async';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/helper/image_path.dart';
// import 'package:video_player/video_player.dart'; // Removed video player functionality

import '../../intro1Screen/models/get_intro_details_model.dart';

class Intro7ScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  // VideoPlayerController? videoController; // Removed video player functionality

  RxDouble value = 0.0.obs;
  RxBool isAnimating = false.obs;

  // Replaced video with smooth animation for better UX
  animationInitialize() {
    isAnimating.value = true;
    // Simulate progress animation instead of video progress
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (value.value < 1.0) {
        value.value += 0.01;
      } else {
        value.value = 0.0; // Loop animation
      }
      update();
    });
  }

  GetIntroData getIntroData = GetIntroData();

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      getIntroData = Get.arguments['data'];
      // if (LottieCacheInApp.instance.getLottie('problemSolvingTasks') == null) {
      //   await LottieCacheInApp.instance.preloadLottie(getIntroData.problemSolvingTasks ?? "", 'problemSolvingTasks');
      // }
      animationInitialize();
    } else {
      animationInitialize();
    }

    super.onInit();
  }

  @override
  void dispose() {
    // Clean disposal for smooth performance
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
