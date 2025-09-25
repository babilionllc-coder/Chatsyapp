import 'package:chatsy/app/common_widget/error_and_update_dialog.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/main.dart';

import 'exception.dart';

class QueueRequest<T> {
  QueueRequest({required this.response, required this.handler});

  final Response response;

  final ResponseInterceptorHandler handler;

  void next() {
    handler.next(response);
  }

  Future<void> resolve(Dio dio) {
    final requestOptions = response.requestOptions;
    return dio
        .fetch(_recreate(requestOptions))
        .handler(
          null,
          isLoading: false,
          onSuccess: handler.resolve,
          onFailed: (value) {
            if (value.dioError != null) {
              debugPrintStack(
                stackTrace: value.dioError?.stackTrace,
                label: value.dioError?.response?.data.toString(),
              );
              handler.reject(value.dioError!);
            } else {
              next();
            }
          },
        );
  }

  RequestOptions _recreate(RequestOptions requestOptions) {
    FormData? data = requestOptions.data;
    if (requestOptions.data is FormData) {
      data = requestOptions.data;
    }
    return requestOptions.copyWith(
      data:
          data == null
              ? null
              : (
                FormData()
                  ..fields.addAll(data.fields)
                  ..files.addAll(data.files.map((e) => MapEntry(e.key, e.value.clone()))),
              ),
    );
  }
}

class RefreshTokenInterceptor extends Interceptor {
  RefreshTokenInterceptor({required this.dio});

  final Dio dio;

  final List<QueueRequest<dynamic>> requestQueue = [];

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    var token = getStorageData.readString(getStorageData.token);

    if (token?.isNotEmpty == true) {
      options.headers['token'] = '$token';
    }

    options.headers['VERSIONCODE'] = version;
    options.headers['lang'] = Utils.languageCodeDefault;

    super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    var data = response.data;
    if (data is Map<String, dynamic> && data.containsKey('ResponseCode')) {
      if (data['ResponseCode'] is num) {
        switch (data['ResponseCode'] as num) {
          case 26:
            NewLoading.hideLoading();
            updateDialog(data['ResponseMsg']);
            break;
          case 9:
            // if (Get.currentRoute.log != Routes.LOGIN) {
            //   await UserData.remove();
            //   LoginView.offAllRoute();
            // }
            break;
          case 401:
            await _unAuthorized();
            NewLoading.hideLoading();
            break;
          case 402:
            await _unAuthorized();
            // AppUtils.showSnackBar(message: AppStrings.T.sessionExpired);
            // NewLoading.hideLoading();
            break;
          // case 433:
          //   _queueRequest(response, handler);
          //   break;
          default:
            super.onResponse(response, handler);
        }
      }
    } else {
      super.onResponse(response, handler);
    }
  }

  Future<void> _unAuthorized() async {
    // await UserData.remove();
    // LoginView.offAllRoute()?.ignore();
  }

  // void _queueRequest(Response response, ResponseInterceptorHandler handler) {
  //   requestQueue.add(QueueRequest(response: response, handler: handler));

  //   if (refreshTokenState.isInitial) {
  //     refreshToken();
  //   }
  // }

  // final refreshTokenState = ApiState.initial().obs;

  // Future<void> refreshToken() async {
  //   await retro
  //       .refreshToken(userId: UserData.read?.user_id)
  //       .handler(
  //         refreshTokenState,
  //         isLoading: false,
  //         onSuccess: _onRefreshSuccess,
  //         onFailed: _rejectQueuedRequests,
  //       );
  // }

  // void _rejectQueuedRequests(FailedState<dynamic> value) {
  //   refreshTokenState.value = InitialState();
  //   requestQueue
  //     ..forEach((element) => element.next())
  //     ..clear();
  // }

  // Future<void> _onRefreshSuccess(UserModel value) async {
  //   refreshTokenState.value = InitialState();

  //   if (value.data.token.isNotEmpty) {
  //     await value.data.save();
  //     Future.wait(requestQueue.map((e) => e.resolve(dio))).then((_) => requestQueue.clear());
  //   } else {
  //     requestQueue
  //       ..forEach((element) => element.next())
  //       ..clear();

  //     return;
  //   }
  // }
}
