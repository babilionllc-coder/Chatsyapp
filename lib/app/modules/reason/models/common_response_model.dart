class CommonResponseModel {
  final int? responseCode;
  final String? responseMsg;
  final String? result;
  final String? serverTime;

  CommonResponseModel({
    this.responseCode,
    this.responseMsg,
    this.result,
    this.serverTime,
  });

  CommonResponseModel.fromJson(Map<String, dynamic> json)
      : responseCode = json['ResponseCode'] as int?,
        responseMsg = json['ResponseMsg'] as String?,
        result = json['Result'] as String?,
        serverTime = json['ServerTime'] as String?;

  Map<String, dynamic> toJson() => {'ResponseCode': responseCode, 'ResponseMsg': responseMsg, 'Result': result, 'ServerTime': serverTime};
}
