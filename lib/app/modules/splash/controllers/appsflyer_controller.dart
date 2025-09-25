import 'dart:developer';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/foundation.dart' as found;

import '../../../helper/constants.dart';
import '../../../helper/utils.dart';

class AppsFlyerController {
  static AppsflyerSdk? appsflyerSdk;

  static void afStart() async {
    printAction("afStartafStartafStartafStartafStart");
    AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
      afDevKey: "EhjUH78c6jkbmT4YRXdLfB",
      appId: "6449819419",
      showDebug: false,
      disableAdvertisingIdentifier: true,
      timeToWaitForATTUserAuthorization: 100,
      manualStart: true,
    );
    appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
    await appsflyerSdk?.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );

    appsflyerSdk?.startSDK(
      onSuccess: () {
        found.debugPrint("AppsFlyer SDK initialized successfully.");
      },
      onError: (int errorCode, String errorMessage) {
        found.debugPrint("Error initializing AppsFlyer SDK: Code $errorCode - $errorMessage");
      },
    );
  }

  static Future<void> trackEvent({
    required String eventName,
    required Map<String, dynamic> eventValues,
  }) async {
    eventValues.addEntries(getStorageData.readObject(getStorageData.loginData).entries);

    log("-=--= eventValues $eventValues");
    Future.delayed(Duration(seconds: 2), () {
      appsflyerSdk
          ?.logEvent(eventName, eventValues)
          .then((result) {
            found.debugPrint("Event tracked successfully: $result");
          })
          .catchError((error) {
            found.debugPrint("Error tracking event: $error");
          });
    });
  }
}
