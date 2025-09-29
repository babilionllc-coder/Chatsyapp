import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/helper/image_path.dart';
import 'package:video_player/video_player.dart';

import '../../intro1Screen/models/get_intro_details_model.dart';

class Intro7ScreenController extends GetxController with GetSingleTickerProviderStateMixin {
  VideoPlayerController? videoController;

  RxDouble value = 0.0.obs;

  videoInitialize() {
    // videoController = VideoPlayerController.networkUrl(Uri.parse(getIntroData.videoLink ?? "${Constants.imageBaseUrl}images/video_intro.mp4"))
    videoController = VideoPlayerController.asset(ImagePath.introViewVideo)
      ..initialize().then((_) {
        videoController?.play();

        if (videoController != null) {
          videoController?.addListener(() {
            if (videoController != null) {
              value.value =
                  (videoController!.value.position.inSeconds /
                      videoController!.value.duration.inSeconds);
              printAction("value.value ${value.value}");
              if (videoController!.value.position >= videoController!.value.duration) {
                videoController!.seekTo(Duration.zero);
                videoController!.play();
              }
            }
          });
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
      videoInitialize();
    } else {
      videoInitialize();
    }

    super.onInit();
  }

  disposeVideoController() {
    printAction("=========== disposeVideoController ============");
    if (videoController != null) {
      videoController!.dispose();
    }
  }

  @override
  void dispose() {
    disposeVideoController();
    super.dispose();
  }

  @override
  void onClose() {
    disposeVideoController();

    super.onClose();
  }
}
