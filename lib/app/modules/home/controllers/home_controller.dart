import 'dart:io';

import 'package:chatsy/app/common_widget/common_button.dart';
import 'package:chatsy/app/common_widget/common_show_model_bottom_sheet.dart';
import 'package:chatsy/app/helper/Global.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
// import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Localization/local_language.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/font_family.dart';
import '../../../helper/image_path.dart';
import '../../splash/controllers/login_model.dart';

class HomeController extends GetxController {
  final easyRefreshController = EasyRefreshController(controlFinishRefresh: true);

  @override
  void onInit() {
    getLoginData();
    super.onInit();
  }

  LoginData? loginData;
  String userId = "";
  String enteredText = '';
  bool seeAllStatus = false;
  bool historySeeAllStatus = false;

  String imagePath = "";
  TextEditingController questionController = TextEditingController();

  // fileName = "";
  // imagePath = "";

  void getLoginData() {
    if (getStorageData.containKey(getStorageData.loginData)) {
      loginData = LoginData.fromJson(getStorageData.readObject(getStorageData.loginData));
      userId = loginData!.userId!;
      Global.isSubscription.value = loginData!.isSubscription!;
    }
    update();
  }

  String? question;
  String fileName = "";
  TextEditingController urlTextController = TextEditingController();
  TextEditingController msgController = TextEditingController();

  Future<bool> isCorrectWebsite(String url) async {
    EasyLoading.show();
    bool isCorrect = false;
    printAction('--------sksmk--???-----');
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        EasyLoading.dismiss();
        isCorrect = true;
      } else {
        EasyLoading.dismiss();
        isCorrect = false;
      }
    } catch (e) {
      EasyLoading.dismiss();
      isCorrect = false;
    }
    return isCorrect;
  }

  String selectedLanguage = "English";

  cleanFile() {
    question = null;
    fileName = "";
  }
}

doYouBottomSheet2() {
  CommonShowModelBottomSheet(
    child: StatefulBuilder(
      builder: (context, setState) {
        return SafeArea(
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                /*Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    Get.back();
                  },
                  child: CommonContainer(
                    radius: 100.px,
                    color: AppColors().closeColor,
                    padding: EdgeInsets.all(10.px),
                    child: Image.asset(
                      ImagePath.lightClose,
                      color: AppColors().darkAndWhite,
                      height: 24.px,
                      width: 24.px,
                    ),
                  ),
                ),
              ),*/
                SizedBox(height: 20.px),
                Center(
                  child: Image.asset(
                    isLight ? ImagePath.rateImageLight : ImagePath.rateImage,
                    height: 50.px,
                    width: 60.w,
                  ),
                ),
                SizedBox(height: 10.px),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.px),
                  child: Center(
                    child: AppText(
                      Languages.of(context)!.doYouLikeUsAsMuchAsW,
                      textAlign: TextAlign.center,
                      fontFamily: FontFamily.helveticaBold,
                      fontSize: 18.px,
                    ),
                  ),
                ),
                SizedBox(height: 8.px),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.px),
                  child: Center(
                    child: AppText(
                      Languages.of(context)!.weDetailedReview,
                      textAlign: TextAlign.center,
                      fontSize: 16.px,
                      color: AppColors().lightTextColor,
                    ),
                  ),
                ),
                SizedBox(height: 20.px),
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.px),
                    child: CommonButton(
                      borderRadius: 18.px,
                      onTap: () async {
                        HapticFeedback.mediumImpact();
                        Get.back();
                        if (Platform.isAndroid) {
                          var appName = "com.aichatsy.app";
                          var targetURL = Uri.parse(
                            "market://details?id=$appName&hl=en&gl=US&reviewId=0",
                          );
                          await launchUrl(targetURL, mode: LaunchMode.externalApplication);
                        } else if (Platform.isIOS) {
                          var appID = "6449819419";
                          var targetURL = Uri.parse(
                            "itms-apps://itunes.apple.com/app/$appID?action=write-review",
                          );
                          await launchUrl(targetURL, mode: LaunchMode.externalApplication);
                        }
                      },
                      title: Languages.of(context)!.helpAiChatSy,
                    ),
                  ),
                ),
                SizedBox(height: 10.px),
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      HapticFeedback.mediumImpact();
                      Get.back();
                      final Uri emailLaunchUri = Uri(
                        scheme: 'mailto',
                        path: 'feedback@aichatsy.com',
                      );

                      try {
                        launch(emailLaunchUri.toString());
                      } catch (e) {
                        debugPrint('Error: $e');
                      }
                    },
                    child: AppText(
                      Languages.of(context)!.sendFeedback,
                      textAlign: TextAlign.center,
                      fontFamily: FontFamily.helveticaBold,
                      fontSize: 18.px,
                    ),
                  ),
                ),
                // SizedBox(height: (IphoneHasNotch.hasNotch) ? 30.px : 20.px),
              ],
            ),
          ),
        );
      },
    ),
  );
}
