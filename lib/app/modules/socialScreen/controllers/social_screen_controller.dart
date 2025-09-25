import 'dart:io';

import 'package:chatsy/app/modules/AssistantsPage/controllers/assistants_page_controller.dart';
import 'package:chatsy/app/modules/OfferScreen/controllers/offer_screen_controller.dart';
import 'package:chatsy/app/modules/SpecialOfferScreen/controllers/special_offer_screen_controller.dart';
import 'package:chatsy/app/modules/purchase/controllers/purchase_controller.dart';
import 'package:chatsy/app/modules/purchase/views/purchase_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart' hide AuthorizationStatus;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

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

  Future<String> signInWithApple() async {
    final AuthorizationResult result = await TheAppleSignIn.performRequests([
      const AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName]),
    ]);
    switch (result.status) {
      case AuthorizationStatus.authorized:
        if (result.credential?.fullName?.familyName != null &&
            result.credential?.fullName?.familyName != "null") {
          // googleFirstName = result.credential!.fullName!.familyName!.split(" ").first.toString().trim();
        }
        if (result.credential!.fullName!.givenName != null &&
            result.credential!.fullName!.givenName != "null") {
          userName.value =
              "${result.credential!.fullName!.familyName!.split(" ").first.toString().trim()} ${result.credential!.fullName!.givenName!.split(" ").first.toString().trim()}";
        }
        if (result.credential!.user != null && result.credential!.user != "null") {
          appleId.value = result.credential!.user!.toString().trim();
        }
        if (result.credential!.email != null && result.credential!.email != "null") {
          userEmail.value = result.credential!.email!.toString().trim();
        }

        if (userName.isNotEmpty) {
          // firstNameController.text = userName.split(" ")[0];
          // lastNameController.text = userName.split(" ")[1];
        }

        SocialLoginModel socialLoginModel = SocialLoginModel(
          emailID: userEmail.value,
          name: userName.value,
          isGoogle: 0,
          isApple: 1,
          googleId: "",
          appleId: result.credential!.user.toString(),
        );
        register(socialLoginModel: socialLoginModel);

        break; //All the required credentials
      case AuthorizationStatus.error:
        debugPrint("Sign in failed: ${result.error!.localizedDescription}");
        break;
      case AuthorizationStatus.cancelled:
        debugPrint('User cancelled');
        break;
    }

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
