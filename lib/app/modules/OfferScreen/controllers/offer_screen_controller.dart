import 'dart:async';
import 'dart:io';

import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../api_repository/api_function.dart';
import '../../../api_repository/loading.dart';
import '../../../common_widget/error_and_update_dialog.dart';
import '../../../helper/Global.dart';
import '../../../helper/all_imports.dart';
import '../../../routes/app_pages.dart';
import '../../SpecialOfferScreen/models/offer_model.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../chat_gpt/controllers/chat_gpt_controller.dart';
import '../../purchase/controllers/purchase_controller.dart';
import '../../purchase/models/purchase_plane_model.dart';
import '../../purchase/views/congratulation_view.dart';
import '../../splash/controllers/appsflyer_controller.dart';
import '../../splash/controllers/login_model.dart';

class OfferScreenController extends GetxController {
  final closeButton = false.obs;
  Timer? timer;

  RxString remainingTimeValue = " 00 : 04 : 00 ".obs; // Start from 2 minutes

  formatDuration(Duration d) {
    final int hours = d.inHours;
    final int minutes = d.inMinutes % 60;
    final int seconds = d.inSeconds % 60;

    remainingTimeValue.value =
        " ${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')} ";
  }

  String? type = Constants.offer35;
  int second = 0;

  String originalPrice = "\$65";

  @override
  void onInit() {
    if (Get.arguments != null) {
      type = Get.arguments['type'];
      second = Get.arguments['second'] ?? 0;
    }
    Global.offerType = null;

    getLoginData();
    subscriptionStream();

    timer = Timer.periodic(const Duration(seconds: 1), (tick) {
      formatDuration(
        Duration(
          seconds: const Duration(minutes: 4).inSeconds - (tick.tick + second),
        ),
      );

      if ((tick.tick + second) >= 3 && (!closeButton.value)) {
        closeButton.value = true;
      }
      if (((tick.tick + second) == const Duration(minutes: 4).inSeconds) &&
          type == Constants.offer15) {
        timer?.cancel();
        // backToHomeScreen();
      }

      update();
    });

    FlutterInappPurchase.instance.initialize();

    super.onInit();
  }

  backToHomeScreen({dynamic result}) async {
    HapticFeedback.mediumImpact();

    if (utils.isValidationEmpty(
      getStorageData.readString(getStorageData.isIntro),
    )) {
      getStorageData.saveString(getStorageData.isIntro, "1");
      Get.offAllNamed(Routes.BOTTOM_NAVIGATION, arguments: {"isWelcome": true});
    } else {
      if (Navigator.of(Get.context!).canPop()) {
        printAction("if if if if if ");
        Get.back(result: result);
      } else {
        debugPrint("else le se lele elele ele ele ele ");
        Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      }
    }
    // EasyLoading.dismiss();
  }

  OfferData offerData = OfferData();

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

  Future<void> getOfferDetails() async {
    FormData formData = FormData.fromMap({
      "user_id": userId,
      // "type": type,
      "type": Constants.offer35,
    });

    final data = await APIFunction().apiCall(
      apiName: Constants.getSharePlanDtl,
      params: formData,
    );

    OfferModel model = OfferModel.fromJson(data);

    if (model.responseCode == 1) {
      offerData = model.data ?? offerData;

      fetchSubscriptions();
    }
  }

  getLoginData() {
    printAction(
      "data -=-=-==-=-=--==-==-  ${getStorageData.containKey(getStorageData.loginData)}",
    );
    if (getStorageData.containKey(getStorageData.loginData)) {
      loginData = LoginData.fromJson(
        getStorageData.readObject(getStorageData.loginData),
      );
      userId = getStorageData.readString(getStorageData.userId) ?? "";
    }
    update();
    getOfferDetails();
  }

  String userId = "";

  LoginData? loginData;
  StreamSubscription? stream;
  bool isPurchased = true;
  RxBool isLoadingView = false.obs;

  subscriptionStream() {
    stream?.cancel();
    stream = InAppPurchase.instance.purchaseStream.listen((event) async {
      if (event.isEmpty) {
        utils.showToast(message: "You currently have no plans.");
      }
      // EasyLoading.dismiss();
      // isLoadingView.value = false;

      event.forEach((element) async {
        if (element.status == PurchaseStatus.error ||
            element.status == PurchaseStatus.canceled) {
          debugPrint("API CALLED 33");
          isLoadingView.value = false;
        } else if (element.status == PurchaseStatus.purchased) {
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
        }
        if (element.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(element);
        }
      });
    });
  }

