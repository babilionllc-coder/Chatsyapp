import '../../home/controllers/user_profile_model.dart';

class GetAIModelsModel {
  final List<ToolsModel>? data;
  final int? responseCode;
  final String? responseMsg;
  final String? result;
  final String? serverTime;

  GetAIModelsModel({
    this.data,
    this.responseCode,
    this.responseMsg,
    this.result,
    this.serverTime,
  });

  GetAIModelsModel.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List?)?.map((dynamic e) => ToolsModel.fromJson(e as Map<String, dynamic>)).toList(),
        responseCode = json['ResponseCode'] as int?,
        responseMsg = json['ResponseMsg'] as String?,
        result = json['Result'] as String?,
        serverTime = json['ServerTime'] as String?;

  Map<String, dynamic> toJson() => {'data': data?.map((e) => e.toJson()).toList(), 'ResponseCode': responseCode, 'ResponseMsg': responseMsg, 'Result': result, 'ServerTime': serverTime};
}
