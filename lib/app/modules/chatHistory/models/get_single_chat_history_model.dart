import 'package:chatsy/app/modules/chatHistory/models/get_all_chat_history_model.dart';

import '../../home/controllers/ai_assistants_model.dart';
import '../../home/controllers/all_prompt_model.dart';
import '../../home/controllers/user_profile_model.dart';

class GetSingleChatHistoryModel {
  final Data? data;
  final String? remainingChatLimit;
  final int? responseCode;
  final String? responseMsg;
  final String? result;
  final String? serverTime;

  GetSingleChatHistoryModel({
    this.data,
    this.remainingChatLimit,
    this.responseCode,
    this.responseMsg,
    this.result,
    this.serverTime,
  });

  GetSingleChatHistoryModel copyWith({
    Data? data,
    String? remainingChatLimit,
    int? responseCode,
    String? responseMsg,
    String? result,
    String? serverTime,
  }) {
    return GetSingleChatHistoryModel(
      data: data ?? this.data,
      remainingChatLimit: remainingChatLimit ?? this.remainingChatLimit,
      responseCode: responseCode ?? this.responseCode,
      responseMsg: responseMsg ?? this.responseMsg,
      result: result ?? this.result,
      serverTime: serverTime ?? this.serverTime,
    );
  }

  GetSingleChatHistoryModel.fromJson(Map<String, dynamic> json)
    : data =
          (json['data'] as Map<String, dynamic>?) != null
              ? Data.fromJson(json['data'] as Map<String, dynamic>)
              : null,
      remainingChatLimit = json['remaining_chat_limit'] as String?,
      responseCode = json['ResponseCode'] as int?,
      responseMsg = json['ResponseMsg'] as String?,
      result = json['Result'] as String?,
      serverTime = json['ServerTime'] as String?;

  Map<String, dynamic> toJson() => {
    'data': data?.toJson(),
    'remaining_chat_limit': remainingChatLimit,
    'ResponseCode': responseCode,
    'ResponseMsg': responseMsg,
    'Result': result,
    'ServerTime': serverTime,
  };
}

class Data {
  final List<ChatMessage>? chatList;
  final AssistantData? assistantDtl;
  final ToolsModel? modelDtl;
  final Prompts? promptDtl;

  Data.fromJson(Map<String, dynamic> json)
    : chatList =
          (json['chat_list'] as List?)
              ?.map((dynamic e) => ChatMessage.fromJson(e as Map<String, dynamic>))
              .toList(),
      assistantDtl =
          (json['assistant_dtl'] as Map<String, dynamic>?) != null
              ? AssistantData.fromJson(json['assistant_dtl'] as Map<String, dynamic>)
              : null,
      promptDtl =
          (json['prompt_dtl'] as Map<String, dynamic>?) != null
              ? Prompts.fromJson((json['prompt_dtl'] as Map<String, dynamic>))
              : null,
      modelDtl =
          (json['model_dtl'] as Map<String, dynamic>?) != null
              ? ToolsModel.fromJson(json['model_dtl'] as Map<String, dynamic>)
              : null;

  Map<String, dynamic> toJson() => {
    'chat_list': chatList?.map((e) => e.toJson()).toList(),
    'assistant_dtl': assistantDtl?.toJson(),
  };
}