  purchaseBottomSheet({required String? planId}) async {
    if (getStorageData.readString(getStorageData.isGuestMode) == "1" &&
        Platform.isAndroid) {
      final isLogin = await loginUser();
      if (!isLogin) {
        return;
      } else {
        if (Get.isRegistered<BottomNavigationBar>()) {
          Get.put(BottomNavigationController()).getLoginData();
          Get.put(BottomNavigationController()).update();
        }
        if (Get.isRegistered<ChatGptController>()) {
          Get.put(ChatGptController()).update();
        }
      }
    }
    isLoadingView.value = true;
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
      } catch (e) {
        printAction("-=-=--==-error is $e");
        // EasyLoading.dismiss();
        isLoadingView.value = false;
      }
    }
  }

  ProductDetailsResponse? response;

  Future<void> fetchSubscriptions() async {
    try {
      // EasyLoading.show();
      isLoadingView.value = true;

      Set<String> allIds = {offerData.offerPlan?.productId ?? ""};

      response = await InAppPurchase.instance.queryProductDetails(allIds);
      debugPrint("response -- ${response?.productDetails}");
      if ((response?.productDetails.length ?? 0) > 1) {
        originalPrice = response?.productDetails.last.price ?? originalPrice;
      }

      ///===== all existing product are inside the productDetails.======
      for (int i = 0; i < (response?.productDetails.length ?? 0); i++) {
        printAction("jsdbnjadsndkjn ${response!.productDetails[i].price}");
        if (offerData.offerPlan?.productId ==
            response!.productDetails[i].id.trim()) {
          offerData.offerPlan?.price = response!.productDetails[i].price.trim();
          offerData.offerPlan?.rawPrice = response!.productDetails[i].rawPrice;
          // if (Platform.isAndroid) EasyLoading.dismiss();
          if (Platform.isAndroid) isLoadingView.value = false;

          if (Platform.isAndroid) update();
          if (Platform.isAndroid) return;
        }
      }

      if (Platform.isIOS) {
        List<IAPItem> list = await FlutterInappPurchase.instance.getProducts(
          allIds.toList(),
        );
        printAction("listlistlistlist ${list.length}");
        for (var item in list) {
          printAction("itemitemitemitemitemitem ${item.toJson()}");
          if (offerData.offerPlan?.productId == item.productId) {
            if (!utils.isValidationEmpty(item.introductoryPrice)) {
              offerData.offerPlan?.price = item.introductoryPrice;
              offerData.offerPlan?.rawPrice = double.tryParse(
                item.introductoryPriceNumberIOS ?? '',
              );

              originalPrice = item.price ?? originalPrice;
            }
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
                  if (getStorageData.containKey(getStorageData.loginData)) {
                    loginData = LoginData.fromJson(
                      getStorageData.readObject(getStorageData.loginData),
                    );
                    userId =
                        getStorageData.readString(getStorageData.userId) ?? "";
                  }
                  update();
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

  purchasePlan(PurchaseDetails productItem) async {
    String uid = getStorageData.readString(getStorageData.userId) ?? "";
    String? purchaseOriginalTransactionId;
    String? purchaseTransactionId;

    FormData? formData;
    try {
      // Loading.show();
      isLoadingView.value = true;

      Future.delayed(const Duration(seconds: 2), () async {
        await FlutterInappPurchase.instance.initialize().then((value) async {
          var list =
              await FlutterInappPurchase.instance.getAvailablePurchases();
          debugPrint("list -----> length ------> ${list?.length}");

          for (int i = 0; i < list!.length; i++) {
            debugPrint(
              "productItem.productID ------> ${productItem.productID}",
            );
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
                formData = FormData.fromMap({
                  // "plan_name": "Yearly Offer",
                  "user_id": uid,
                  'original_transaction_id': purchaseOriginalTransactionId,
                  'apple_transaction_id': purchaseTransactionId,
                  'product_id': productItem.productID,
                });
                break;
              }
            }
          }
        });

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
            loginData!.isSubscription = "1";
            Global.saveLoginData(data: model.data);
            update();
            printOkStatus("SUCCESSS-=-=-=-=-=-=-=-=-=-=--=-=-=-=-SUCCESSS");
            utils.showToast(message: model.responseMsg!);
            AppsFlyerController.trackEvent(
              eventName: "af_${model.data?.planName ?? "purchase"}",
              eventValues: {
                for (var field in formData!.fields) field.key: field.value,
              },
            );
            congratulationDialog();
          } else if (model.responseCode == 26) {
            updateDialog(model.responseMsg);
          } else {
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

  ///============================ purchasePlanAPI Android =============================
  purchaseAndroidPlan({
    required String type,
    required String purchaseToken,
    required String productId,
    required String orderId,
  }) async {
    stream!.cancel();
    String uid = getStorageData.readString(getStorageData.userId) ?? "";
    String token = getStorageData.readString(getStorageData.token) ?? "";
    // debugPrint("=====productID_id======${purchaseToken}");

    isLoadingView.value = true;

    FormData formData = FormData.fromMap({
      "user_id": uid,
      "type": type,
      "purchase_token": purchaseToken,
      "product_id": productId,
      'order_id': orderId,
      // "plan_name": "Yearly Offer",
    });
    final data = await APIFunction().apiCall(
      apiName: Constants.planPurchaseSubscriptionAndroid,
      params: formData,
      token: token,
      isLoading: false,
    );

    PurchasePlanModel model = PurchasePlanModel.fromJson(data);
    Loading.dismiss();
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

      congratulationDialog();
    } else if (model.responseCode == 26) {
      updateDialog(model.responseMsg);
    } else
      errorDialog(model.responseMsg);
  }

  @override
  void onClose() {
    timer?.cancel();
    stream!.cancel();
    // EasyLoading.dismiss();
    isLoadingView.value = false;
    if (Get.isRegistered<PurchaseController>()) {
      Get.put(PurchaseController()).subscriptionStream();
    }
    super.onClose();
  }
}
