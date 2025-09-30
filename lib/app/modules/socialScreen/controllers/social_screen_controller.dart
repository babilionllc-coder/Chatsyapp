import 'dart:io';

import 'package:chatsy/app/modules/AssistantsPage/controllers/assistants_page_controller.dart';
import 'package:chatsy/app/modules/OfferScreen/controllers/offer_screen_controller.dart';
import 'package:chatsy/app/modules/SpecialOfferScreen/controllers/special_offer_screen_controller.dart';
import 'package:chatsy/app/modules/purchase/controllers/purchase_controller.dart';
import 'package:chatsy/app/modules/purchase/views/purchase_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart' hide AuthorizationStatus;
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:the_apple_sign_in/the_apple_sign_in.dart'; // Removed due to missing header files

import '../../../api_repository/api_function.dart';
import '../../../api_repository/loading.dart';
import '../../../helper/Global.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/get_storage_data.dart';
import '../../../routes/app_pages.dart';
import '../../Login/controllers/login_controller.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../splash/controllers/login_model.dart';

class SocialScreenController extends GetxController {
  RxInt isGoogle = 0.obs;
  RxString googleId = "".obs;
  RxInt isApple = 0.obs;
  RxString appleId = "".obs;
  RxString userName = "".obs;
  RxString userEmail = "".obs;

  bool skipOnTap = false;

  void onTapSkip() {
    skipOnTap = true;
    HapticFeedback.mediumImpact();
    if (Platform.isIOS) {
      PurchaseView.offAllRoute();
    } else {
      if (utils.isValidationEmpty(getStorageData.readString(getStorageData.isIntro))) {
        getStorageData.saveString(getStorageData.isIntro, "1");
      }
      Get.offAllNamed(Routes.BOTTOM_NAVIGATION, arguments: {"isWelcome": true});
    }
  }

  Future<UserCredential?> loginWithGoogle() async {
    GoogleSignInAccount? currentUser;

    try {
      await GoogleSignIn().signIn().then((value) {
        currentUser = value;
        userName.value = currentUser?.displayName ?? "";
        userEmail.value = currentUser?.email ?? "";
        SocialLoginModel socialLoginModel = SocialLoginModel(
          emailID: currentUser?.email ?? "",
          name: currentUser?.displayName ?? "",
          isGoogle: 1,
          googleId: currentUser!.id.toString(),
          isApple: 0,
          appleId: "",
        );
        register(socialLoginModel: socialLoginModel);
        update();
      });
      if (currentUser != null) {}
    } catch (e) {
      return null;
    }
    return null;
  }

  // Apple Sign In function removed due to missing header files in Xcode Cloud
  Future<String> signInWithApple() async {
    // Apple Sign In functionality temporarily disabled
    // TODO: Re-implement with alternative Apple Sign In solution
    debugPrint('Apple Sign In temporarily disabled');
    return "";
  }

  Future<void> register({required SocialLoginModel socialLoginModel}) async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    FormData formData = FormData.fromMap({
      "name": socialLoginModel.name,
      HttpUtil.deviceType: Platform.isAndroid ? "android" : "iOS",
      "email": socialLoginModel.emailID,
      "device_id": getStorageData.readString(getStorageData.deviceId),
      "is_google": socialLoginModel.isGoogle,
      "google_id": socialLoginModel.googleId,
      "is_apple": socialLoginModel.isApple,
      "apple_id": socialLoginModel.appleId,
      // "apple_id": "001794.97e52dc6867b42c48e309938bdeda596.1245",
    });

    printAction("======= password $formData=======================≠");

    final data = await APIFunction().apiCall(
      apiName: Constants.isRegister,
      params: formData,
      isLoading: true,
    );

    LoginModel model = LoginModel.fromJson(data);

    if (model.responseCode == 1) {
      Global.saveLoginData(data: model.data);
      debugPrint("aave che aave che ");
      if ((!Get.isRegistered<BottomNavigationController>()) &&
          (!Get.isRegistered<PurchaseController>()) &&
          (!Get.isRegistered<OfferScreenController>()) &&
          (!Get.isRegistered<SpecialOfferScreenController>())) {
        debugPrint("if if if if if if");
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
        debugPrint("else else else else else");

        Get.back(result: "success");
        Get.find<AssistantsPageController>().easyRefreshController.callRefresh();
      }
    } else if (model.responseCode == 3) {
      if (!utils.isValidationEmpty(model.data?.name)) {
        socialLoginModel.name = model.data?.name;
      }

      if (!utils.isValidationEmpty(model.data?.email)) {
        socialLoginModel.emailID = model.data?.email;
      }

      signUpAPI(socialLoginModel: socialLoginModel);
    } else {
      utils.showToast(message: model.responseMsg!);
    }
  }

  signUpAPI({required SocialLoginModel socialLoginModel}) async {
    if (utils.isValidationEmpty(GetStorageData().readString(GetStorageData().deviceToken))) {
      FirebaseMessaging.instance.getToken().then((firebaseToken) async {
        getStorageData.saveString(getStorageData.deviceToken, firebaseToken);
      });
    }
    FormData formData = FormData.fromMap({
      "name": socialLoginModel.name,
      HttpUtil.deviceType: Platform.isAndroid ? "android" : "iOS",
      "email": socialLoginModel.emailID,
      "device_id": getStorageData.readString(getStorageData.deviceId),
      "is_google": socialLoginModel.isGoogle,
      "google_id": socialLoginModel.googleId,
      "is_apple": socialLoginModel.isApple,
      "apple_id": socialLoginModel.appleId,
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
      register(socialLoginModel: socialLoginModel);
    } else {
      utils.showToast(message: model.responseMsg ?? "");
    }
  }
}
