import 'dart:io';

import 'package:chatsy/app/modules/purchase/views/purchase_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../../Localization/local_language.dart';
import '../../../api_repository/api_function.dart';
import '../../../api_repository/loading.dart';
import '../../../helper/Global.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/get_storage_data.dart';
import '../../../routes/app_pages.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../splash/controllers/login_model.dart';
import '../models/send_otp_model.dart';

class SignUpScreenController extends GetxController {
  TextEditingController userName = TextEditingController(text: (kDebugMode) ? "montu" : null);
  TextEditingController email = TextEditingController(
    text: (kDebugMode) ? "montu.kmphitech@gmail.com" : null,
  );
  TextEditingController password = TextEditingController(text: (kDebugMode) ? "Montu@123" : null);
  TextEditingController configPassword = TextEditingController(
    text: (kDebugMode) ? "Montu@123" : null,
  );

  RxBool isShowPassword = false.obs;
  RxBool isConfirmShowPassword = false.obs;
  RxBool isAgree = false.obs;

  isValidationOfSignUp() {
    if (utils.isValidationEmpty(userName.text.trim())) {
      utils.showToast(message: Languages.of(Get.context!)!.enterFullName);
    } else if (utils.isValidationEmpty(email.text.trim())) {
      utils.showToast(message: Languages.of(Get.context!)!.errorMessageEmail);
    } else if (!utils.emailValidator(email.text.trim())) {
      utils.showToast(message: Languages.of(Get.context!)!.errorMessageValidEmail);
    } else if (utils.isValidationEmpty(password.text.trim())) {
      utils.showToast(message: Languages.of(Get.context!)!.errorMessagePassword);
    } else if (!utils.passwordValidator(password.text.trim())) {
      utils.showToast(message: Languages.of(Get.context!)!.passwordMustBeMoreThan8Characters());
    } else if (utils.isValidationEmpty(configPassword.text.trim())) {
      utils.showToast(message: Languages.of(Get.context!)!.enterConfirmPassword);
    } else if (password.text.trim() != configPassword.text.trim()) {
      utils.showToast(message: Languages.of(Get.context!)!.passwordAndConfirmPassword);
    } else if (isAgree.value == false) {
      utils.showToast(message: Languages.of(Get.context!)!.errorMessagePrivacyAndTerms);
    } else {
      sendOtp();
    }
  }

  sendOtp() async {
    if (utils.isValidationEmpty(GetStorageData().readString(GetStorageData().deviceToken))) {
      FirebaseMessaging.instance.getToken().then((firebaseToken) async {
        getStorageData.saveString(getStorageData.deviceToken, firebaseToken);
      });
    }
    FormData formData = FormData.fromMap({
      HttpUtil.deviceType: Platform.isAndroid ? "android" : "iOS",
      HttpUtil.email: email.text.trim(),
      HttpUtil.userName: userName.text.trim(),
    });
    final data = await APIFunction().apiCall(
      apiName: Constants.sendOTP,
      params: formData,
      isLoading: true,
    );
    Loading.dismiss();

    SendOtpModel model = SendOtpModel.fromJson(data);
    if (model.responseCode == 1) {
      Get.toNamed(
        Routes.OTP_SCREEN,
        arguments: {
          HttpUtil.isSignUp: true,
          HttpUtil.userName: userName.text.trim(),
          HttpUtil.email: email.text.trim(),
          HttpUtil.password: password.text.trim(),
        },
      );
      utils.showToast(message: model.responseMsg ?? "");
    } else {
      utils.showToast(message: model.responseMsg ?? "");
    }
  }

  signUpAPI() async {
    if (utils.isValidationEmpty(GetStorageData().readString(GetStorageData().deviceToken))) {
      FirebaseMessaging.instance.getToken().then((firebaseToken) async {
        getStorageData.saveString(getStorageData.deviceToken, firebaseToken);
      });
    }
    FormData formData = FormData.fromMap({
      HttpUtil.deviceType: Platform.isAndroid ? "android" : "iOS",
      "email": email.text.trim(),
      'password': utils.generateMd5(password.text.trim()),
      "device_id": getStorageData.readString(getStorageData.deviceId),
      "is_google": null,
      "google_id": null,
      "is_apple": null,
      "apple_id": null,
      "device_token": getStorageData.readString(getStorageData.deviceToken),
    });
    final data = await APIFunction().apiCall(
      apiName: Constants.signUp,
      params: formData,
      isLoading: true,
    );
    Loading.dismiss();

    LoginModel model = LoginModel.fromJson(data);
    if (model.responseCode == 1) {
      Global.saveLoginData(data: model.data);

      if (!Get.isRegistered<BottomNavigationController>()) {
        HapticFeedback.mediumImpact();
        if (Platform.isIOS) {
          PurchaseView.offAllRoute();
        } else {
          if (utils.isValidationEmpty(getStorageData.readString(getStorageData.isIntro))) {
            getStorageData.saveString(getStorageData.isIntro, "1");
          }
          Get.offAllNamed(Routes.BOTTOM_NAVIGATION, arguments: {"isWelcome": true});
        }
      } else {
        Get.back();
        Get.back(result: "success");
      }
    } else {
      utils.showToast(message: model.responseMsg ?? "");
    }
  }
}
