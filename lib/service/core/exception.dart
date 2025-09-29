import 'package:chatsy/app/Localization/local_language.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/extension.dart';
import 'package:chatsy/main.dart';

extension ApiHandlingExtension<T> on Future<T> {
  /// Must use handler it's a better way to handle request's response api calling
  Future<void> handler(
    Rx<ApiState>? state, {
    bool isLoading = true,
    ValueChanged<T>? onSuccess,
    ValueChanged<FailedState>? onFailed,
  }) async {
    try {
      state?.value = LoadingState<T>();
      if (isLoading) NewLoading.showLoading();
      final response = await this;
      state?.value = SuccessState<T>(response);
      onSuccess?.call(response);
    } on DioException catch (e) {
      var failedState = FailedState<T>(
        statusCode: e.response?.statusCode ?? 0,
        canceled: e.type == DioExceptionType.cancel,
        isRetirable: switch (e.type) {
          DioExceptionType.connectionError ||
          DioExceptionType.connectionTimeout ||
          DioExceptionType.sendTimeout ||
          DioExceptionType.receiveTimeout => true,
          _ => false,
        },
        dioError: e,
      );
      state?.value = failedState;
      onFailed?.call((state?.failedState ?? failedState));
    } catch (e) {
      e.log;
      FailedState<T> failedState;
      if (e is CustomException) {
        failedState = FailedState<T>(
          statusCode: 0,
          isRetirable: true,
          canceled: false,
          dioError: null,
          message: e.message,
        );
      } else {
        failedState = FailedState<T>(
          statusCode: 0,
          isRetirable: true,
          canceled: false,
          dioError: null,
        );
      }

      /// If you need more detailed information about exception so simply remove this catch
      /// after removing this catch you are able to see thrawed exception in debug console.

      state?.value = failedState;
      onFailed?.call((state?.failedState ?? failedState));
    } finally {
      if (isLoading) NewLoading.hideLoading();
    }
  }
}

class CustomException implements Exception {
  final String message;
  CustomException(this.message);
}

extension RxApiStateX<T> on Rx<ApiState<T>> {
  bool get isInitial => value is InitialState<T>;
  bool get isLoading => value is LoadingState<T>;
  bool get isSuccess => value is SuccessState<T>;
  bool get isFailed => value is FailedState<T>;

  SuccessState<T> get successState => value as SuccessState<T>;
  FailedState<T> get failedState => value as FailedState<T>;
}

extension ApiStateX<T> on ApiState<T> {
  bool get isInitial => this is InitialState<T>;
  bool get isLoading => this is LoadingState<T>;
  bool get isSuccess => this is SuccessState<T>;
  bool get isFailed => this is FailedState<T>;

  SuccessState<T> get successState => this as SuccessState<T>;
  FailedState<T> get failedState => this as FailedState<T>;
}

sealed class ApiState<T> {
  static ApiState<T> initial<T>() => InitialState<T>();
}

class SuccessState<T> extends ApiState<T> {
  T value;
  SuccessState(this.value);
}

class InitialState<T> extends ApiState<T> {}

class LoadingState<T> extends ApiState<T> {}

class FailedState<T> extends ApiState<T> {
  bool isRetirable;
  UserFriendlyError get error =>
      dioError?.toUserFriendlyError() ??
      UserFriendlyError(
        Languages.of(Get.context!)!.apiError,
        Languages.of(Get.context!)!.apiErrorDescription,
      );

  Response? get response {
    if (dioError?.response is Response) {
      return dioError!.response!;
    }
    return null;
  }

  DioException? dioError;

  int statusCode;

  bool canceled;

  final String? message;

  FailedState({
    required this.isRetirable,
    required this.statusCode,
    required this.dioError,
    required this.canceled,
    this.message,
  });

