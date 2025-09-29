import 'package:chatsy/app/helper/all_imports.dart';
import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

abstract class ApiResponse<T> {
  @JsonKey(name: 'ResponseCode')
  int responseCode;

  @JsonKey(name: 'ResponseMsg')
  String responseMsg;

  @JsonKey(name: 'Result')
  String result;

  T data;

  ApiResponse({
    required this.responseCode,
    required this.responseMsg,
    required this.result,
    required this.data,
  });

  void showToast({String? message}) {
    Get.showSnackbar(
      GetSnackBar(
        message: message ?? responseMsg,
        borderRadius: 10,
        padding: const EdgeInsets.all(12),
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}

num stringToNum(String value) {
  return num.tryParse(value) ?? 0;
}

BaseResponse deserializeBaseResponse(Map<String, dynamic> json) => BaseResponse.fromJson(json);

@JsonSerializable()
class BaseResponse extends ApiResponse<Map<String, dynamic>> {
  BaseResponse({
    required super.responseCode,
    required super.responseMsg,
    required super.result,
    required super.data,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}

@JsonSerializable()
class RawBaseResponse extends ApiResponse<Map<String, dynamic>?> {
  RawBaseResponse({
    required super.responseCode,
    required super.responseMsg,
    required super.result,
    required super.data,
  });

  factory RawBaseResponse.fromJson(Map<String, dynamic> json) => _$RawBaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RawBaseResponseToJson(this);
}
