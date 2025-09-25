import '../../../../main.dart';

class ConfigDataModel {
  final Data? data;
  final int? responseCode;
  final String? responseMsg;
  final String? result;
  final String? serverTime;

  ConfigDataModel({
    this.data,
    this.responseCode,
    this.responseMsg,
    this.result,
    this.serverTime,
  });

  ConfigDataModel copyWith({
    Data? data,
    int? responseCode,
    String? responseMsg,
    String? result,
    String? serverTime,
  }) {
    return ConfigDataModel(
      data: data ?? this.data,
      responseCode: responseCode ?? this.responseCode,
      responseMsg: responseMsg ?? this.responseMsg,
      result: result ?? this.result,
      serverTime: serverTime ?? this.serverTime,
    );
  }

  ConfigDataModel.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as Map<String, dynamic>?) != null ? Data.fromJson(json['data'] as Map<String, dynamic>) : null,
        responseCode = json['ResponseCode'] as int?,
        responseMsg = json['ResponseMsg'] as String?,
        result = json['Result'] as String?,
        serverTime = json['ServerTime'] as String?;

  Map<String, dynamic> toJson() => {'data': data?.toJson(), 'ResponseCode': responseCode, 'ResponseMsg': responseMsg, 'Result': result, 'ServerTime': serverTime};
}

class Data {
  final String? isReview;

  Data({
    this.isReview,
  });

  Data copyWith({
    String? isTest,
  }) {
    return Data(
      isReview: isTest ?? isReview,
    );
  }

  Data.fromJson(Map<String, dynamic> json) : isReview = json['is_review_$version'] as String?;

  Map<String, dynamic> toJson() => {'is_review_$version': isReview};
}
