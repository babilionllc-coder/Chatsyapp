class SendOtpModel {
  final int? otp;
  final int? responseCode;
  final String? responseMsg;
  final String? result;
  final String? serverTime;
  final int? totalRecords;

  SendOtpModel({
    this.otp,
    this.responseCode,
    this.responseMsg,
    this.result,
    this.serverTime,
    this.totalRecords,
  });

  SendOtpModel.fromJson(Map<String, dynamic> json)
      : otp = json['otp'] as int?,
        responseCode = json['ResponseCode'] as int?,
        responseMsg = json['ResponseMsg'] as String?,
        result = json['Result'] as String?,
        serverTime = json['ServerTime'] as String?,
        totalRecords = json['totalRecords'] as int?;

  Map<String, dynamic> toJson() => {'otp': otp, 'ResponseCode': responseCode, 'ResponseMsg': responseMsg, 'Result': result, 'ServerTime': serverTime, 'totalRecords': totalRecords};
}
