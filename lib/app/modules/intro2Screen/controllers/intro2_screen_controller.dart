import '../../../helper/all_imports.dart';
import '../../intro1Screen/models/get_intro_details_model.dart';

class Intro2ScreenController extends GetxController with GetTickerProviderStateMixin {
  int currentIndex = 0;

  GetIntroData getIntroData = GetIntroData();

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      getIntroData = Get.arguments['data'];
      // if (LottieCacheInApp.instance.getLottie('lottie2') == null) {
      //   await LottieCacheInApp.instance.preloadLottie(getIntroData.intro2 ?? "", 'lottie2');
      // }
      // if (LottieCacheInApp.instance.getLottie('happyUsers') == null) {
      //   await LottieCacheInApp.instance.preloadLottie(getIntroData.problemSolvingTasks ?? "", 'happyUsers');
      // }
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

class ReviewModel {
  String title;
  String subTitle;

  ReviewModel({required this.title, required this.subTitle});
}
