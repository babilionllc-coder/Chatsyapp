import 'dart:io';

import 'package:chatsy/app/api_repository/loading.dart';
import 'package:chatsy/extension.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../main.dart';
import '../helper/all_imports.dart';

class HttpUtil {
  static String isAssistant = "isAssistant";
  static String isModel = "is_model";
  static String isTextScan = "isTextScan";
  static String assistantData = "assistantData";
  static String isSignUp = "is_sign_up";
  static String imagePath = "imagePath";
  static String imageSize = "imageSize";
  static String profileImg = "profile_img";
  static String cookie = "Cookie";
  static String summarizeDocument = "summarizeDocument";
  static String toolModel = "toolModel";
  static String userName = "name";
  static String email = "email";
  static String password = "password";
  static String confirmPassword = "confirm_password";
  static String otp = "otp";
  static String newPassword = "new_pass";
  static String deviceId = "device_id";
  static String deviceToken = "device_token";

  static String type = "type";
  static String data = "data";
  static String regenerate = "Regenerate";
  static String createAnother = "Create Another";
  static String deviceType = "device_type";
  static String chatItemList = "chat_item_list";
  static String fileName = "file_name";
  static String fileSize = "file_size";
  static String fileText = "file_text";
  static String title = "title";
  static String youtubeTitle = "youtube_title";
  static String link = "link";
  static String deleteImage = "delete_image";
  static String imageText = "image_text";
  static String isRealTime = "is_real_time";

  factory HttpUtil(String token, bool isLoading) => _instance(token, isLoading);

  static HttpUtil _instance(token, isLoading) =>
      HttpUtil._internal(token: token, isLoading: isLoading);

  late Dio dio;
  static CancelToken cancelToken = CancelToken();
  String apiUrl = Constants.baseUrl;
  Utils utils = Utils();
  BuildContext? context;

