// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse(
  responseCode: (json['ResponseCode'] as num).toInt(),
  responseMsg: json['ResponseMsg'] as String,
  result: json['Result'] as String,
  data: json['data'] as Map<String, dynamic>,
);

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'ResponseCode': instance.responseCode,
      'ResponseMsg': instance.responseMsg,
      'Result': instance.result,
      'data': instance.data,
    };

RawBaseResponse _$RawBaseResponseFromJson(Map<String, dynamic> json) =>
    RawBaseResponse(
      responseCode: (json['ResponseCode'] as num).toInt(),
      responseMsg: json['ResponseMsg'] as String,
      result: json['Result'] as String,
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$RawBaseResponseToJson(RawBaseResponse instance) =>
    <String, dynamic>{
      'ResponseCode': instance.responseCode,
      'ResponseMsg': instance.responseMsg,
      'Result': instance.result,
      'data': instance.data,
    };
