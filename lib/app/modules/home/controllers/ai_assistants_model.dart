import 'package:chatsy/models/API%20Response/api_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ai_assistants_model.g.dart';

@JsonSerializable()
class AssistantsModel extends ApiResponse<List<AssistantData>> {
  @JsonKey(name: 'total_data')
  final int? totalData;

  @JsonKey(name: 'ServerTime')
  final String? serverTime;

  AssistantsModel({
    required super.data,
    this.totalData,
    required super.responseCode,
    required super.responseMsg,
    required super.result,
    this.serverTime,
  });

  factory AssistantsModel.fromJson(Map<String, dynamic> json) => _$AssistantsModelFromJson(json);

  // AssistantsModel.fromJson(Map<String, dynamic> json)
  //   : data =
  //         (json['data'] as List?)
  //             ?.map((dynamic e) => AssistantsData.fromJson(e as Map<String, dynamic>))
  //             .toList(),
  //     totalData = json['total_data'] as int?,
  //     responseCode = json['ResponseCode'] as int?,
  //     responseMsg = json['ResponseMsg'] as String?,
  //     result = json['Result'] as String?,
  //     serverTime = json['ServerTime'] as String?;

  Map<String, dynamic> toJson() => _$AssistantsModelToJson(this);
}

@JsonEnum()
enum AIModel { gpt4o, gemini }

@JsonSerializable()
class AssistantData {
  @JsonKey(name: 'assistant_id')
  final String? assistantId;

  @JsonKey(name: 'assistant_img')
  final String? assistantImg;

  @JsonKey(name: 'assistant_title')
  final String? assistantTitle;

  @JsonKey(name: 'assistant_desc')
  final String? assistantDesc;

  @JsonKey(name: 'backend_prompt')
  final String? backendPrompt;

  @JsonKey(name: 'assistant_question')
  final List<AssistantQuestion>? assistantQuestion;

  @JsonKey(name: 'is_lock')
  final String? isLock;

  @JsonKey(name: 'user_id')
  final String? userId;

  final AIModel? model;

  AssistantData({
    this.assistantId,
    this.assistantImg,
    this.assistantTitle,
    this.assistantDesc,
    this.backendPrompt,
    this.assistantQuestion,
    this.isLock,
    this.userId,
    this.model,
  });

  factory AssistantData.fromJson(Map<String, dynamic> json) => _$AssistantDataFromJson(json);

  // AssistantsData.fromJson(Map<String, dynamic> json)
  //   : assistantId = json['assistant_id'] as String?,
  //     assistantImg = json['assistant_img'] as String?,
  //     assistantTitle = json['assistant_title'] as String?,
  //     assistantDesc = json['assistant_desc'] as String?,
  //     backendPrompt = json['backend_prompt'] as String?,
  //     assistantQuestion =
  //         (json['assistant_question'] as List?)
  //             ?.map((dynamic e) => AssistantQuestion.fromJson(e as Map<String, dynamic>))
  //             .toList();

  Map<String, dynamic> toJson() => _$AssistantDataToJson(this);
}

class AssistantQuestion {
  final String? assistantQuestionId;
  final String? assistantId;
  final String? shortQuestion;
  final String? question;

  AssistantQuestion({
    this.assistantQuestionId,
    this.assistantId,
    this.shortQuestion,
    this.question,
  });

  AssistantQuestion.fromJson(Map<String, dynamic> json)
    : assistantQuestionId = json['assistant_question_id'] as String?,
      assistantId = json['assistant_id'] as String?,
      shortQuestion = json['short_question'] as String?,
      question = json['question'] as String?;

  Map<String, dynamic> toJson() => {
    'assistant_question_id': assistantQuestionId,
    'assistant_id': assistantId,
    'short_question': shortQuestion,
    'question': question,
  };
}

@JsonSerializable()
class CreateAssistantModel extends ApiResponse<AssistantData> {
  CreateAssistantModel({
    required super.data,
    required super.responseCode,
    required super.responseMsg,
    required super.result,
  });

  factory CreateAssistantModel.fromJson(Map<String, dynamic> json) =>
      _$CreateAssistantModelFromJson(json);
  Map<String, dynamic> toJson() => _$CreateAssistantModelToJson(this);
}
