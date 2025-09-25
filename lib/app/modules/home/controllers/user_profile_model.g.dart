// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileModel _$UserProfileModelFromJson(Map<String, dynamic> json) =>
    UserProfileModel(
      data:
          json['data'] == null
              ? null
              : UserProfileData.fromJson(json['data'] as Map<String, dynamic>),
      responseCode: (json['ResponseCode'] as num?)?.toInt(),
      responseMsg: json['ResponseMsg'] as String?,
      result: json['Result'] as String?,
      serverTime: json['ServerTime'] as String?,
    );

Map<String, dynamic> _$UserProfileModelToJson(UserProfileModel instance) =>
    <String, dynamic>{
      'data': instance.data?.toJson(),
      'ResponseCode': instance.responseCode,
      'ResponseMsg': instance.responseMsg,
      'Result': instance.result,
      'ServerTime': instance.serverTime,
    };

UserProfileData _$UserProfileDataFromJson(Map<String, dynamic> json) =>
    UserProfileData(
      userDtl:
          json['user_dtl'] == null
              ? null
              : LoginData.fromJson(json['user_dtl'] as Map<String, dynamic>),
      aiModels:
          (json['ai_models'] as List<dynamic>?)
              ?.map((e) => ToolsModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      toolsList:
          (json['tools_list'] as List<dynamic>?)
              ?.map((e) => ToolsModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      gptApiKey: UserProfileData._decryptAPIKey(json['gpt_api_key'] as String?),
      geminiApiKey: UserProfileData._decryptAPIKey(
        json['gemini_api_key'] as String?,
      ),
      youtubeApiKey: UserProfileData._decryptAPIKey(
        json['youtube_api_key'] as String?,
      ),
      weatherKey: UserProfileData._decryptAPIKey(
        json['weather_key'] as String?,
      ),
      deepSeekApiKey: UserProfileData._decryptAPIKey(
        json['deepseek_api_key'] as String?,
      ),
      systemPromptGPT: json['system_prompt_gpt'] as String?,
      systemPromptGemini: json['system_prompt_gemini'] as String?,
      elevenLabVoiceKey: UserProfileData._decryptAPIKey(
        json['eleven_lab_voice_key'] as String?,
      ),
      realTimeGptModel: json['real_time_gpt_model'] as String?,
      realTimeGeminiModel: json['real_time_gemini_model'] as String?,
      isShowElevenLab: json['is_show_eleven_lab'] as String?,
      tavilyApiKey: UserProfileData._decryptAPIKey(
        json['tavily_api_key'] as String?,
      ),
      gptTemperature: json['gpt_temperature'] as String?,
      followUpQuestionPrompt: json['follow_up_question_prompt'] as String?,
      voiceDtl:
          json['voice_dtl'] == null
              ? null
              : VoiceDtl.fromJson(json['voice_dtl'] as Map<String, dynamic>),
      magic_stick_prompt: json['magic_stick_prompt'] as String?,
    );

Map<String, dynamic> _$UserProfileDataToJson(
  UserProfileData instance,
) => <String, dynamic>{
  'user_dtl': instance.userDtl?.toJson(),
  'ai_models': instance.aiModels?.map((e) => e.toJson()).toList(),
  'tools_list': instance.toolsList?.map((e) => e.toJson()).toList(),
  'gpt_api_key': UserProfileData._encryptAPIKey(instance.gptApiKey),
  'gemini_api_key': UserProfileData._encryptAPIKey(instance.geminiApiKey),
  'eleven_lab_voice_key': UserProfileData._encryptAPIKey(
    instance.elevenLabVoiceKey,
  ),
  'youtube_api_key': UserProfileData._encryptAPIKey(instance.youtubeApiKey),
  'weather_key': UserProfileData._encryptAPIKey(instance.weatherKey),
  'tavily_api_key': UserProfileData._encryptAPIKey(instance.tavilyApiKey),
  'deepseek_api_key': UserProfileData._encryptAPIKey(instance.deepSeekApiKey),
  'is_show_eleven_lab': instance.isShowElevenLab,
  'system_prompt_gpt': instance.systemPromptGPT,
  'gpt_temperature': instance.gptTemperature,
  'follow_up_question_prompt': instance.followUpQuestionPrompt,
  'system_prompt_gemini': instance.systemPromptGemini,
  'real_time_gpt_model': instance.realTimeGptModel,
  'real_time_gemini_model': instance.realTimeGeminiModel,
  'voice_dtl': instance.voiceDtl?.toJson(),
  'magic_stick_prompt': instance.magic_stick_prompt,
};

VoiceDtl _$VoiceDtlFromJson(Map<String, dynamic> json) => VoiceDtl(
  voiceId: json['voice_id'] as String?,
  name: json['name'] as String?,
  img: json['img'] as String?,
  isActive: json['is_active'] as String?,
  elevenLabId: json['eleven_lab_id'] as String?,
  isSelected: json['is_selected'] as String?,
);

Map<String, dynamic> _$VoiceDtlToJson(VoiceDtl instance) => <String, dynamic>{
  'voice_id': instance.voiceId,
  'name': instance.name,
  'img': instance.img,
  'is_active': instance.isActive,
  'eleven_lab_id': instance.elevenLabId,
  'is_selected': instance.isSelected,
};

ToolsModel _$ToolsModelFromJson(Map<String, dynamic> json) => ToolsModel(
  modelId: json['model_id'] as String?,
  logo: json['logo'] as String?,
  model: json['model'] as String?,
  isPremium: json['is_premium'] as String?,
  isActive: json['is_active'] as String?,
  type: json['type'] as String?,
  name: json['name'] as String?,
  modelType: $enumDecodeNullable(_$ModelTypeEnumMap, json['model_type']),
  isComingSoon: json['is_coming_soon'] as String?,
  defaultLogo: json['default_logo'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$ToolsModelToJson(ToolsModel instance) =>
    <String, dynamic>{
      'model_id': instance.modelId,
      'logo': instance.logo,
      'model': instance.model,
      'is_premium': instance.isPremium,
      'is_active': instance.isActive,
      'type': instance.type,
      'name': instance.name,
      'model_type': _$ModelTypeEnumMap[instance.modelType],
      'default_logo': instance.defaultLogo,
      'description': instance.description,
      'is_coming_soon': instance.isComingSoon,
    };

const _$ModelTypeEnumMap = {
  ModelType.chatGPTMini: 'chat_gpt_mini',
  ModelType.chatGPT4o: 'chat_gpt_4o',
  ModelType.gemini: 'gemini',
  ModelType.deepSeek: 'deepseek',
  ModelType.summarizeDoc: 'summarize_doc',
  ModelType.summarizeWeb: 'summarize_web',
  ModelType.imageScan: 'image_scan',
  ModelType.textScan: 'text_scan',
  ModelType.imageGeneration: 'image_generation',
  ModelType.youtubeSummarize: 'youtube_summarize',
  ModelType.realTimeWeb: 'real_time_web',
};
