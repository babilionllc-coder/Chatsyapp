import 'dart:async';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:chatsy/app/api_repository/api_function.dart';
import 'package:chatsy/app/helper/image_path.dart';
import 'package:chatsy/app/modules/OfferScreen/views/offer_screen_view.dart';
import 'package:chatsy/app/modules/SpecialOfferScreen/views/special_offer_screen_view.dart';
import 'package:chatsy/app/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:chatsy/app/modules/splash/controllers/appsflyer_controller.dart';
import 'package:chatsy/app/modules/splash/controllers/login_model.dart';
import 'package:chatsy/app/routes/app_pages.dart';
import 'package:chatsy/extension.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../main.dart';
import '../../../common_widget/error_and_update_dialog.dart';
import '../../../helper/Global.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/get_storage_data.dart';
import '../../intro1Screen/models/get_intro_details_model.dart';

class SplashController extends GetxController {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final notifications = FlutterLocalNotificationsPlugin();
  final DarwinInitializationSettings initializationSettingsIOS =
      const DarwinInitializationSettings(
        defaultPresentAlert: true,
        defaultPresentBadge: true,
        defaultPresentSound: true,
      );
  final AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  firebaseNotificationInit() async {
    var initializationSettings = InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    notifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // todo: receive payload data of foreground notification || click event of notification when application is on foreground
        if (kDebugMode) {
          debugPrint(
            "Foreground notification data --------> ${details.payload}",
          );
        }
        Map<String, dynamic> payload = jsonDecode(details.payload!);
      },
    );

    // todo: click event of notification when application is on background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      printAction("$message");
      if (message.notification?.title != null) {
        debugPrint("background notification data =-=-=-=-=-> ${message.data}");

        if (kDebugMode) {
          utils.showToast(message: "${message.data}");
        }
      }
    });

    // todo: click event of notification when application is on kill(terminated)
    firebaseMessaging.getInitialMessage().then((value) {
      if (value?.notification?.title != null) {
        debugPrint(
          "background background notification data =-=-=-=-=-> ${value!.data}",
        );

        if (kDebugMode) {
          utils.showToast(message: "${value.data}");
        }
      }
    });

    FirebaseMessaging.onMessage.listen(showFlutterNotification);
  }

  void showFlutterNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        payload: jsonEncode(message.data),

        /// send data by foreground notification
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
    }
  }

  // void notificationPermission() async {
  //   NotificationSettings settings = await firebaseMessaging.requestPermission(
  //     sound: true,
  //     badge: true,
  //     alert: true,
  //     announcement: false,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //   );
  //
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //   } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  //   } else {}
  // }

  oneSignalSetUp() {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.initialize(
      Platform.isAndroid
          ? "ef773b43-280b-4225-aebb-f157ffdde420"
          : "ef773b43-280b-4225-aebb-f157ffdde420",
    );

    // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {});

    // OneSignal.Notifications.addForegroundWillDisplayListener((event) {
    //   debugPrint(
    //     'NOTIFICATION WILL DISPLAY LISTENER CALLED WITH: ${event.notification.jsonRepresentation()}',
    //   );

    //   /// Display Notification, preventDefault to not display
    //   event.preventDefault();

    //   /// Do async work

    //   /// notification.display() to display after preventing default
    //   event.notification.display();
    // });
    // OneSignal.Notifications.addClickListener((result) {
    //   if (result.notification.additionalData != null && result.notification.additionalData != {}) {
    //     if (result.notification.additionalData?['type'] != null) {
    //       goToOfferPageWithCondition(condition: result.notification.additionalData?['type']);
    //     }
    //   }
    // });

    // OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
    //   printAction("setPermissionObserver $changes");
    // });

    // OneSignal.shared.setSubscriptionObserver((OSSubscriptionStateChanges changes) {
    //   printAction("setSubscriptionObserver $changes");
    // });

    // OneSignal.shared.setEmailSubscriptionObserver((OSEmailSubscriptionStateChanges emailChanges) {
    //   printAction("setEmailSubscriptionObserver $emailChanges");
    // });

    // OneSignal.User.getDeviceState().then((deviceState) {
    //   if (deviceState != null && kDebugMode) {}
    // });
  }

  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  void logCustomEvent({required String userId}) async {
    await analytics.logEvent(
      name: 'screen_view',
      parameters: {'screen_name': 'splash_screen', 'user_id': userId},
    );
  }

  @override
  Future<void> onInit() async {
    // firebaseNotificationInit();
    oneSignalSetUp();
    handleInitialUri();
    handleIncomingLinks();

    if (Platform.isIOS) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final status =
            await AppTrackingTransparency.requestTrackingAuthorization();
      });
    }
    nextScreen();
    super.onInit();
  }

  @override
  onReady() {
    AppsFlyerController.afStart();
  }

  void nextScreen() {
    getDeviceId();
  }

  Future<String?> getAndroidToken() async {
    String? deviceToken = await GetAndroidDeviceID().getDeviceId();
    printAction('deviceTokendeviceTokendeviceToken  $deviceToken');
    getStorageData.saveString(getStorageData.deviceId, deviceToken);
    return deviceToken;
  }

  void getDeviceId() async {
    LoginData loginData = LoginData();
    if (Platform.isAndroid) {
      if (getStorageData.containKey(getStorageData.loginData)) {
        if (getStorageData.readObject(getStorageData.loginData) != {}) {
          printAction(
            "getStorageData.loginDatagetStorageData.loginDatagetStorageData.loginData",
          );
          loginData = LoginData.fromJson(
            getStorageData.readObject(getStorageData.loginData),
          );
        }
      }
    } else {
      if (getStorageData.containKey(getStorageData.loginData)) {
        if (getStorageData.readObject(getStorageData.loginData) != {}) {
          loginData = LoginData.fromJson(
            getStorageData.readObject(getStorageData.loginData),
          );
        }
      }
    }

    if (utils.isValidationEmpty(loginData.userId)) {
      if (Platform.isAndroid) {
        String? deviceId = await getAndroidToken();
        if (deviceId != null) {
          await loginAPI(deviceId);
        }
      } else if (Platform.isIOS) {
        const storage = FlutterSecureStorage();
        String? keyChainValue = await storage.read(key: "aichatsy_uuid");
        if (keyChainValue != null) {
          getStorageData.saveString(getStorageData.deviceId, keyChainValue);
          await loginAPI(keyChainValue);
        } else {
          String? deviceId;
          String myUuid = generateUuid();

          deviceId = await storeUuidInKeychain('aichatsy_uuid', myUuid);
          getStorageData.saveString(getStorageData.deviceId, deviceId);
          await loginAPI(deviceId);
        }
      }
    } else {
      // if (kDebugMode) getStorageData.removeData(getStorageData.isIntro);

      logCustomEvent(userId: loginData.userId.toString());

      if (getStorageData.containKey(getStorageData.isIntro).log) {
        Future.delayed(const Duration(seconds: 3), () {
          Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
        });
      } else {
        getIntroDetailsAPI();
      }
    }
  }

  String generateUuid() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  Future<String?> storeUuidInKeychain(String key, String value) async {
    const storage = FlutterSecureStorage();

    String? myUuid = await storage.read(key: key);
    if (myUuid != null) {
      return myUuid;
    } else {
      await storage.write(key: key, value: value);
      String? myUuid = await storage.read(key: key);
      return myUuid;
    }
  }

  void getIntroDetailsAPI() async {
    // final data = await APIFunction().apiCall(apiName: Constants.getIntroData, params: FormData(), isLoading: false);
    GetIntroDataModel model = GetIntroDataModel.fromJson({
      "data": {
        "modelList": [
          {
            "info_id": "1",
            "img": "${Constants.imageBaseUrl}intro_img/GPT-4o.png",
            "description": "GPT-4o",
            "type": "model",
            "is_active": "1",
          },
          {
            "info_id": "2",
            "img": "${Constants.imageBaseUrl}intro_img/Gemini.png",
            "description": "Gemini",
            "type": "model",
            "is_active": "1",
          },
          {
            "info_id": "3",
            "img": "${Constants.imageBaseUrl}intro_img/Claude.png",
            "description": "Claude",
            "type": "model",
            "is_active": "1",
          },
          {
            "info_id": "4",
            "img": "${Constants.imageBaseUrl}intro_img/GPT-mini.png",
            "description": "GPT mini",
            "type": "model",
            "is_active": "1",
          },
        ],
        "toolList": [
          {
            "info_id": "5",
            "img": "${Constants.imageBaseUrl}intro_img/Summarize-Document.png",
            "description": "Summarize Document",
            "type": "tool",
            "is_active": "1",
          },
          {
            "info_id": "6",
            "img": "${Constants.imageBaseUrl}intro_img/Summarize-Website.png",
            "description": "Summarize Website",
            "type": "tool",
            "is_active": "1",
          },
          {
            "info_id": "7",
            "img": "${Constants.imageBaseUrl}intro_img/Image-Scan.png",
            "description": "Image Scan",
            "type": "tool",
            "is_active": "1",
          },
          {
            "info_id": "8",
            "img": "${Constants.imageBaseUrl}intro_img/Text-Scan.png",
            "description": "Text Scan",
            "type": "tool",
            "is_active": "1",
          },
          {
            "info_id": "9",
            "img": "${Constants.imageBaseUrl}intro_img/Image-Generation.png",
            "description": "Image Generation",
            "type": "tool",
            "is_active": "1",
          },
          {
            "info_id": "10",
            "img": "${Constants.imageBaseUrl}intro_img/Youtube-Summary.png",
            "description": "Youtube Summary",
            "type": "tool",
            "is_active": "1",
          },
          {
            "info_id": "11",
            "img": "${Constants.imageBaseUrl}intro_img/Real-time-Web.png",
            "description": "Real time Web",
            "type": "tool",
            "is_active": "1",
          },
        ],
        "solveProblemList": [
          {
            "info_id": "17",
            "img": "${Constants.imageBaseUrl}intro_img/weather.png",
            "description": "Instant info on news, weather & more.",
            "type": "solve_problem",
            "is_active": "1",
          },
          {
            "info_id": "18",
            "img": "${Constants.imageBaseUrl}intro_img/creative-images.png",
            "description": "Generate unlimited creative images.",
            "type": "solve_problem",
            "is_active": "1",
          },
          {
            "info_id": "19",
            "img": "${Constants.imageBaseUrl}intro_img/translate.png",
            "description": "Translate and chat in multiple languages.",
            "type": "solve_problem",
            "is_active": "1",
          },
          {
            "info_id": "21",
            "img": "${Constants.imageBaseUrl}intro_img/smart_productivity.png",
            "description": "Boost productivity with smart AI tools.",
            "type": "solve_problem",
            "is_active": "1",
          },
          {
            "info_id": "22",
            "img": "${Constants.imageBaseUrl}intro_img/navigate.png",
            "description": "Navigate a simple, user-friendly app.",
            "type": "solve_problem",
            "is_active": "1",
          },
        ],
        "languageList": [
          {
            "info_id": "12",
            "img": "${Constants.imageBaseUrl}intro_img/uk.png",
            "description": "English",
            "type": "language",
            "is_active": "1",
          },
          {
            "info_id": "13",
            "img": "${Constants.imageBaseUrl}intro_img/Spain.png",
            "description": "Spanish",
            "type": "language",
            "is_active": "1",
          },
          {
            "info_id": "14",
            "img": "${Constants.imageBaseUrl}intro_img/India.png",
            "description": "Hindi",
            "type": "language",
            "is_active": "1",
          },
          {
            "info_id": "15",
            "img": "${Constants.imageBaseUrl}intro_img/France.png",
            "description": "France",
            "type": "language",
            "is_active": "1",
          },
          {
            "info_id": "16",
            "img": "${Constants.imageBaseUrl}intro_img/Portugal.png",
            "description": "Portuguese",
            "type": "language",
            "is_active": "1",
          },
        ],
        "intro_1": ImagePath.intro1,
        "intro_2": ImagePath.intro2,
        "intro_3": ImagePath.intro3,
        "happy_users": ImagePath.happyUsers,
        "problem_solving_tasks": ImagePath.problemSolvingTasks,
        "notifications": ImagePath.notifications,
        "video_link": "${Constants.imageBaseUrl}images/video_intro.mp4",
        "did_u_know": "${Constants.imageBaseUrl}images/did_u_know.png",
      },
      "ResponseCode": 1,
      "ResponseMsg": "List retrieved successfully.",
      "Result": "True",
      "ServerTime": "UTC",
    });
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(Routes.INTRO1_SCREEN, arguments: {"data": model.data});
    });
  }

  /// ---Login Api ----------->>
  loginAPI(String? deviceId) async {
    if (utils.isValidationEmpty(
      GetStorageData().readString(GetStorageData().deviceToken),
    )) {
      FirebaseMessaging.instance.getToken().then((firebaseToken) async {
        // utils.showToast(message: "Device Token $firebaseToken");
        getStorageData.saveString(getStorageData.deviceToken, firebaseToken);
        // utils.showToast(message: "Device Token ${GetStorageData().readString(GetStorageData().deviceId)}");
      });
    }
    FormData formData = FormData.fromMap({
      'device_id': deviceId,
      'device_type': Platform.isAndroid ? "Android" : "ios",
      "device_token": getStorageData.readString(getStorageData.deviceToken),
    });
    final data = await APIFunction().apiCall(
      apiName: Constants.loginNew,
      params: formData,
      isLoading: false,
    );
    LoginModel model = LoginModel.fromJson(data);
    if (model.responseCode == 1) {
      Global.saveLoginData(data: model.data);
      logCustomEvent(userId: model.data!.userId.toString());

      if (getStorageData.containKey(getStorageData.isIntro)) {
        Get.offAllNamed(Routes.BOTTOM_NAVIGATION);
      } else {
        getIntroDetailsAPI();
        // Get.offAllNamed(Routes.INTRO1_SCREEN);
      }
    } else if (model.responseCode == 0) {
      errorDialog("Something went wrong, please try after sometime");
    } else if (model.responseCode == 26) {
      updateDialog(model.responseMsg);
    }
  }

  final bool _initialUriIsHandled = false;
  Uri? _latestUri;
  StreamSubscription? sub;

  void goToOfferPageWithCondition({required String condition}) {
    if (condition == Constants.offer25) {
      if (Get.isRegistered<BottomNavigationController>()) {
        SpecialOfferScreenView.route()?.then((value) {
          if (value == "plan_purchase") {
            Get.find<BottomNavigationController>().getUserProfileAPI(
              isLoading: true,
            );
          }
        });
      } else {
        Global.offerType = condition;
      }
    } else if (condition == Constants.offer35) {
      if (Get.isRegistered<BottomNavigationController>()) {
        OfferScreenView.route()?.then((value) {
          if (value == "plan_purchase") {
            Get.find<BottomNavigationController>().getUserProfileAPI(
              isLoading: true,
            );
          }
        });
      } else {
        Global.offerType = condition;
      }
    }
  }

  Future<void> handleInitialUri() async {
    /* if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          debugPrint('no initial uri found');
        } else {
          debugPrint('got initial uri is this : $uri');
          String getUrl = uri.toString();
          printAction('getUrl first--------<<<<----->>>>>$getUrl');
          printAction(' verify id is this  --------------<<<<-----$_latestUri');

          if (getStorageData.containKey(getStorageData.loginData)) {
            if (getUrl.contains("share/")) {
              String argumentValue = utf8.fuse(base64).decode(getUrl.split('share/').last);
              printAction('argument first--------<<<<----->>>>>$argumentValue');
              goToOfferPageWithCondition(condition: argumentValue);
            }
          } else {
            Utils().showToast(message: 'Please login your account');
          }
        }
      } on PlatformException {
        debugPrint('failed to get initial uri');
      } on FormatException {
        debugPrint('malformed initial uri');
      }
    }*/
  }

  Future<void> handleIncomingLinks() async {
    /*if (!kIsWeb) {
      sub = uriLinkStream.listen((Uri? uri) async {
        debugPrint("latest url is not null--------------<<<<----$uri");
        _latestUri = uri;
        if (_latestUri != null) {
          String getUrl = _latestUri.toString();
          printAction('getUrl second--------<<<<----->>>>>$getUrl');
          if (getStorageData.containKey(getStorageData.loginData)) {
            if (getUrl.contains("share/")) {
              String argumentValue = utf8.fuse(base64).decode(getUrl.split('share/').last);

              printAction('argument first--------<<<<----->>>>>$argumentValue');
              goToOfferPageWithCondition(condition: argumentValue);
            }
          } else {
            Utils().showToast(message: 'Please login your account');
          }
        } else {
          printAction('latest url is null');
        }
      }, onError: (Object err) {});
    }*/
  }
}
