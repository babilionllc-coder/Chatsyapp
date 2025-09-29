import 'dart:async';
import 'dart:io';

import 'package:chatsy/app/api_repository/api_function.dart';
import 'package:chatsy/app/common_widget/common_button.dart';
import 'package:chatsy/app/helper/Global.dart';
import 'package:chatsy/app/helper/font_family.dart';
import 'package:chatsy/app/modules/OfferScreen/views/offer_screen_view.dart';
import 'package:chatsy/app/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:chatsy/app/modules/chat_gpt/controllers/chat_gpt_controller.dart';
import 'package:chatsy/app/modules/splash/controllers/appsflyer_controller.dart';
import 'package:chatsy/app/modules/splash/controllers/login_model.dart';
import 'package:chatsy/extension.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:lottie/lottie.dart';

import '../../../Localization/local_language.dart';
import '../../../common_widget/error_and_update_dialog.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/image_path.dart';
import '../../../routes/app_pages.dart';
import '../../intro1Screen/views/intro1_screen_view.dart';
import '../models/get_plan_details_model.dart';
import '../models/purchase_plane_model.dart';
import '../views/congratulation_view.dart';

class PurchaseController extends GetxController {
  String userId = "";
  String productId = "";
  LoginData? loginData;
  bool isRestore = true;

  // bool isFreeTrial = false;
  bool isFreeTrial = true;

  RxBool isLoadingView = false.obs;

  bool restoreButtonClick = false;

  final closeButton = false.obs;
  late final isReview = false.obs;
  RxInt reviewCurrentIndex = 0.obs;

  String calculatePrice(String price, int duration, {String? rawPrice}) {
    // Regular expression to check for valid price format
    RegExp validPricePattern = RegExp(
      r'^[^\d]*\d{1,3}(,\d{3})*(\.\d{2})?$|^[^\d]*\d+',
    );

    // Check if the price format is valid
    if (!validPricePattern.hasMatch(price)) {
      debugPrint("Invalid price format");
      return "";
    }

    // Remove any non-numeric characters except for the decimal point
    String cleanedPrice = rawPrice!.replaceAll(RegExp(r'[^\d.]'), '');

    // Convert the cleaned price string to a double
    double yearlyPrice = double.tryParse(cleanedPrice) ?? 0.0;

    // Handle division by zero in case 'month' is zero
    if (duration == 0) {
      debugPrint("Months can't be zero");
      return "";
    }

    // Calculate the monthly price
    double monthlyPrice = yearlyPrice / duration;

    // Extract the currency symbol by removing digits, commas, and dots
    String currencySymbol = price.replaceAll(RegExp(r'[\d,.]'), '').trim();

    // Return the result, rounding the monthly price to two decimal places
    return "$currencySymbol${monthlyPrice.toStringAsFixed(2)}";
  }

  bool isOpenBottomSheet = false;

  Future<void> backToHomeScreen({dynamic result}) async {
    HapticFeedback.mediumImpact();
    if (Global.isSubscription.value != "1" && isOpenBottomSheet) {
      OfferScreenView.route(arguments: {"type": Constants.offer15});
    } else {
      if (utils.isValidationEmpty(
        getStorageData.readString(getStorageData.isIntro),
      )) {
        getStorageData.saveString(getStorageData.isIntro, "1");
        Get.offAllNamed(
          Routes.BOTTOM_NAVIGATION,
          arguments: {"isWelcome": true},
        );
      } else {
        if (Navigator.of(Get.context!).canPop()) {
          Get.back(result: result);
        } else {
          Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
        }
      }
    }
    isLoadingView.value = false;
  }

  void getData() {
    userId = getStorageData.readString(getStorageData.userId) ?? "";
    productId = getStorageData.readString(getStorageData.isProductId) ?? "";

    for (Plans item in getPlanDetailData.plans ?? []) {
      if (productId.contains(item.productId ?? "")) {
        selectedPlan.value = getPlanDetailData.plans?.indexOf(item) ?? 0;
        if (!utils.isValidationEmpty(item.freeTrialProductId)) {
          // isFreeTrial = true;
          update();
        }
        break;
      }
    }
    update();
  }

