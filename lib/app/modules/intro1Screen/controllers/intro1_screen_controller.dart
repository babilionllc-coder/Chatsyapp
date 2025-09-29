import '../../../helper/all_imports.dart';
import '../models/get_intro_details_model.dart';

class Intro1ScreenController extends GetxController with GetTickerProviderStateMixin {
  GetIntroData getIntroData = GetIntroData();

  // late final lottieController = AnimationController(
  //   vsync: this,
  //   duration: const Duration(seconds: 15),
  //   animationBehavior: AnimationBehavior.normal,
  // )
  //   ..forward()
  //   ..repeat();

  @override
  void onInit() async {
    if (Get.arguments != null) {
      getIntroData = Get.arguments['data'] as GetIntroData;
      // if (LottieCacheInApp.instance.getLottie('lottie3') == null) {
      //   await LottieCacheInApp.instance.preloadLottie(getIntroData.intro3 ?? "", 'lottie3');
      // }
      // if (LottieCacheInApp.instance.getLottie('lottie1') == null) {
      //   await LottieCacheInApp.instance.preloadLottie(getIntroData.intro1 ?? "", 'lottie1');
      // }
    }

    // LottieCacheInApp.instance.preloadLottie(getIntroData.intro2 ?? "", 'lottie2');
    // LottieCacheInApp.instance.preloadLottie(getIntroData.problemSolvingTasks ?? "", 'problemSolvingTasks');
    // LottieCacheInApp.instance.preloadLottie(getIntroData.notifications ?? "", 'notifications');
    // LottieCacheInApp.instance.preloadLottie(getIntroData.happyUsers ?? "", 'happyUsers');
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // lottieController
    //   ?..stop()
    //   ..dispose();
    super.onClose();
  }
}
