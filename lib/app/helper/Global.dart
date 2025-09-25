import 'dart:io';

import 'package:chatsy/extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../elevenLabLib/elevenlabs_config.dart';
import '../../elevenLabLib/elevenlabs_flutter.dart';
import '../../elevenLabLib/elevenlabs_types.dart';
import '../modules/splash/controllers/login_model.dart';
import 'all_imports.dart';
import 'image_path.dart';

class Global {
  static String? offerType;

  static RxInt chatLimit =
      (getStorageData.containKey(getStorageData.chatLimit))
          ? int.parse(getStorageData.readString(getStorageData.chatLimit).toString()).obs
          : 0.obs;
  static RxString isSubscription =
      (getStorageData.containKey(getStorageData.isSubscription))
          ? getStorageData.readString(getStorageData.isSubscription).toString().obs
          : "0".obs;

  static bool isVibrate = false;
  static bool isRatingBanner = false;

  static saveLoginData({LoginData? data}) {
    if (data == null) {
      return;
    }
    getStorageData.saveObject(getStorageData.loginData, data);
    Global.isSubscription.value = data.isSubscription ?? Global.isSubscription.value;
    getStorageData.saveString(getStorageData.userId, data.userId);
    getStorageData.saveString(getStorageData.deviceId, data.deviceId);

    getStorageData.saveString(getStorageData.token, data.token);
    getStorageData.saveString(getStorageData.chatLimit, data.chatLimit);
    Global.chatLimit.value = int.parse(data.remainingChatLimit ?? "0");
    if (data.remainingChatLimit != null)
      getStorageData.saveString(getStorageData.chatLimit, data.remainingChatLimit.toString());
    if (data.productId != null)
      getStorageData.saveString(getStorageData.isProductId, data.productId.toString());

    getStorageData.saveString(getStorageData.isSubscription, data.isSubscription);
    getStorageData.saveString(getStorageData.userName, data.name);
    getStorageData.saveString(getStorageData.isGuestMode, data.isGuestMode);
    getStorageData.saveString(
      getStorageData.profile,
      utils.isValidationEmpty(data.profile) ? data.profileImg : data.profile,
    );
  }

  static Widget isLoadingView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 32.px,
              width: 32.px,
              child: const CircularProgressIndicator(color: AppColors.white, strokeWidth: 2),
            ),
            SvgPicture.asset(ImagePath.icImageLoading, width: 15.px, height: 15.px),
          ],
        ),
        SizedBox(width: 10.px),
        const AppText("Processing...", color: AppColors.white),
      ],
    );
  }

  static InAppReview inAppReview = InAppReview.instance;

  static final elevenLabs = ElevenLabsAPI();

  static bool event = false;

  static elevenLabInit() async {
    await elevenLabs
        .init(config: ElevenLabsConfig(apiKey: Constants.elevenLabVoiceKey))
        .then((value) async {});
  }

  static Future<File?> elevenLabSynthesSize({required String text, required String voiceId}) async {
    try {
      return await Global.elevenLabs.synthesize(
        TextToSpeechRequest(text: text.toString(), voiceId: voiceId),
      );
    } catch (e) {
      e.log;
    }
    return null;
  }

  static showTheReview() async {
    printAction("showTheReview call call call call");

    if (await inAppReview.isAvailable()) {
      Future.delayed(const Duration(seconds: 2), () async {
        try {
          await inAppReview.requestReview();
        } catch (e) {
          debugPrint('Error during review flow: $e');
        }
      });
    } else {
      printAction("showTheReviewshowTheReviewshowTheReviewshowTheReviewshowTheReview");
    }
  }

  static vibrate() async {}
}
