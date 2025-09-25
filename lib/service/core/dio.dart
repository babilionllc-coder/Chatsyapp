import 'dart:io';

import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/extension.dart';
import 'package:chatsy/service/core/interceptor.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AppClient extends DioForNative {
  factory AppClient() => _instance;

  static final AppClient _instance = AppClient._internal();

  AppClient._internal()
    : super(
        BaseOptions(
          baseUrl: Constants.baseUrl,
          connectTimeout: const Duration(seconds: 200),
          receiveTimeout: const Duration(seconds: 200),
          headers: {
            'key': Constants.apiKey,
            // 'token': token,
            // 'VERSIONCODE': version,
            // 'lang': Utils.languageCodeDefault,
            'DEVICETYPE': Platform.isAndroid ? "Android" : "Ios",
          },
        ),
      ) {
    interceptors.addAll([
      RefreshTokenInterceptor(dio: this),
      if (kDebugMode) PrettyDioLogger(request: true, logPrint: (object) => object.log),
    ]);
  }
}