  HttpUtil._internal({String? token, bool? isLoading}) {
    printAction("version is  $version");
    printAction("Utils.languageCodeDefault  ${Utils.languageCodeDefault}");
    if (utils.isValidationEmpty(token)) {
      token = getStorageData.readString(getStorageData.token);
    }
    BaseOptions options = BaseOptions(
      baseUrl: apiUrl,
      connectTimeout: const Duration(seconds: 200),
      receiveTimeout: const Duration(seconds: 200),
      headers: {
        'key': Constants.apiKey,
        'token': token,
        'VERSIONCODE': version,
        'lang': Utils.languageCodeDefault,
        'DEVICETYPE': Platform.isAndroid ? "Android" : "Ios",
      },
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );

    dio = Dio(options);
    CookieJar cookieJar = CookieJar();
    dio.interceptors.add(CookieManager(cookieJar));

    if (kDebugMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          logPrint: (object) => object.log,
        ),
      );
    }
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (isLoading!) {
            Loading.show();
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (isLoading!) {
            Loading.dismiss();
          }

          return handler.next(response); // continue
        },
        onError: (e, handler) {
          Loading.dismiss();

          onError(createErrorEntity(e), Get.context!);
          return handler.next(e); //continue
        },
      ),
    );
  }

  // On Error....
  void onError(ErrorEntity eInfo, BuildContext context) {
    printError("error.code -> ${eInfo.code}, error.message -> ${eInfo.message}");
    Loading.dismiss();
    
    // Show user-friendly error messages
    String userMessage = eInfo.message;
    if (eInfo.code == -8 || eInfo.code == -5 || eInfo.code == -6 || eInfo.code == -7) {
      userMessage = "Please check your internet connection and try again";
    } else if (eInfo.code == -2 || eInfo.code == -3 || eInfo.code == -4) {
      userMessage = "Connection timeout. Please try again";
    }
    
    if (userMessage.isNotEmpty) {
      utils.showToast(message: userMessage);
    }
  }

  ErrorEntity createErrorEntity(DioError error) {
    Loading.dismiss();
    debugPrint("-=-error.type ${error.type}");
    switch (error.type) {
      /// TODO API request cancel time comment
      //case DioErrorType.cancel:
      //    return ErrorEntity(code: -1, message: "Request to server was cancelled");
      case DioErrorType.connectionTimeout:
        return ErrorEntity(code: -2, message: "Connection timeout with server");
      case DioErrorType.sendTimeout:
        return ErrorEntity(code: -3, message: "Send timeout in connection with server");
      case DioErrorType.receiveTimeout:
        return ErrorEntity(code: -4, message: "Receive timeout in connection with server");

      case DioErrorType.connectionError:
        return ErrorEntity(
          code: -8,
          message: "Your internet is not available, please try again later",
        );

      case DioErrorType.cancel:
        return ErrorEntity(code: -4, message: "");
      case DioErrorType.badResponse:
        {
          try {
            int errCode = error.response != null ? error.response!.statusCode! : 00;
            switch (errCode) {
              case 400:
                return ErrorEntity(code: errCode, message: "Request syntax error");
              case 401:
                return ErrorEntity(code: errCode, message: "Permission denied");
              case 403:
                return ErrorEntity(code: errCode, message: "Server refuses to execute");
              case 404:
                return ErrorEntity(code: errCode, message: "Can not reach server");
              case 405:
                return ErrorEntity(code: errCode, message: "Request method is forbidden");
              case 500:
                return ErrorEntity(code: errCode, message: "Internal server error");
              case 502:
                return ErrorEntity(code: errCode, message: "Invalid request");
              case 503:
                return ErrorEntity(code: errCode, message: "Server hangs");
              case 505:
                return ErrorEntity(
                  code: errCode,
                  message: "HTTP protocol requests are not supported",
                );
              default:
                return ErrorEntity(
                  code: errCode,
                  message: error.response != null ? error.response!.data! : "",
                );
            }
          } on Exception catch (_) {
            return ErrorEntity(code: 00, message: "Unknown mistake");
          }
        }
      case DioErrorType.unknown:
        if (error.message!.contains("SocketException")) {
          return ErrorEntity(
            code: -5,
            message: "Your internet is not available, please try again later",
          );
        } else if (error.message!.contains("Software caused connection abort")) {
          return ErrorEntity(
            code: -6,
            message: "Your internet is not available, please try again later",
          );
        }
        return ErrorEntity(
          code: -7,
          message: "Your internet is not available, please try again later",
        );
      default:
        return ErrorEntity(
          code: -8,
          message: "Your internet is not available, please try again later",
        );
    }
  }

  static void cancelRequests() {
    Loading.dismiss();
    cancelToken.cancel("cancelled");

    HttpUtil.cancelToken = CancelToken();
  }

  static void conectRequests() {
    // cancelToken.;
  }

  /// restful get
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool refresh = false,
    bool noCache = true,
    bool list = false,
    String cacheKey = '',
    bool cacheDisk = false,
  }) async {
    Options requestOptions = options ?? Options();
    requestOptions.extra ??= {};
    requestOptions.extra!.addAll({
      "refresh": refresh,
      "noCache": noCache,
      "list": list,
      "cacheKey": cacheKey,
      "cacheDisk": cacheDisk,
    });

    var response = await dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful post
  Future post(
    String path, {
    FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    Map<String, String>? headers,
  }) async {
    Options requestOptions = options ?? Options();
    // DateTime startTime = DateTime.now();

    var response = await dio.post(
      path,
      data: data,

      queryParameters: queryParameters,
      options: requestOptions.copyWith(headers: headers),
      cancelToken: cancelToken,
    );
    // debugPrint("-=--end DateTime.now ${DateTime.now()} ");
    // DateTime endTime = DateTime.now();
    // Duration difference = endTime.difference(startTime);
    //
    // debugPrint('Duration: ${difference.inMilliseconds} milliseconds');

    return response.data;
  }

  /// restful put
  Future put(
    String path, {
    FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful delete
  Future delete(
    String path, {
    FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful patch
  Future patch(
    String path, {
    FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful post form
  Future postForm(
    String path, {
    FormData? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    var response = await dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  /// restful post Stream
  Future postStream(
    String path, {
    dynamic data,
    int dataLength = 0,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();

    requestOptions.headers!.addAll({Headers.contentLengthHeader: dataLength.toString()});
    var response = await dio.post(
      path,
      data: Stream.fromIterable(data.map((e) => [e])),
      queryParameters: queryParameters,
      options: requestOptions,
      cancelToken: cancelToken,
    );
    return response.data;
  }
}

class ErrorEntity implements Exception {
  int code = -1;
  String message = "";

  ErrorEntity({required this.code, required this.message});

  @override
  String toString() {
    if (message == "") return "Exception";
    return "Exception: code $code, $message";
  }
}
