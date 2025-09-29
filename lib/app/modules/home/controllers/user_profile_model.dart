import 'package:chatsy/service/core/crypto/crypto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../splash/controllers/login_model.dart';

part 'user_profile_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserProfileModel {
  @JsonKey(name: 'data')
  final UserProfileData? data;
  @JsonKey(name: 'ResponseCode')
  final int? responseCode;
  @JsonKey(name: 'ResponseMsg')
  final String? responseMsg;
  @JsonKey(name: 'Result')
  final String? result;
  @JsonKey(name: 'ServerTime')
  final String? serverTime;

  UserProfileModel({this.data, this.responseCode, this.responseMsg, this.result, this.serverTime});

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => _$UserProfileModelFromJson(json)
  /* : data =
          (json['data'] as Map<String, dynamic>?) != null
              ? UserProfileData.fromJson(json['data'] as Map<String, dynamic>)
              : null,
      responseCode = json['ResponseCode'] as int?,
      responseMsg = json['ResponseMsg'] as String?,
      result = json['Result'] as String?,
      serverTime = json['ServerTime'] as String? */
  ;

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this)
  /* {
    'data': data?.toJson(),
    'ResponseCode': responseCode,
    'ResponseMsg': responseMsg,
    'Result': result,
    'ServerTime': serverTime,
  } */
  ;
}

@JsonSerializable(explicitToJson: true)
class UserProfileData {
  @JsonKey(name: 'user_dtl')
  final LoginData? userDtl;

  @JsonKey(name: 'ai_models')
  final List<ToolsModel>? aiModels;

  @JsonKey(name: 'tools_list')
  final List<ToolsModel>? toolsList;

  @JsonKey(name: 'gpt_api_key', fromJson: _decryptAPIKey, toJson: _encryptAPIKey)
  String? gptApiKey;

  @JsonKey(name: 'gemini_api_key', fromJson: _decryptAPIKey, toJson: _encryptAPIKey)
  String? geminiApiKey;

  @JsonKey(name: 'eleven_lab_voice_key', fromJson: _decryptAPIKey, toJson: _encryptAPIKey)
  String? elevenLabVoiceKey;

  @JsonKey(name: 'youtube_api_key', fromJson: _decryptAPIKey, toJson: _encryptAPIKey)
  String? youtubeApiKey;

  @JsonKey(name: 'weather_key', fromJson: _decryptAPIKey, toJson: _encryptAPIKey)
  String? weatherKey;

  @JsonKey(name: 'tavily_api_key', fromJson: _decryptAPIKey, toJson: _encryptAPIKey)
  String? tavilyApiKey;

  @JsonKey(name: 'deepseek_api_key', fromJson: _decryptAPIKey, toJson: _encryptAPIKey)
  String? deepSeekApiKey;

  @JsonKey(name: 'is_show_eleven_lab')
  final String? isShowElevenLab;

  @JsonKey(name: 'system_prompt_gpt')
  final String? systemPromptGPT;

  @JsonKey(name: 'gpt_temperature')
  final String? gptTemperature;

  @JsonKey(name: 'follow_up_question_prompt')
  final String? followUpQuestionPrompt;

  @JsonKey(name: 'system_prompt_gemini')
  final String? systemPromptGemini;

  @JsonKey(name: 'real_time_gpt_model')
  final String? realTimeGptModel;

  @JsonKey(name: 'real_time_gemini_model')
  final String? realTimeGeminiModel;

  @JsonKey(name: 'voice_dtl')
  final VoiceDtl? voiceDtl;

  @JsonKey(name: 'magic_stick_prompt')
  final String? magic_stick_prompt;

