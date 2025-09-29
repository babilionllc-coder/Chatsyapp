import 'package:chatsy/app/modules/splash/controllers/login_model.dart';

class ChangeLanModel {
  final LoginData? data;
  final int? responseCode;
  final String? responseMsg;
  final String? result;
  final String? serverTime;

  ChangeLanModel({this.data, this.responseCode, this.responseMsg, this.result, this.serverTime});

  ChangeLanModel.fromJson(Map<String, dynamic> json)
    : data =
          (json['data'] as Map<String, dynamic>?) != null
              ? LoginData.fromJson(json['data'] as Map<String, dynamic>)
              : null,
      responseCode = json['ResponseCode'] as int?,
      responseMsg = json['ResponseMsg'] as String?,
      result = json['Result'] as String?,
      serverTime = json['ServerTime'] as String?;

  Map<String, dynamic> toJson() => {
    'data': data?.toJson(),
    'ResponseCode': responseCode,
    'ResponseMsg': responseMsg,
    'Result': result,
    'ServerTime': serverTime,
  };
}
