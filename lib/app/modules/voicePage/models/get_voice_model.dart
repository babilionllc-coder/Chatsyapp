import '../../home/controllers/user_profile_model.dart';

class GetVoiceModel {
  final VoiceData? data;
  final int? responseCode;
  final String? responseMsg;
  final String? result;
  final String? serverTime;

  GetVoiceModel({
    this.data,
    this.responseCode,
    this.responseMsg,
    this.result,
    this.serverTime,
  });

  GetVoiceModel.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as Map<String, dynamic>?) != null ? VoiceData.fromJson(json['data'] as Map<String, dynamic>) : null,
        responseCode = json['ResponseCode'] as int?,
        responseMsg = json['ResponseMsg'] as String?,
        result = json['Result'] as String?,
        serverTime = json['ServerTime'] as String?;

  Map<String, dynamic> toJson() => {'data': data?.toJson(), 'ResponseCode': responseCode, 'ResponseMsg': responseMsg, 'Result': result, 'ServerTime': serverTime};
}

class VoiceData {
  final List<VoiceDtl>? voiceList;

  VoiceData({
    this.voiceList,
  });

  VoiceData.fromJson(Map<String, dynamic> json) : voiceList = (json['voice_list'] as List?)?.map((dynamic e) => VoiceDtl.fromJson(e as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() => {'voice_list': voiceList?.map((e) => e.toJson()).toList()};
}