  UserProfileData({
    this.userDtl,
    this.aiModels,
    this.toolsList,
    this.gptApiKey,
    this.geminiApiKey,
    this.youtubeApiKey,
    this.weatherKey,
    this.deepSeekApiKey,
    this.systemPromptGPT,
    this.systemPromptGemini,
    this.elevenLabVoiceKey,
    this.realTimeGptModel,
    this.realTimeGeminiModel,
    this.isShowElevenLab,
    this.tavilyApiKey,
    this.gptTemperature,
    this.followUpQuestionPrompt,
    this.voiceDtl,
    this.magic_stick_prompt,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) => _$UserProfileDataFromJson(json)
  /* : userDtl =
          (json['user_dtl'] as Map<String, dynamic>?) != null
              ? LoginData.fromJson(json['user_dtl'] as Map<String, dynamic>)
              : null,
      aiModels =
          (json['ai_models'] as List?)
              ?.map((dynamic e) => ToolsModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      toolsList =
          (json['tools_list'] as List?)
              ?.map((dynamic e) => ToolsModel.fromJson(e as Map<String, dynamic>))
              .toList(),
      gptApiKey = json['gpt_api_key'] as String?,
      geminiApiKey = json['gemini_api_key'] as String?,
      systemPromptGPT = json['system_prompt_gpt'] as String?,
      systemPromptGemini = json['system_prompt_gemini'] as String?,
      realTimeGeminiModel = json['real_time_gemini_model'] as String?,
      elevenLabVoiceKey = json['eleven_lab_voice_key'] as String?,
      tavilyApiKey = json['tavily_api_key'] as String?,
      weatherKey = json['weather_key'] as String?,
      realTimeGptModel = json['real_time_gpt_model'] as String?,
      gptTemperature = json['gpt_temperature'] as String?,
      followUpQuestionPrompt = json['follow_up_question_prompt'] as String?,
      youtubeApiKey = json['youtube_api_key'] as String?,
      isShowElevenLab = json['is_show_eleven_lab'] as String?,
      magic_stick_prompt = json['magic_stick_prompt'] as String?,
      voiceDtl =
          (json['voice_dtl'] as Map<String, dynamic>?) != null
              ? VoiceDtl.fromJson(json['voice_dtl'] as Map<String, dynamic>)
              : null */
  ;

  Map<String, dynamic> toJson() => _$UserProfileDataToJson(this);

  static String? _decryptAPIKey(String? value) {
    if (value == null) {
      return null;
    }
    return CryptoHelper.instance.encryptDecrypt(value);
  }

  static String? _encryptAPIKey(String? value) {
    if (value == null) {
      return null;
    }
    return CryptoHelper2.encryptData(value);
  }
}

@JsonSerializable(explicitToJson: true)
class VoiceDtl {
  @JsonKey(name: 'voice_id')
  final String? voiceId;
  final String? name;
  final String? img;
  @JsonKey(name: 'is_active')
  final String? isActive;
  @JsonKey(name: 'eleven_lab_id')
  final String? elevenLabId;
  @JsonKey(name: 'is_selected')
  final String? isSelected;

  VoiceDtl({this.voiceId, this.name, this.img, this.isActive, this.elevenLabId, this.isSelected});

  factory VoiceDtl.fromJson(Map<String, dynamic> json) => _$VoiceDtlFromJson(json)
  /* : voiceId = json['voice_id'] as String?,
      name = json['name'] as String?,
      img = json['img'] as String?,
      isActive = json['is_active'] as String?,
      elevenLabId = json['eleven_lab_id'] as String?,
      isSelected = json['is_selected'] as String? */
  ;

  Map<String, dynamic> toJson() => _$VoiceDtlToJson(this)
  /* {
    'voice_id': voiceId,
    'name': name,
    'img': img,
    'is_active': isActive,
    'eleven_lab_id': elevenLabId,
    'is_selected': isSelected,
  } */
  ;
}

@JsonEnum()
enum ModelType {
  @JsonValue('gpt_5_turbo')
  gpt5Turbo,

  @JsonValue('gpt_5_pro')
  gpt5Pro,

  @JsonValue('gpt_5_max')
  gpt5Max,

  @JsonValue('chatgpt_mini')
  chatGPTMini,

  @JsonValue('chatgpt_4o')
  chatGPT4o,

  @JsonValue('gemini')
  gemini,

  @JsonValue('deepseek')
  deepSeek,

  @JsonValue('summarize_doc')
  summarizeDoc,

  @JsonValue('summarize_web')
  summarizeWeb,

  @JsonValue('image_scan')
  imageScan,

  @JsonValue('text_scan')
  textScan,

  @JsonValue('image_generation')
  imageGeneration,

  @JsonValue('youtube_summarize')
  youtubeSummarize,

  @JsonValue('real_time_web')
  realTimeWeb,
}

@JsonSerializable(explicitToJson: true)
class ToolsModel {
  @JsonKey(name: 'model_id')
  final String? modelId;
  final String? logo;
  final String? model;
  @JsonKey(name: 'is_premium')
  final String? isPremium;
  @JsonKey(name: 'is_active')
  final String? isActive;
  final String? type;
  final String? name;
  @JsonKey(name: 'model_type')
  final ModelType? modelType;
  @JsonKey(name: 'default_logo')
  final String? defaultLogo;
  final String? description;
  @JsonKey(name: 'is_coming_soon')
  final String? isComingSoon;

  ToolsModel({
    this.modelId,
    this.logo,
    this.model,
    this.isPremium,
    this.isActive,
    this.type,
    this.name,
    this.modelType,
    this.isComingSoon,
    this.defaultLogo,
    this.description,
  });

  factory ToolsModel.fromJson(Map<String, dynamic> json) => _$ToolsModelFromJson(json)
  /* : modelId = json['model_id'] as String?,
      logo = json['logo'] as String?,
      model = json['model'] as String?,
      isPremium = json['is_premium'] as String?,
      defaultLogo = json['default_logo'] as String?,
      isActive = json['is_active'] as String?,
      isComingSoon = json['is_coming_soon'] as String?,
      type = json['type'] as String?,
      modelType = json['model_type'] as String?,
      name = json['name'] as String?,
      description = json['description'] as String? */
  ;

  Map<String, dynamic> toJson() => _$ToolsModelToJson(this)
  /* {
    'model_id': modelId,
    'logo': logo,
    'default_logo': defaultLogo,
    'is_coming_soon': isComingSoon,
    'model_type': modelType,
    'model': model,
    'is_premium': isPremium,
    'is_active': isActive,
    'type': type,
    'name': name,
    'description': description,
  } */
  ;
}
