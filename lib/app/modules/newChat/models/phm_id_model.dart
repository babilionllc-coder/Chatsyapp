import 'package:json_annotation/json_annotation.dart';

part 'phm_id_model.g.dart';

@JsonSerializable()
class PhmIdModel {
  final PhmIdModelData? data;
  final String? remainingChatLimit;
  final String? phmId;
  final int? responseCode;
  final String? responseMsg;
  final String? result;
  final String? serverTime;

  PhmIdModel({
    this.data,
    this.remainingChatLimit,
    this.phmId,
    this.responseCode,
    this.responseMsg,
    this.result,
    this.serverTime,
  });

  PhmIdModel.fromJson(Map<String, dynamic> json)
    : data =
          (json['data'] as Map<String, dynamic>?) != null
              ? PhmIdModelData.fromJson(json['data'] as Map<String, dynamic>)
              : null,
      remainingChatLimit = json['remaining_chat_limit'] as String?,
      phmId = json['phm_id'] as String?,
      responseCode = json['ResponseCode'] as int?,
      responseMsg = json['ResponseMsg'] as String?,
      result = json['Result'] as String?,
      serverTime = json['ServerTime'] as String?;

  Map<String, dynamic> toJson() => {
    'data': data?.toJson(),
    'remaining_chat_limit': remainingChatLimit,
    'phm_id': phmId,
    'ResponseCode': responseCode,
    'ResponseMsg': responseMsg,
    'Result': result,
    'ServerTime': serverTime,
  };
}

@JsonSerializable()
class PhmIdModelData {
  final String? scmId;
  final String? phmId;
  final String? userId;
  String? question;
  String? answer;
  final String? media;
  final String? mediaType;
  final String? promptId;
  final String? toolsType;
  final String? fileName;
  final String? fileSize;
  final String? link;
  final String? isHide;
  final String? assistantQuestionId;
  final String? aiAnsType;
  final String? img;
  final String? revisedPrompt;
  bool? isUpgraded;
  final String? createdAt;
  final List<String>? newQuestionList;

  PhmIdModelData({
    this.scmId,
    this.phmId,
    this.userId,
    this.question,
    this.answer,
    this.media,
    this.mediaType,
    this.promptId,
    this.toolsType,
    this.fileName,
    this.fileSize,
    this.createdAt,
    this.link,
    this.isHide,
    this.assistantQuestionId,
    this.aiAnsType,
    this.img,
    this.isUpgraded,
    this.revisedPrompt,
    this.newQuestionList,
  });

  PhmIdModelData.fromJson(Map<String, dynamic> json)
    : scmId = json['scm_id'] as String?,
      phmId = json['phm_id'] as String?,
      userId = json['user_id'] as String?,
      question = json['question'] as String?,
      answer = json['answer'] as String?,
      media = json['media'] as String?,
      mediaType = json['media_type'] as String?,
      promptId = json['prompt_id'] as String?,
      toolsType = json['tools_type'] as String?,
      fileName = json['file_name'] as String?,
      fileSize = json['file_size'] as String?,
      link = json['link'] as String?,
      isHide = json['is_hide'] as String?,
      assistantQuestionId = json['assistant_question_id'] as String?,
      aiAnsType = json['ai_ans_type'] as String?,
      img = json['img'] as String?,
      newQuestionList =
          (json['newQuestionList'] as List?)?.map((dynamic e) => e as String).toList(),
      revisedPrompt = json['revised_prompt'] as String?,
      createdAt = json['created_at'] as String?;

  Map<String, dynamic> toJson() => {
    'scm_id': scmId,
    'phm_id': phmId,
    'user_id': userId,
    'question': question,
    'answer': answer,
    'media': media,
    'media_type': mediaType,
    'prompt_id': promptId,
    'tools_type': toolsType,
    'file_name': fileName,
    'file_size': fileSize,
    'link': link,
    'is_hide': isHide,
    'assistant_question_id': assistantQuestionId,
    'ai_ans_type': aiAnsType,
    'img': img,
    'newQuestionList': newQuestionList,
    'created_at': createdAt,
    'revised_prompt': revisedPrompt,
  };
}
