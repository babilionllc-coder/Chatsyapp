import 'dart:io';

import 'package:chatsy/app/helper/Global.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/modules/purchase/views/purchase_view.dart';

import '../../../routes/app_pages.dart';
import '../../intro1Screen/models/get_intro_details_model.dart';

class NotificationPermissionPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  GetIntroData getIntroData = GetIntroData();

  late final _anim = AnimationController(vsync: this, duration: Durations.long1)
    ..repeat(reverse: true);

  late final position = Tween<Offset>(
    end: const Offset(0, .2),
    begin: const Offset(0, -.2),
  ).animate(_anim);

  Future<void> goToHome() async {
    getStorageData.saveString(getStorageData.isIntro, "1");
    if (Platform.isIOS) {
      if (Global.isSubscription.value != '1' && Global.event) {
        PurchaseView.offAllRoute();
        Global.event = false;
      } else {
        Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      }
    } else {
      Get.offAllNamed(Routes.SOCIAL_SCREEN);
    }
    // await CommonShowModelBottomSheet(
    //   isDivider: false,
    //   childPadding: EdgeInsets.zero,
    //   child: LoginView(mainLogIn: false),
    // );

    // Future.delayed(const Duration(milliseconds: 500), () {

    //   HapticFeedback.mediumImpact();
    //   if (Platform.isIOS) {
    //     Get.offAllNamed(Routes.PURCHASE);
    //   } else {
    //     if (utils.isValidationEmpty(
    //         getStorageData.readString(getStorageData.isIntro))) {
    //       getStorageData.saveString(getStorageData.isIntro, "1");
    //     }
    //     Get.offAllNamed(Routes.BOTTOM_NAVIGATION,
    //         arguments: {"isWelcome": true});
    //   }
    // });
  }

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      getIntroData = Get.arguments['data'];
      // if (LottieCacheInApp.instance.getLottie('notifications') == null) {
      //   await LottieCacheInApp.instance.preloadLottie(getIntroData.notifications ?? "", 'notifications');
      // }
    }
    super.onInit();
  }

  @override
  void onClose() {
    _anim.stop();
    _anim.dispose();
    super.onClose();
  }
}
