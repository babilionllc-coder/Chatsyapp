class GetAllChatHistoryModel {
  final List<ChatHistory>? data;
  final int? totalRecord;
  final String? remainingChatLimit;
  final int? responseCode;
  final String? responseMsg;
  final String? result;
  final String? serverTime;

  GetAllChatHistoryModel({
    this.data,
    this.totalRecord,
    this.remainingChatLimit,
    this.responseCode,
    this.responseMsg,
    this.result,
    this.serverTime,
  });

  GetAllChatHistoryModel.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List?)?.map((dynamic e) => ChatHistory.fromJson(e as Map<String, dynamic>)).toList(),
        totalRecord = json['total_record'] as int?,
        remainingChatLimit = json['remaining_chat_limit'] as String?,
        responseCode = json['ResponseCode'] as int?,
        responseMsg = json['ResponseMsg'] as String?,
        result = json['Result'] as String?,
        serverTime = json['ServerTime'] as String?;

  Map<String, dynamic> toJson() => {'data': data?.map((e) => e.toJson()).toList(), 'total_record': totalRecord, 'remaining_chat_limit': remainingChatLimit, 'ResponseCode': responseCode, 'ResponseMsg': responseMsg, 'Result': result, 'ServerTime': serverTime};
}

class ChatHistory {
  final String? phmId;
  final String? promptId;
  final String? userId;
  final String? sessionDate;
  final String? type;
  final String? aiModel;
  final String? modelId;
  final String? title;
  final String? displayTitle;
  final String? displayImg;
  final String? createdAt;
  String? isFavourite;
  String? stringMatch;
  final ChatMessage? lastChatMessage;

  ChatHistory({
    this.phmId,
    this.promptId,
    this.userId,
    this.sessionDate,
    this.type,
    this.aiModel,
    this.modelId,
    this.title,
    this.displayTitle,
    this.displayImg,
    this.createdAt,
    this.isFavourite,
    this.lastChatMessage,
    this.stringMatch,
  });

  ChatHistory.fromJson(Map<String, dynamic> json)
      : phmId = json['phm_id'] as String?,
        promptId = json['prompt_id'] as String?,
        userId = json['user_id'] as String?,
        sessionDate = json['session_date'] as String?,
        type = json['type'] as String?,
        aiModel = json['ai_model'] as String?,
        modelId = json['model_id'] as String?,
        title = json['title'] as String?,
        displayTitle = json['display_title'] as String?,
        displayImg = json['display_img'] as String?,
        createdAt = json['created_at'] as String?,
        isFavourite = json['is_favourite'] as String?,
        stringMatch = json['string_match'] as String?,
        lastChatMessage = (json['last_chat_message'] as Map<String, dynamic>?) != null ? ChatMessage.fromJson(json['last_chat_message'] as Map<String, dynamic>) : null;

  Map<String, dynamic> toJson() => {'phm_id': phmId, 'prompt_id': promptId, 'user_id': userId, 'string_match': stringMatch, 'display_title': displayTitle, 'display_img': displayImg, 'session_date': sessionDate, 'type': type, 'ai_model': aiModel, 'model_id': modelId, 'title': title, 'created_at': createdAt, 'is_favourite': isFavourite, 'last_chat_message': lastChatMessage?.toJson()};
}

class ChatMessage {
  final String? scmId;
  final String? phmId;
  final String? userId;
  final String? question;
  final String? answer;
  final String? media;
  final String? mediaType;
  final String? promptId;
  final String? toolsType;
  final String? fileName;
  final String? fileSize;
  final String? fileText;
  final String? link;
  final String? isHide;
  final String? aiAnsType;
  final String? img;
  final String? photoIdentificationType;
  final String? revisedPrompt;
  final String? youtubeTitle;
  final String? assistantId;
  final String? createdAt;
  final String? modelLogo;

  ChatMessage.fromJson(Map<String, dynamic> json)
      : scmId = json['scm_id'] as String?,
        phmId = json['phm_id'] as String?,
        userId = json['user_id'] as String?,
        question = json['question'] as String?,
        answer = json['answer'] as String?,
        media = json['media'] as String?,
        mediaType = json['media_type'],
        promptId = json['prompt_id'] as String?,
        toolsType = json['tools_type'] as String?,
        modelLogo = json['model_logo'] as String?,
        fileName = json['file_name'] as String?,
        fileSize = json['file_size'] as String?,
        fileText = json['file_text'] as String?,
        link = json['link'] as String?,
        isHide = json['is_hide'] as String?,
        aiAnsType = json['ai_ans_type'] as String?,
        img = json['img'] as String?,
        photoIdentificationType = json['photo_identification_type'] as String?,
        revisedPrompt = json['revised_prompt'] as String?,
        youtubeTitle = json['youtube_title'] as String?,
        assistantId = json['assistant_id'] as String?,
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
        'model_logo': modelLogo,
        'file_name': fileName,
        'file_text': fileText,
        'file_size': fileSize,
        'link': link,
        'is_hide': isHide,
        'ai_ans_type': aiAnsType,
        'img': img,
        'photo_identification_type': photoIdentificationType,
        'revised_prompt': revisedPrompt,
        'youtube_title': youtubeTitle,
        'assistant_id': assistantId,
        'created_at': createdAt
      };
}
