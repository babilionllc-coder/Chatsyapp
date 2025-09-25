// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phm_id_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhmIdModel _$PhmIdModelFromJson(Map<String, dynamic> json) => PhmIdModel(
  data:
      json['data'] == null
          ? null
          : PhmIdModelData.fromJson(json['data'] as Map<String, dynamic>),
  remainingChatLimit: json['remainingChatLimit'] as String?,
  phmId: json['phmId'] as String?,
  responseCode: (json['responseCode'] as num?)?.toInt(),
  responseMsg: json['responseMsg'] as String?,
  result: json['result'] as String?,
  serverTime: json['serverTime'] as String?,
);

Map<String, dynamic> _$PhmIdModelToJson(PhmIdModel instance) =>
    <String, dynamic>{
      'data': instance.data,
      'remainingChatLimit': instance.remainingChatLimit,
      'phmId': instance.phmId,
      'responseCode': instance.responseCode,
      'responseMsg': instance.responseMsg,
      'result': instance.result,
      'serverTime': instance.serverTime,
    };

PhmIdModelData _$PhmIdModelDataFromJson(Map<String, dynamic> json) =>
    PhmIdModelData(
      scmId: json['scmId'] as String?,
      phmId: json['phmId'] as String?,
      userId: json['userId'] as String?,
      question: json['question'] as String?,
      answer: json['answer'] as String?,
      media: json['media'] as String?,
      mediaType: json['mediaType'] as String?,
      promptId: json['promptId'] as String?,
      toolsType: json['toolsType'] as String?,
      fileName: json['fileName'] as String?,
      fileSize: json['fileSize'] as String?,
      createdAt: json['createdAt'] as String?,
      link: json['link'] as String?,
      isHide: json['isHide'] as String?,
      assistantQuestionId: json['assistantQuestionId'] as String?,
      aiAnsType: json['aiAnsType'] as String?,
      img: json['img'] as String?,
      isUpgraded: json['isUpgraded'] as bool?,
      revisedPrompt: json['revisedPrompt'] as String?,
      newQuestionList:
          (json['newQuestionList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
    );

Map<String, dynamic> _$PhmIdModelDataToJson(PhmIdModelData instance) =>
    <String, dynamic>{
      'scmId': instance.scmId,
      'phmId': instance.phmId,
      'userId': instance.userId,
      'question': instance.question,
      'answer': instance.answer,
      'media': instance.media,
      'mediaType': instance.mediaType,
      'promptId': instance.promptId,
      'toolsType': instance.toolsType,
      'fileName': instance.fileName,
      'fileSize': instance.fileSize,
      'link': instance.link,
      'isHide': instance.isHide,
      'assistantQuestionId': instance.assistantQuestionId,
      'aiAnsType': instance.aiAnsType,
      'img': instance.img,
      'revisedPrompt': instance.revisedPrompt,
      'isUpgraded': instance.isUpgraded,
      'createdAt': instance.createdAt,
      'newQuestionList': instance.newQuestionList,
    };
