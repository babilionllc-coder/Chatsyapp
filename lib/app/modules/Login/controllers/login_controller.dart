import 'dart:io';

import 'package:chatsy/app/api_repository/loading.dart';
import 'package:chatsy/app/modules/purchase/views/purchase_view.dart';
import 'package:flutter/foundation.dart';

import '../../../Localization/local_language.dart';
import '../../../api_repository/api_function.dart';
import '../../../helper/Global.dart';
import '../../../helper/all_imports.dart';
import '../../../routes/app_pages.dart';
import '../../OfferScreen/controllers/offer_screen_controller.dart';
import '../../SpecialOfferScreen/controllers/special_offer_screen_controller.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../purchase/controllers/purchase_controller.dart';
import '../../splash/controllers/login_model.dart';

class LoginController extends GetxController {
  TextEditingController email = TextEditingController(
    text: (kDebugMode) ? "montu.kmphitech@gmail.com" : null,
  );
  TextEditingController password = TextEditingController(text: (kDebugMode) ? "Montu@123" : null);

  RxBool isShowPassword = false.obs;

  RxInt isGoogle = 0.obs;
  RxString googleId = "".obs;
  RxInt isApple = 0.obs;
  RxString appleId = "".obs;
  RxString userName = "".obs;
  RxString userEmail = "".obs;

  isValidationOfLogin() {
    if (utils.isValidationEmpty(email.text.trim())) {
      utils.showToast(message: Languages.of(Get.context!)!.errorMessageEmail);
    } else if (!utils.emailValidator(email.text.trim())) {
      utils.showToast(message: Languages.of(Get.context!)!.errorMessageValidEmail);
    } else if (utils.isValidationEmpty(password.text.trim())) {
      utils.showToast(message: Languages.of(Get.context!)!.errorMessagePassword);
    } else if (!utils.passwordValidator(password.text.trim())) {
      utils.showToast(message: Languages.of(Get.context!)!.passwordMustBeMoreThan8Characters());
    } else {
      logInAPI();
    }
  }

  logInAPI() async {
    FormData formData = FormData.fromMap({
      'email': email.text.trim(),
      'password': utils.generateMd5(password.text.trim()),
    });

    printAction("======= password $formData=======================≠");

    final data = await APIFunction().apiCall(apiName: Constants.login, params: formData);

    LoginModel model = LoginModel.fromJson(data);
    Loading.dismiss();
    if (model.responseCode == 1) {
      Global.saveLoginData(data: model.data);
      if ((!Get.isRegistered<BottomNavigationController>()) &&
          (!Get.isRegistered<PurchaseController>()) &&
          (!Get.isRegistered<OfferScreenController>()) &&
          (!Get.isRegistered<SpecialOfferScreenController>())) {
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
      utils.showToast(message: model.responseMsg);
    } else {
      utils.showToast(message: model.responseMsg);
    }
  }

  RxString isReview = "0".obs;

  List logInBenefits = [
    Languages.of(Get.context!)!.syncingYourChatHistoryFor,
    Languages.of(Get.context!)!.restoringYourPurchasesSoThat,
  ];
}

class SocialLoginModel {
  String? emailID;
  String? name;
  int? isGoogle;
  int? isApple;
  String googleId;
  String appleId;

  SocialLoginModel({
    this.emailID,
    this.name,
    this.isGoogle,
    this.isApple,
    required this.appleId,
    required this.googleId,
  });
}
