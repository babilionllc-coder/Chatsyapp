import 'package:chatsy/app/helper/all_imports.dart';

import '../../../Localization/local_language.dart';
import '../../../helper/image_path.dart';
import '../../purchase/controllers/purchase_controller.dart';

class ThemePageController extends GetxController {
  RxInt count = 0.obs;

  List<SubscriptionCarousel> themeList = [
    SubscriptionCarousel(
      title: Languages.of(Get.context!)!.lightMode,
      description: ImagePath.brightness2,
    ),
    SubscriptionCarousel(
      title: Languages.of(Get.context!)!.darkMode,
      description: ImagePath.dark,
    ),
  ];

  @override
  void onInit() {
    if (!isLight) {
      count = 1.obs;
    }
    super.onInit();
  }
}
