// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_assistants_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssistantsModel _$AssistantsModelFromJson(Map<String, dynamic> json) =>
    AssistantsModel(
      data:
          (json['data'] as List<dynamic>)
              .map((e) => AssistantData.fromJson(e as Map<String, dynamic>))
              .toList(),
      totalData: (json['total_data'] as num?)?.toInt(),
      responseCode: (json['ResponseCode'] as num).toInt(),
      responseMsg: json['ResponseMsg'] as String,
      result: json['Result'] as String,
      serverTime: json['ServerTime'] as String?,
    );

Map<String, dynamic> _$AssistantsModelToJson(AssistantsModel instance) =>
    <String, dynamic>{
      'ResponseCode': instance.responseCode,
      'ResponseMsg': instance.responseMsg,
      'Result': instance.result,
      'data': instance.data,
      'total_data': instance.totalData,
      'ServerTime': instance.serverTime,
    };

AssistantData _$AssistantDataFromJson(Map<String, dynamic> json) =>
    AssistantData(
      assistantId: json['assistant_id'] as String?,
      assistantImg: json['assistant_img'] as String?,
      assistantTitle: json['assistant_title'] as String?,
      assistantDesc: json['assistant_desc'] as String?,
      backendPrompt: json['backend_prompt'] as String?,
      assistantQuestion:
          (json['assistant_question'] as List<dynamic>?)
              ?.map(
                (e) => AssistantQuestion.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      isLock: json['is_lock'] as String?,
      userId: json['user_id'] as String?,
      model: $enumDecodeNullable(_$AIModelEnumMap, json['model']),
    );

Map<String, dynamic> _$AssistantDataToJson(AssistantData instance) =>
    <String, dynamic>{
      'assistant_id': instance.assistantId,
      'assistant_img': instance.assistantImg,
      'assistant_title': instance.assistantTitle,
      'assistant_desc': instance.assistantDesc,
      'backend_prompt': instance.backendPrompt,
      'assistant_question': instance.assistantQuestion,
      'is_lock': instance.isLock,
      'user_id': instance.userId,
      'model': _$AIModelEnumMap[instance.model],
    };

const _$AIModelEnumMap = {AIModel.gpt4o: 'gpt4o', AIModel.gemini: 'gemini'};

CreateAssistantModel _$CreateAssistantModelFromJson(
  Map<String, dynamic> json,
) => CreateAssistantModel(
  data: AssistantData.fromJson(json['data'] as Map<String, dynamic>),
  responseCode: (json['ResponseCode'] as num).toInt(),
  responseMsg: json['ResponseMsg'] as String,
  result: json['Result'] as String,
);

Map<String, dynamic> _$CreateAssistantModelToJson(
  CreateAssistantModel instance,
) => <String, dynamic>{
  'ResponseCode': instance.responseCode,
  'ResponseMsg': instance.responseMsg,
  'Result': instance.result,
  'data': instance.data,
};