  void showToast() {
    Get.showSnackbar(
      GetSnackBar(
        // title: error.title,
        message: messageHelper,
        icon: const Icon(Icons.error_outline, color: Colors.redAccent),
        borderColor: Colors.redAccent,
        borderRadius: 10,
        padding: const EdgeInsets.all(12),
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }

  String get messageHelper {
    if (message != null) return message!;

    if (dioError?.response?.data is Map<String, dynamic>) {
      return (dioError?.response?.data as Map<String, dynamic>)['ResponseMsg'] as String? ??
          error.description;
    } else {
      return error.description;
    }
  }
}

@immutable
class UserFriendlyError {
  final String title;
  final String description;

  const UserFriendlyError(this.title, this.description);
}

extension DioExceptionX on DioException {
  /// context should pass for incase app works with Localization so the context is required
  UserFriendlyError toUserFriendlyError() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return UserFriendlyError(
          Languages.of(Get.context!)!.connectionTimeout,
          Languages.of(Get.context!)!.connectionTimeoutDesc,
        );
      case DioExceptionType.sendTimeout:
        return UserFriendlyError(
          Languages.of(Get.context!)!.sendTimeout,
          Languages.of(Get.context!)!.sendTimeoutDesc,
        );
      case DioExceptionType.receiveTimeout:
        return UserFriendlyError(
          Languages.of(Get.context!)!.receiveTimeout,
          Languages.of(Get.context!)!.receiveTimeoutDesc,
        );
      case DioExceptionType.badCertificate:
        return UserFriendlyError(
          Languages.of(Get.context!)!.badCertificate,
          Languages.of(Get.context!)!.badCertificateDesc,
        );
      case DioExceptionType.badResponse:
        return UserFriendlyError(
          Languages.of(Get.context!)!.badResponse,
          _statusCode(response?.statusCode ?? 0),
        );
      case DioExceptionType.cancel:
        return UserFriendlyError(
          Languages.of(Get.context!)!.reqCancel,
          Languages.of(Get.context!)!.reqCancelDesc,
        );
      case DioExceptionType.connectionError:
        return UserFriendlyError(
          Languages.of(Get.context!)!.connectionError,
          Languages.of(Get.context!)!.connectionErrorDesc,
        );
      case DioExceptionType.unknown:
        return UserFriendlyError(
          Languages.of(Get.context!)!.unknown,
          Languages.of(Get.context!)!.unknownDesc,
        );
    }
  }

  String _statusCode(int? statusCode) {
    return switch (statusCode) {
      200 => Languages.of(Get.context!)!.code200,
      201 => Languages.of(Get.context!)!.code201,
      202 => Languages.of(Get.context!)!.code202,
      301 => Languages.of(Get.context!)!.code301,
      302 => Languages.of(Get.context!)!.code302,
      304 => Languages.of(Get.context!)!.code304,
      400 => Languages.of(Get.context!)!.code400,
      401 => Languages.of(Get.context!)!.code401,
      403 => Languages.of(Get.context!)!.code403,
      404 => Languages.of(Get.context!)!.code404,
      405 => Languages.of(Get.context!)!.code405,
      409 => Languages.of(Get.context!)!.code409,
      500 => Languages.of(Get.context!)!.code500,
      503 => Languages.of(Get.context!)!.code503,
      _ => Languages.of(Get.context!)!.badResponseDesc,
    };
  }
}

extension DioExceptionTypeX on DioExceptionType {
  /// context should pass for incase app works with Localization so the context is required
  UserFriendlyError toUserFriendlyError() {
    switch (this) {
      case DioExceptionType.connectionTimeout:
        return UserFriendlyError(
          Languages.of(Get.context!)!.connectionTimeout,
          Languages.of(Get.context!)!.connectionTimeoutDesc,
        );
      case DioExceptionType.sendTimeout:
        return UserFriendlyError(
          Languages.of(Get.context!)!.sendTimeout,
          Languages.of(Get.context!)!.sendTimeoutDesc,
        );
      case DioExceptionType.receiveTimeout:
        return UserFriendlyError(
          Languages.of(Get.context!)!.receiveTimeout,
          Languages.of(Get.context!)!.receiveTimeoutDesc,
        );
      case DioExceptionType.badCertificate:
        return UserFriendlyError(
          Languages.of(Get.context!)!.badCertificate,
          Languages.of(Get.context!)!.badCertificateDesc,
        );
      case DioExceptionType.badResponse:
        return UserFriendlyError(
          Languages.of(Get.context!)!.badResponse,
          Languages.of(Get.context!)!.badResponseDesc,
        );
      case DioExceptionType.cancel:
        return UserFriendlyError(
          Languages.of(Get.context!)!.reqCancel,
          Languages.of(Get.context!)!.reqCancelDesc,
        );
      case DioExceptionType.connectionError:
        return UserFriendlyError(
          Languages.of(Get.context!)!.connectionError,
          Languages.of(Get.context!)!.connectionErrorDesc,
        );
      case DioExceptionType.unknown:
        return UserFriendlyError(
          Languages.of(Get.context!)!.unknown,
          Languages.of(Get.context!)!.unknownDesc,
        );
    }
  }
}
