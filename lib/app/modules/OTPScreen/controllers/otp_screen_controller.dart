import 'dart:io';

import 'package:chatsy/app/modules/purchase/views/purchase_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Localization/local_language.dart';
import '../../../api_repository/api_function.dart';
import '../../../api_repository/loading.dart';
import '../../../common_widget/common_button.dart';
import '../../../common_widget/common_show_model_bottom_sheet.dart';
import '../../../helper/Global.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/get_storage_data.dart';
import '../../../helper/image_path.dart';
import '../../../routes/app_pages.dart';
import '../../Login/views/login_view.dart';
import '../../OfferScreen/controllers/offer_screen_controller.dart';
import '../../SpecialOfferScreen/controllers/special_offer_screen_controller.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../purchase/controllers/purchase_controller.dart';
import '../../signUpScreen/models/send_otp_model.dart';
import '../../splash/controllers/login_model.dart';

class OTPScreenController extends GetxController {
  TextEditingController otpController = TextEditingController();

  void successBottomSheet() {
    CommonShowModelBottomSheet(
      enableDrag: false,
      isDismissible: false,
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Column(
          children: [
            SizedBox(height: 30.px),
            SvgPicture.asset(ImagePath.icDone, height: 70.px),
            SizedBox(height: 30.px),
            TwoLineTextView(
              crossAxisAlignment: CrossAxisAlignment.center,
              firstText: Languages.of(Get.context!)!.successful,
              secondText: Languages.of(Get.context!)!.yourProfileHasBeenCreated,
            ),
            SizedBox(height: 30.px),
            CommonButton(
              onTap: () {
                Get.back();
                if ((!Get.isRegistered<BottomNavigationController>()) &&
                    (!Get.isRegistered<PurchaseController>()) &&
                    (!Get.isRegistered<OfferScreenController>()) &&
                    (!Get.isRegistered<SpecialOfferScreenController>())) {
                  if (Platform.isIOS) {
                    PurchaseView.offAllRoute();
                  } else {
                    if (utils.isValidationEmpty(
                      getStorageData.readString(getStorageData.isIntro),
                    )) {
                      getStorageData.saveString(getStorageData.isIntro, "1");
                    }
                    Get.offAllNamed(Routes.BOTTOM_NAVIGATION, arguments: {"isWelcome": true});
                  }
                } else {
                  Get.back();
                  Get.back();
                  Get.back();
                  Get.back(result: "success");
                }
              },
              title: Languages.of(Get.context!)!.ok,
            ),
          ],
        ).paddingSymmetric(horizontal: commonLeadingWith),
      ),
    );
  }

  bool? isSignUp;
  String? email;

  isOTPValidation() {
    if (otpController.text.isEmpty) {
      utils.showToast(message: Languages.of(Get.context!)!.errorMessageOtp);
      return false;
    } else if (otpController.text.length != 4) {
      utils.showToast(message: Languages.of(Get.context!)!.errorMessageValidOTP);
      return false;
    } else {
      if (isSignUp != null) {
        signUpAPI();
      } else {
        verifyForgotPasswordOTPAPI();
      }
    }
  }

  forgotPasswordAPI() async {
    FormData formData = FormData.fromMap({
      HttpUtil.email: email,
      HttpUtil.otp: otpController.text.trim(),
    });
    final data = await APIFunction().apiCall(
      apiName: Constants.forgotPassword,
      params: formData,
      isLoading: true,
    );
    Loading.dismiss();

    SendOtpModel model = SendOtpModel.fromJson(data);
    if (model.responseCode == 1) {
      otpController.clear();
      utils.showToast(message: model.responseMsg ?? "");
    } else {
      utils.showToast(message: model.responseMsg ?? "");
    }
  }

  verifyForgotPasswordOTPAPI() async {
    FormData formData = FormData.fromMap({
      HttpUtil.email: email,
      HttpUtil.otp: otpController.text.trim(),
    });
    final data = await APIFunction().apiCall(
      apiName: Constants.verifyForgotPasswordOTP,
      params: formData,
      isLoading: true,
    );
    Loading.dismiss();

    SendOtpModel model = SendOtpModel.fromJson(data);
    if (model.responseCode == 1) {
      Get.toNamed(Routes.RESET_PASSWORD_SCREEN, arguments: {HttpUtil.email: email});
    } else {
      utils.showToast(message: model.responseMsg ?? "");
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
      HttpUtil.email: Get.arguments['email'],
      HttpUtil.userName: Get.arguments['name'],
    });
    final data = await APIFunction().apiCall(
      apiName: Constants.sendOTP,
      params: formData,
      isLoading: true,
    );
    Loading.dismiss();

    SendOtpModel model = SendOtpModel.fromJson(data);
    if (model.responseCode == 1) {
      otpController.clear();
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
      HttpUtil.userName: Get.arguments[HttpUtil.userName],
      HttpUtil.email: Get.arguments[HttpUtil.email],
      HttpUtil.deviceId: getStorageData.readString(getStorageData.deviceId),
      HttpUtil.deviceToken: getStorageData.readString(getStorageData.deviceToken),
      HttpUtil.password: utils.generateMd5(Get.arguments[HttpUtil.password]),
      HttpUtil.otp: otpController.text.trim(),
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

      successBottomSheet();
    } else {
      utils.showToast(message: model.responseMsg ?? "");
    }
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      isSignUp = Get.arguments[HttpUtil.isSignUp] ?? isSignUp;
      email = Get.arguments[HttpUtil.email] ?? email;
    }
    super.onInit();
  }
}