  Future<bool> loginUser() async {
    bool isLogin = false;
    await showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.px),
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          content: ShowLogInView(
            onTap: () {
              Get.toNamed(Routes.SOCIAL_SCREEN)?.then((value) {
                Get.back();
                if (value != null) {
                  getData();
                  getLoginData();
                  isLogin = true;
                }
              });
            },
          ),
        );
      },
    );
    return isLogin;
  }

  void congratulationDialog() {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          actionsPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.px),
          iconPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.symmetric(horizontal: 20.px),
          titlePadding: EdgeInsets.zero,
          content: CongratulationView(
            onTap: () {
              Get.back();
              backToHomeScreen(result: "plan_purchase");
            },
          ),
        );
      },
    );
  }

  void waitingDialog() {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          actionsPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.px),
          iconPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.symmetric(horizontal: 20.px),
          titlePadding: EdgeInsets.zero,
          content: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LottieBuilder.asset(
                  ImagePath.offBonusGift,
                  height: 132.px,
                  repeat: true,
                  reverse: false,
                  renderCache: RenderCache.raster,
                ),
                Center(
                  child: AppText(
                    Languages.of(context)!.wait,
                    fontSize: 44.px,
                    color: AppColors.primary,
                    height: 0.8,
                    fontFamily: FontFamily.helveticaBold,
                  ),
                ),
                Center(
                  child: AppText(
                    Languages.of(context)!.justOneLastThing,
                    fontSize: 24.px,
                    color: AppColors.black,
                    fontFamily: FontFamily.helveticaBold,
                  ),
                ),
                SizedBox(height: 10.px),
                Center(
                  child: AppText(
                    Languages.of(context)!.beforeWeShowYouAround,
                    fontSize: 12.px,
                    color: AppColors.black.changeOpacity(0.6),
                    textAlign: TextAlign.center,
                  ).paddingSymmetric(horizontal: 12.w),
                ),
                SizedBox(height: 30.px),
                CommonButton(
                  onTap: () {
                    Get.back();
                    stream?.cancel();
                  },
                  title: Languages.of(Get.context!)!.openGift,
                ),
                SizedBox(height: 12.px),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                      backToHomeScreen();
                    },
                    child: AppText(
                      Languages.of(context)!.noThanks,
                      fontSize: 12.px,
                      color: AppColors.black.changeOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(vertical: 20.px),
          ),
        );
      },
    );
  }

  List<String> feelTheLoveList = [
    Languages.of(Get.context!)!.lowestPriceOfTheYear,
    Languages.of(Get.context!)!.unlimitedCredits,
    Languages.of(Get.context!)!.proFeatures,
  ];

  void feelTheLoveDialog() {
    showDialog(
      barrierDismissible: false,
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          actionsPadding: EdgeInsets.zero,
          scrollable: true,
          buttonPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.px),
          iconPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.symmetric(horizontal: 20.px),
          titlePadding: EdgeInsets.zero,
          content: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                LottieBuilder.asset(
                  ImagePath.offBonusGift,
                  height: 132.px,
                  repeat: true,
                  reverse: false,
                  renderCache: RenderCache.raster,
                ),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: Languages.of(context)!.feelThe,
                        style: TextStyle(
                          fontSize: 24.px,
                          fontFamily: FontFamily.helveticaBold,
                          color: AppColors.black,
                        ),
                      ),
                      TextSpan(
                        text: " ${Languages.of(context)!.love.toUpperCase()}",
                        style: TextStyle(
                          fontSize: 24.px,
                          fontWeight: FontWeight.w700,
                          fontFamily: FontFamily.helveticaBold,
                          color: AppColors.lightImageColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.px),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: Languages.of(context)!.weSavedTheBestForLast,
                        style: TextStyle(
                          fontSize: 12.px,
                          color: AppColors.black.changeOpacity(0.6),
                        ),
                      ),
                      TextSpan(
                        text: " ${Languages.of(context)!.offPro.toUpperCase()}",
                        style: TextStyle(
                          fontSize: 12.px,
                          fontWeight: FontWeight.w700,
                          fontFamily: FontFamily.helveticaBold,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 100.w, height: 30.px),
                Column(
                  children: List.generate(feelTheLoveList.length, (index) {
                    return Row(
                      children: [
                        SvgPicture.asset(ImagePath.icDone),
                        SizedBox(width: 10.px),
                        Expanded(
                          child: AppText(
                            feelTheLoveList[index],
                            fontSize: 14.px,
                            color: AppColors.black,
                            fontFamily: FontFamily.helveticaBold,
                          ),
                        ),
                      ],
                    ).paddingOnly(bottom: 14.px);
                  }),
                ),
                SizedBox(width: 100.w, height: 25.px),
                AppText(
                  Languages.of(Get.context!)!.closeThisBannerAndTtGone,
                  fontSize: 12.px,
                  textAlign: TextAlign.center,
                  color: AppColors.black.changeOpacity(0.6),
                ),
                SizedBox(width: 100.w, height: 10.px),
                CommonButton(
                  onTap: () {
                    Get.back();
                    stream?.cancel();
                  },
                  title: Languages.of(Get.context!)!.openGift,
                ),
                SizedBox(height: 12.px),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: AppText(
                      Languages.of(context)!.noThanks,
                      fontSize: 12.px,
                      color: AppColors.black.changeOpacity(0.6),
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(vertical: 20.px),
          ),
        );
      },
    );
  }

  late Timer timer;

  RxBool getPlanDetails = false.obs;
  GetPlanDetailData getPlanDetailData = GetPlanDetailData();

  String? firstTimeSubscription;

  Future<void> getPlanDetailAPI() async {
    FormData formData = FormData.fromMap({
      'user_id': getStorageData.readString(getStorageData.userId),
    });
    final data = await APIFunction().apiCall(
      apiName: Constants.getPlanDetail,
      params: formData,
      headers: {"deviceType": Platform.operatingSystem},
    );
    GetPlanDetailModel model = GetPlanDetailModel.fromJson(data);
    if (model.responseCode == 1) {
      getPlanDetails.value = true;
      firstTimeSubscription =
          model.data?.firstTimeSubscription ?? firstTimeSubscription;

      getPlanDetailData = model.data ?? getPlanDetailData;
      getPlanDetailData.planDesc?.insert(
        0,
        PlanDesc(title: "", basic: "Basic", pro: "Pro"),
      );

      getLoginData();
      if (model.data?.isReview == "1") {
        isReview.value = true;
      } else {
        isReview.value = false;
      }

      try {
        await FlutterInappPurchase.instance.initialize();
      } catch (e) {
        utils.showToast(message: "error is $e");
      }
      subscriptionStream();
      getData();

      await fetchSubscriptions().then((value) async {
        if (Get.arguments != null &&
            Get.arguments.containsKey('is_call') &&
            Get.arguments['is_call']) {
          restoreButtonClick = true;
          if (restoreButtonClick) {
            Future.delayed(const Duration(seconds: 1), () async {
              printAction(
                "fetchSubscriptionsfetchSubscriptionsfetchSubscriptionsfetchSubscriptions",
              );
              if (Platform.isIOS) {
                restorePurchasePlan();
              } else {
                isRestore = false;
                restoreButtonClick = true;
                await InAppPurchase.instance.restorePurchases(
                  applicationUserName: userId,
                );
              }
            });
          }
        } else if (Get.arguments != null &&
            Get.arguments.containsKey('plan_id')) {
          Future.delayed(const Duration(seconds: 1), () async {
            HapticFeedback.mediumImpact();
            isPurchased = false;
            for (Plans item in getPlanDetailData.plans ?? []) {
              if (Get.arguments['plan_id'].toString().contains(
                item.productId ?? "",
              )) {
                selectedPlan.value =
                    getPlanDetailData.plans?.indexOf(item) ?? 0;
                if (!utils.isValidationEmpty(item.freeTrialProductId)) {
                  // isFreeTrial = true;
                  update();
                }
                break;
              }
            }

            purchaseBottomSheet(
              planId:
                  getPlanDetailData.plans?[selectedPlan.value].productId ?? "",
            );
          });
        }
      });
      if (LottieCacheInApp.instance.getLottie('diamond') == null) {
        await LottieCacheInApp.instance.preloadLottie(
          model.data?.diamond ?? "",
          'diamond',
        );
        update();
      }
    } else if (model.responseCode == 26) {
      updateDialog(model.responseMsg);
    } else {
      utils.showToast(message: model.responseMsg ?? "");
    }
    return;
  }

  @override
  void onClose() {
    timer.cancel();
    stream?.cancel();
    isLoadingView.value = false;

    super.onClose();
  }

  @override
  Future<void> onInit() async {
    Global.event = false;
    timer = Timer.periodic(const Duration(seconds: 3), (tick) {
      closeButton.value = true;
      timer.cancel();
    });
    isPurchased = true;
    getPlanDetailAPI();

    super.onInit();
  }

  /// getLoginData
  void getLoginData() {
    printAction(
      "data -=-=-==-=-=--==-==-  ${getStorageData.containKey(getStorageData.loginData)}",
    );
    if (getStorageData.containKey(getStorageData.loginData)) {
      loginData = LoginData.fromJson(
        getStorageData.readObject(getStorageData.loginData),
      );
    }
    update();
  }

  StreamSubscription? stream;

  // bool tempSec = false;
  RxInt selectedPlan = 0.obs;

  bool isPurchased = true;

  RxBool freeTrialWeek = false.obs;
  RxBool freeTrialWeekView = false.obs;

  void subscriptionStream() {
    stream?.cancel();
    stream = InAppPurchase.instance.purchaseStream.listen((event) async {
      if (event.isEmpty) {
        restoreButtonClick = false;

        utils.showToast(message: "You currently have no plans.");
      }
      // EasyLoading.dismiss();
      // isLoadingView.value = false;

      event.forEach((element) async {
        element.status.log;

        if (element.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(element);
        }

        if (element.status == PurchaseStatus.error ||
            element.status == PurchaseStatus.canceled) {
          restoreButtonClick = false;
          debugPrint("API CALLED 33");
          isLoadingView.value = false;
          if (element.status == PurchaseStatus.canceled) {
            if (!isReview.value) {
              stream?.cancel();
              backToHomeScreen();
            } else {
              isOpenBottomSheet = false;
            }
          }
        } else if (element.status == PurchaseStatus.pending) {
          restoreButtonClick = false;

          debugPrint("API CALLED 2");
        } else if (element.status == PurchaseStatus.purchased) {
          // await InAppPurchase.instance.completePurchase(element);
          debugPrint("API CALLED 3");
          if (!isPurchased) {
            isPurchased = true;
            // stream?.cancel();
            debugPrint("API CALLED 4");
            if (Platform.isIOS) {
              debugPrint("API CALLED 6");
              purchasePlan(element);
            } else {
              debugPrint("API CALLED 5");

              printAction(
                "jsonDecode(element.verificationData.localVerificationData)['orderId'] ${jsonDecode(element.verificationData.localVerificationData)['orderId']}",
              );

              purchaseAndroidPlan(
                type: "purchase",
                purchaseToken:
                    jsonDecode(
                      element.verificationData.localVerificationData,
                    )['purchaseToken'],
                productId: element.productID,
                orderId:
                    jsonDecode(
                      element.verificationData.localVerificationData,
                    )['orderId'],
              );
            }
          }
        } else if (element.status == PurchaseStatus.restored) {
          if (Platform.isIOS) {
          } else {
            if (element == event.elementAt(event.length - 1)) {
              printAction(
                "restorePurchasePlanAndroidrestorePurchasePlanAndroidrestorePurchasePlanAndroid",
              );
              if (!isRestore) {
                isRestore = true;
                if (restoreButtonClick) {
                  restoreButtonClick = false;
                  restorePurchasePlanAndroid(
                    orderId2:
                        jsonDecode(
                          element.verificationData.localVerificationData,
                        )['orderId'].toString(),
                  );
                }
              }
            }
          }
        }
      });
    });
  }

  Future<void> purchaseBottomSheet({required String? planId}) async {
    if (getStorageData.readString(getStorageData.isGuestMode) == "1" &&
        Platform.isAndroid) {
      final isLogin = await loginUser();
      if (!isLogin) {
        return;
      } else {
        if (Get.isRegistered<BottomNavigationBar>()) {
          Get.find<BottomNavigationController>()
            ..getLoginData()
            ..update();
        }
        if (Get.isRegistered<ChatGptController>()) {
          Get.find<ChatGptController>().update();
        }
      }
    }
    isLoadingView.value = true;
    isOpenBottomSheet = true;
    if (!utils.isValidationEmpty(planId)) {
      PurchaseParam? purchaseParam;
      debugPrint("index --1");
      for (int i = 0; i < (response?.productDetails.length ?? 0); i++) {
        debugPrint("index  $planId");
        if (response!.productDetails[i].id.trim() == planId) {
          debugPrint(
            "index --2 --- ${response!.productDetails[i].title.trim()}",
          );
          debugPrint("index --3");
          purchaseParam = PurchaseParam(
            productDetails: response!.productDetails[i],
            applicationUserName: userId,
          );
          break;
        }
      }
      try {
        await InAppPurchase.instance.buyNonConsumable(
          purchaseParam: purchaseParam!,
        );
        printAction("aave cghe e");
      } catch (e) {
        printAction("-=-=--==-error is $e");
        // EasyLoading.dismiss();
        isLoadingView.value = false;
        isOpenBottomSheet = false;
      }
    }
  }

  ProductDetailsResponse? response;

  Future<void> fetchSubscriptions() async {
    try {
      // EasyLoading.show();
      isLoadingView.value = true;

      Set<String> allIds = {
        for (Plans plan in getPlanDetailData.plans ?? [])
          (plan.productId ?? ""),
        for (Plans plan in getPlanDetailData.plans ?? [])
          (plan.freeTrialProductId ?? ""),
      };
      allIds.remove("");
      // Set<String> subscriptionIds = <String>{"com.aichatsy.app.weekly", "com.aichatsy.app.monthly", "com.aichatsy.app.yearly", "com.aichatsy.app.weekly.not.offer"};
      Set<String> subscriptionIds = allIds;
      response = await InAppPurchase.instance.queryProductDetails(
        subscriptionIds,
      );
      debugPrint("response -- ${response?.productDetails}");

      ///===== all existing product are inside the productDetails.======
      for (int i = 0; i < (response?.productDetails.length ?? 0); i++) {
        for (Plans item in getPlanDetailData.plans ?? []) {
          if (item.productId == response!.productDetails[i].id.trim()) {
            item.price = response!.productDetails[i].price.trim();
            item.rawPrice = response!.productDetails[i].rawPrice;
          }
        }
      }
      // EasyLoading.dismiss();
      isLoadingView.value = false;

      update();
    } catch (e) {
      // Loading.dismiss();
      isLoadingView.value = false;

      utils.showToast(message: "error is $e");
    }
  }

  Future<void> restorePurchasePlan() async {
    // Loading.show();
    isLoadingView.value = true;

    // String uid = await getStorageData.readString(getStorageData.userId);
    String? purchaseOriginalTransactionId;
    String? purchaseTransactionId;

    FormData? formData;
    try {
      await FlutterInappPurchase.instance.initialize().then((value) async {
        var list = await FlutterInappPurchase.instance.getAvailablePurchases();
        debugPrint("list -----> length ------> ${list?.length}");
        if (list!.isNotEmpty) {
          for (int i = 0; i < list.length; i++) {
            debugPrint(
              "list[i].originalTransactionIdentifierIOS ------> ${list[i].originalTransactionIdentifierIOS}",
            );
            debugPrint(
              "list[i].productId ---condition--->${list[i].productId}",
            );
            debugPrint(
              "list[i].productId ---transactionId--->${list[i].transactionId}",
            );
            debugPrint(
              "list[i].productId ---transactionDate--->${list[i].transactionDate}",
            );
            if (list[i].originalTransactionIdentifierIOS != null &&
                list[i].originalTransactionIdentifierIOS != "") {
              purchaseOriginalTransactionId =
                  list[i].originalTransactionIdentifierIOS;
              purchaseTransactionId = list[i].transactionId;
              formData = FormData.fromMap({
                "user_id": userId,
                'original_transaction_id': purchaseOriginalTransactionId,
                'apple_transaction_id': purchaseTransactionId,
                'product_id': list[i].productId,
              });
              break;
            } /*else {
          purchaseOriginalTransactionId = list[i].transactionId;
          purchaseTransactionId = list[i].transactionId;
        }*/
          }
          if (formData != null) {
            final data = await APIFunction().apiCall(
              apiName: Constants.applePlanRestore,
              params: formData,
              token: getStorageData.readString(getStorageData.token),
              isLoading: false,
            );
            LoginModel model = LoginModel.fromJson(data);
            // Loading.dismiss();
            isLoadingView.value = false;

            if (model.responseCode == 1) {
              Global.saveLoginData(data: model.data);
              utils.showToast(message: model.responseMsg.toString());
              if (Get.isRegistered<BottomNavigationController>()) {
                Get.offAllNamed(Routes.SPLASH);
              } else {
                backToHomeScreen();
              }
            } else if (model.responseCode == 26) {
              updateDialog(model.responseMsg);
            } else {
              errorDialog(model.responseMsg);
            }
          } else {
            // Loading.dismiss();
            isLoadingView.value = false;

            utils.showToast(message: "You currently have no plans.");
          }
        } else {
          // Loading.dismiss();
          isLoadingView.value = false;

          utils.showToast(message: "You currently have no plans.");
        }
      });
    } catch (e) {
      // Loading.dismiss();
      isLoadingView.value = false;

      printAction("error is $e ");
    }
  }

  Future<void> restorePurchasePlanAndroid({String? orderId2}) async {
    restoreButtonClick = false;
    // Loading.show();
    isLoadingView.value = true;

    String uid = getStorageData.readString(getStorageData.userId) ?? "";
    String? purchaseToken;
    String? productId;
    String? orderId = orderId2;

    FormData? formData;
    try {
      await FlutterInappPurchase.instance.initialize().then((value) async {
        var list = await FlutterInappPurchase.instance.getAvailablePurchases();
        debugPrint("list -----> length ------> ${list?.length}");
        if (list!.isNotEmpty) {
          for (int i = 0; i < list.length; i++) {
            debugPrint(
              "list[i].productId ---condition--->${list[i].productId}",
            );
            debugPrint(
              "list[i].productId ---transactionId--->${list[i].purchaseToken}",
            );
            if (list[i].purchaseToken != null && list[i].purchaseToken != "") {
              purchaseToken = list[i].purchaseToken;
              productId = list[i].productId;
              /*jsonDecode(productItem.verificationData.localVerificationData)['orderId']*/
              productId = list[i].productId;
              formData = FormData.fromMap({
                "user_id": uid,
                'purchase_token': purchaseToken,
              });
            } /*else {
          purchaseOriginalTransactionId = list[i].transactionId;
          purchaseTransactionId = list[i].transactionId;
        }*/
          }
          if (formData != null) {
            final data = await APIFunction().apiCall(
              apiName: Constants.androidPlanRestoreLatest,
              params: formData,
              token: getStorageData.readString(getStorageData.token),
              isLoading: false,
            );
            LoginModel model = LoginModel.fromJson(data);
            // Loading.dismiss();
            isLoadingView.value = false;

            if (model.responseCode == 1) {
              utils.showToast(message: model.responseMsg.toString());
              Global.saveLoginData(data: model.data);

              if (Get.isRegistered<BottomNavigationController>()) {
                Get.offAllNamed(Routes.SPLASH);
              } else {
                backToHomeScreen();
              }
            } else if (model.responseCode == 26) {
              updateDialog(model.responseMsg);
            } else if (model.responseCode == 7 &&
                getStorageData
                        .readString(getStorageData.isSubscription)
                        .toString() ==
                    "0") {
              purchaseAndroidPlan(
                type: "restore",
                orderId: orderId ?? "",
                productId: productId ?? "",
                purchaseToken: purchaseToken ?? "",
              );
            } else {
              errorDialog(model.responseMsg);
            }
          } else {
            // Loading.dismiss();
            isLoadingView.value = false;

            utils.showToast(message: "Product id is not getting in AppStore");
          }
        } else {
          // Loading.dismiss();
          isLoadingView.value = false;

          utils.showToast(message: "You currently have no plans.");
        }
      });
    } catch (e) {
      // Loading.dismiss();
      isLoadingView.value = false;

      printAction("error is $e ");
    }
  }

  Future<void> purchasePlan(PurchaseDetails productItem) async {
    String uid = getStorageData.readString(getStorageData.userId) ?? "";
    String? purchaseOriginalTransactionId;
    String? purchaseTransactionId;

    FormData? formData;
    try {
      // Loading.show();
      isLoadingView.value = true;

      Future.delayed(const Duration(seconds: 2), () async {
        var list = await FlutterInappPurchase.instance.getAvailablePurchases();

        for (int i = 0; i < list!.length; i++) {
          debugPrint("productItem.productID ------> ${productItem.productID}");
          debugPrint(
            "list[i].originalTransactionIdentifierIOS ------> ${list[i].originalTransactionIdentifierIOS}",
          );
          debugPrint("list[i].productId ---condition--->${list[i].productId}");
          debugPrint(
            "list[i].productId ---transactionId--->${list[i].transactionId}",
          );
          debugPrint(
            "list[i].productId ---transactionDate--->${list[i].transactionDate}",
          );
          if (list[i].originalTransactionIdentifierIOS != null &&
              list[i].originalTransactionIdentifierIOS != "") {
            printAction("originalTransactionIdentifierIOS null mathi");
            printAction(
              "productItem.productID.toString() ${productItem.productID.toString()}",
            );
            printAction(
              "list[i].productId.toString() ${list[i].productId.toString()}",
            );
            if (productItem.productID.toString() ==
                list[i].productId.toString()) {
              printAction("if if if if if if aave che");
              purchaseOriginalTransactionId =
                  list[i].originalTransactionIdentifierIOS;
              purchaseTransactionId = list[i].transactionId;

              '.localVerificationData -- ${productItem.verificationData.localVerificationData}'
                  .log;

              formData = FormData.fromMap({
                // "plan_name": productItem.productID == "com.aichatsy.app.weekly" || productItem.productID == "com.aichatsy.app.weekly.not.offer"
                //     ? "Weekly"
                //     : productItem.productID == "com.aichatsy.app.monthly"
                //         ? "Monthly"
                //         : productItem.productID == "com.aichatsy.app.yearly"
                //             ? "Yearly"
                //             : "Life Time",
                "user_id": uid,
                'original_transaction_id': purchaseOriginalTransactionId,
                'apple_transaction_id': purchaseTransactionId,
                'product_id': productItem.productID,
                'receipt': productItem.verificationData.localVerificationData
                    .logNamed('LocalVerificationData'),
              });
              break;
            }
          }
        }

        if (formData != null) {
          final data = await APIFunction().apiCall(
            apiName: Constants.planPurchase,
            params: formData,
            token: getStorageData.readString(getStorageData.token),
            isLoading: false,
          );
          PurchasePlanModel model = PurchasePlanModel.fromJson(data);
          // Loading.dismiss();
          isLoadingView.value = false;

          if (model.responseCode == 1) {
            Global.saveLoginData(data: model.data);

            update();
            utils.showToast(message: model.responseMsg!);
            AppsFlyerController.trackEvent(
              eventName: "af_${model.data?.planName ?? "purchase"}",
              eventValues: {
                for (var field in formData!.fields) field.key: field.value,
              },
            );

            ///=========================
            // Get.offAllNamed(Routes.BOTTOM_NAVIGATION_BAR);

            // await Get.put(BottomNavigationController()).getUserProfileAPI();
            // Get.back(result: "plan_purchase");

            congratulationDialog();
            // Get.put(BottomNavigationController()).getUserProfileAPI();
            if (productItem.productID == "com.aichatsy.app.weekly") {
              Global.showTheReview();
            }

            // Restart.restartApp();
          } else if (model.responseCode == 26) {
            updateDialog(model.responseMsg);
          } else {
            // Loading.dismiss();
            errorDialog(model.responseMsg);
          }
        } else {
          // Loading.dismiss();
          isLoadingView.value = false;

          utils.showToast(message: "Product id is not getting in AppStore");
        }

        // });
      });
    } catch (e) {
      // Loading.dismiss();
      isLoadingView.value = false;

      utils.showToast(message: "error is $e");
    }
  }

  purchaseAndroidPlan({
    required String type,
    required String purchaseToken,
    required String productId,
    required String orderId,
  }) async {
    isLoadingView.value = true;

    String uid = getStorageData.readString(getStorageData.userId) ?? "";
    String token = getStorageData.readString(getStorageData.token) ?? "";
    // debugPrint("=====productID_id======${purchaseToken}");
    FormData formData = FormData.fromMap({
      "user_id": uid,
      "type": type,
      "purchase_token":
          purchaseToken /*jsonDecode(productItem.verificationData.localVerificationData)['purchaseToken']*/,
      "product_id": productId /*productItem.productID*/,
      'order_id':
          orderId /*jsonDecode(productItem.verificationData.localVerificationData)['orderId']*/, // "plan_name": productId == "com.aichatsy.app.weekly" || productId == "com.aichatsy.app.weekly.not.offer"
      //     ? "Weekly"
      //     : productId == "com.aichatsy.app.monthly"
      //         ? "Monthly"
      //         : productId == "com.aichatsy.app.yearly"
      //             ? "Yearly"
      //             : "Life Time",
    });
    final data = await APIFunction().apiCall(
      apiName: Constants.planPurchaseSubscriptionAndroid,
      params: formData,
      token: token,
      isLoading: false,
    );

    PurchasePlanModel model = PurchasePlanModel.fromJson(data);
    // Loading.dismiss();
    isLoadingView.value = false;

    if (model.responseCode == 1) {
      loginData!.isSubscription = "1";
      Global.saveLoginData(data: model.data);
      AppsFlyerController.trackEvent(
        eventName: "af_${model.data?.planName ?? "purchase"}",
        eventValues: {
          for (var field in formData.fields) field.key: field.value,
        },
      );
      update();

      printOkStatus("SUCCESSS-=-=-=-=-=-=-=-=-=-=--=-=-=-=-SUCCESSS");
      utils.showToast(message: model.responseMsg!);
      if (type == "restore") {
        if (Get.isRegistered<BottomNavigationController>()) {
          Get.offAllNamed(Routes.SPLASH);
        } else {
          backToHomeScreen();
        }
      } else {
        // Get.back(result: "plan_purchase");
        congratulationDialog();

        // Get.put(BottomNavigationController()).getUserProfileAPI();
      }
      if (type == "purchase") {
        if (productId == "com.aichatsy.app.weekly") {
          Global.showTheReview();
        }
      }
    } else if (model.responseCode == 26) {
      updateDialog(model.responseMsg);
    } else {
      errorDialog(model.responseMsg);
    }
  }
}

class SubscriptionCarousel {
  String? description;
  String? title;
  String? subTitle;
  String? price;

  SubscriptionCarousel({
    this.description,
    required this.title,
    this.subTitle,
    this.price,
  });
}

class SubscriptionDetailModel {
  final String? title;
  final String? text1;
  final String? text2;

  SubscriptionDetailModel({
    required this.title,
    required this.text1,
    required this.text2,
  });
}
