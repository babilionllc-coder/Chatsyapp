import 'dart:io';

import 'package:chatsy/app/common_widget/common_button.dart';
import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/helper/font_family.dart';
import 'package:chatsy/app/helper/image_path.dart';
import 'package:chatsy/extension.dart';

import '../../../Localization/local_language.dart';
import '../../../routes/app_pages.dart';
import '../../OfferScreen/controllers/offer_screen_controller.dart';
import '../../SpecialOfferScreen/controllers/special_offer_screen_controller.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../purchase/controllers/purchase_controller.dart';
import '../controllers/social_screen_controller.dart';

class SocialScreenView extends GetView<SocialScreenController> {
  const SocialScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SocialScreenController>(
      init: SocialScreenController(),
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors().backgroundColor1,
            image: DecorationImage(
              image: AssetImage((isLight) ? ImagePath.socialImageLight : ImagePath.socialImageDark),
              alignment: Alignment.bottomCenter,
            ),
          ),
          child: CommonScreen(
            backgroundColor: AppColors.transparent,
            actions: [
              if ((!Get.isRegistered<BottomNavigationController>()) &&
                  (!Get.isRegistered<PurchaseController>()) &&
                  (!Get.isRegistered<OfferScreenController>()) &&
                  (!Get.isRegistered<SpecialOfferScreenController>()))
                GestureDetector(
                  onTap: () {
                    if (!controller.skipOnTap) controller.onTapSkip();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 12.px),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.px),
                      color: AppColors().darkAndWhite.changeOpacity(0.1),
                    ),
                    child: AppText(
                      Languages.of(context)!.skip,
                      fontFamily: FontFamily.helveticaBold,
                      fontSize: 12.px,
                    ),
                  ).paddingSymmetric(vertical: 10.px),
                ),
              SizedBox(width: commonLeadingWith),
            ],
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonButton(
                  onTap: () {
                    controller.loginWithGoogle();
                  },
                  buttonColor: AppColors.black,
                  isBorder: true,
                  borderColor: AppColors.red,
                  borderWidth: 2,
                  textColor: AppColors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        ImagePath.google,
                        height: 20.px,
                        color: AppColors.white,
                      ).paddingOnly(right: 12.px),
                      AppText(
                        Languages.of(Get.context!)!.continueWithGoogle,
                        color: AppColors.white,
                        fontFamily: FontFamily.helveticaBold,
                        fontSize: 14.px,
                      ),
                    ],
                  ),
                ).paddingOnly(bottom: 10.px),
                if (Platform.isIOS)
                  CommonButton(
                    onTap: () {
                      controller.signInWithApple();
                    },
                    buttonColor: AppColors.black,
                    textColor: AppColors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImagePath.apple,
                          height: 20.px,
                          color: AppColors.white,
                        ).paddingOnly(right: 12.px),
                        AppText(
                          Languages.of(Get.context!)!.continueWithApple,
                          color: AppColors.white,
                          fontFamily: FontFamily.helveticaBold,
                          fontSize: 14.px,
                        ),
                      ],
                    ),
                  ).paddingOnly(bottom: 10.px),
                CommonButton(
                  onTap: () {
                    Get.toNamed(Routes.LOGIN);
                  },
                  textColor: AppColors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email_rounded,
                        color: AppColors.white,
                        size: 22.px,
                      ).paddingOnly(right: 12.px),
                      AppText(
                        Languages.of(Get.context!)!.continueWithEmail,
                        color: AppColors.white,
                        fontFamily: FontFamily.helveticaBold,
                        fontSize: 14.px,
                      ),
                    ],
                  ),
                ).paddingOnly(bottom: 10.px),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.TERMS_PAGE);
                      },
                      child: AppText(Languages.of(context)!.termsOfUse, fontSize: 14.px),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.PRIVACY_POLICY);
                      },
                      child: AppText(Languages.of(context)!.privacyPolicy, fontSize: 14.px),
                    ),
                  ],
                ),
              ],
            ).paddingOnly(top: 10.px, bottom: 30.px, left: 20.px, right: 20.px),
            body: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              primary: false,
              children: [
                SizedBox(height: 10.h),
                Image.asset(
                  (isLight) ? ImagePath.darkLogo : ImagePath.logo,
                  height: 100.px,
                ).paddingOnly(bottom: 10.px),
                Center(
                  child: AppText(
                    "CHATSY",
                    fontSize: 20.px,
                    fontFamily: Constants.neuePowerTrialText,
                    color: AppColors().lightGray,
                  ),
                ),
                SizedBox(height: 5.h),
                Center(
                  child: AppText(
                    "Expand Your Mind, Elevate Your Life_",
                    fontSize: 16.px,
                    color: AppColors().lightGray,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
