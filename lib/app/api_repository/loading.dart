import 'package:chatsy/app/api_repository/custom_animation.dart';
import 'package:chatsy/extension.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gif_view/gif_view.dart';

import '../helper/all_imports.dart';
import '../helper/image_path.dart';

class Loading {
  static bool isLoading = false;
  static loadingInit() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..contentPadding = const EdgeInsets.all(18)
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 40.0
      ..lineWidth = 2
      ..radius = 15
      ..progressColor = AppColors.white
      ..backgroundColor = isLight ? const Color(0xFF232126) : const Color(0xFFFFFFFF)
      ..indicatorColor = !isLight ? const Color(0xFF232126) : AppColors.white
      ..textColor = AppColors.white
      ..maskColor = AppColors.white.changeOpacity(0.4)
      ..maskType = EasyLoadingMaskType.none
      ..userInteractions = false
      ..customAnimation = CustomAnimation()
      ..dismissOnTap = false;
  }

  static Future<void> show([String? text]) async {
    if (!isLoading) {
      isLoading = true;
      await showDialog(
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        context: Get.context!,
        builder: (context) {
          return Dialog(
            backgroundColor: AppColors.transparent,
            elevation: 0,
            child: WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: GifView.asset(
                ImagePath.loader,
                height: 60,
                width: 60,
                frameRate: 15, // default is 15 FPS
              ),
            ),
          );
        },
      );

      isLoading = false;
    }

    // EasyLoading.instance.userInteractions = false;
    // EasyLoading.show();
  }

  static void toast(String text) {
    EasyLoading.showToast(text);
  }

  static void dismiss() {
    if (isLoading) {
      isLoading = false;
      Get.back();
    }

    // EasyLoading.instance.userInteractions = true;
    // EasyLoading.dismiss();
  }
}
