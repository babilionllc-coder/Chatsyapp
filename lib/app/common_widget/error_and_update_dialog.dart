import 'dart:io';

import 'package:chatsy/app/helper/font_family.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Localization/local_language.dart';
import '../helper/all_imports.dart';
import '../helper/image_path.dart';
import 'common_button.dart';
import 'common_show_model_bottom_sheet.dart';

errorDialog(String? responseMsg) {
  CommonShowModelBottomSheet(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.px, vertical: 10.px),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10.px),
          Image.asset(ImagePath.splash, height: 90.px),
          SizedBox(height: 10.px),
          AppText("Opps!", textAlign: TextAlign.center, color: AppColors.white, fontSize: 26.px),
          SizedBox(height: 20.px),
          AppText(responseMsg ?? "", textAlign: TextAlign.center, fontSize: 18.px),
          SizedBox(height: 20.px),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.px),
            child: CommonButton(
              onTap: () {
                Get.back();
              },
              title: Languages.of(Get.context!)!.ok,
            ),
          ),
        ],
      ),
    ),
  );
}

updateDialog(String? responseMsg) {
  printAction("====update====alert");
  showDialog(
    context: Get.context!,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        actionsPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        iconPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(31.px)),
        content: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.px),
            child: Container(
              // width: MediaQuery.of(context).size.width,
              // alignment: Alignment.topCenter,
              constraints: BoxConstraints(maxHeight: 90.h, maxWidth: 90.w),
              decoration: BoxDecoration(color: AppColors().lightBottomBar),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.px, vertical: 22.px),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    // padding: EdgeInsets.symmetric(horizontal: 10.px),
                    // physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(height: 10.px),
                      Image.asset(ImagePath.splash, height: 100.px),
                      SizedBox(height: 10.px),
                      AppText(
                        Languages.of(context)!.appUpdate,
                        textAlign: TextAlign.center,
                        color: AppColors().darkAndWhite,
                        fontSize: 26.px,
                        fontFamily: FontFamily.helveticaBold,
                      ),
                      SizedBox(height: 2.h),
                      AppText(
                        "To ensure optimal performance, security, elegant UI and access to new features, a mandatory app update is required. Please update the app to the latest version immediately.\n\nWhy Update:\n  ⚈  Improved Security Measures \n  ⚈  Enhanced Performance \n  ⚈  Exciting New Features with new UI\n\nAction Required:\nVisit your app store now to update the app.\n\nThank you for your cooperation in keeping our app experience top-notch.",
                        textAlign: TextAlign.start,
                        color: AppColors().darkAndWhite,
                        fontSize: 16.px,
                        fontFamily: FontFamily.helveticaRegular,
                      ),
                      SizedBox(height: 20.px),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 22.px, vertical: 10.px),
                        child: CommonButton(
                          onTap: () {
                            // Get.back();
                            launch(
                              Platform.isAndroid
                                  ? "https://play.google.com/store/apps/details?id=com.aichatsy.app&pli=1"
                                  : "https://apps.apple.com/us/app/aichatsy/id6449819419",
                            );
                          },
                          buttonColor: AppColors().darkAndWhite,
                          textColor: AppColors().lightThemWhite,
                          title: Languages.of(context)!.update,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
