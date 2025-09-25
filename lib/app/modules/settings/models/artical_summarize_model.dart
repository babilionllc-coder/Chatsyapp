class SummarizeArticalModel {
  ArticalData? data;
  int? responseCode;
  String? responseMsg;
  String? result;
  String? serverTime;

  SummarizeArticalModel({this.data, this.responseCode, this.responseMsg, this.result, this.serverTime});

  SummarizeArticalModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ArticalData.fromJson(json['data']) : null;
    responseCode = json['ResponseCode'];
    responseMsg = json['ResponseMsg'];
    result = json['Result'];
    serverTime = json['ServerTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['ResponseCode'] = this.responseCode;
    data['ResponseMsg'] = this.responseMsg;
    data['Result'] = this.result;
    data['ServerTime'] = this.serverTime;
    return data;
  }
}

class ArticalData {
  String? userId;
  String? question;
  String? dummyQuestion;
  String? answer;
  String? type;
  String? updatedAt;
  String? createdAt;
  String? chatId;
  String? phmId;
  String? queImage;
  String? promptChatImage;
  String? isGoodOrBad;
  String? pcmId;
  bool? isUpgrade;

  ArticalData({
    this.userId,
    this.question,
    this.dummyQuestion,
    this.answer,
    this.phmId,
    this.type,
    this.updatedAt,
    this.createdAt,
    this.chatId,
    this.queImage,
    this.isUpgrade,
    this.promptChatImage,
    this.isGoodOrBad,
    this.pcmId,
  });

  ArticalData.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    question = json['question'];
    answer = json['answer'];
    phmId = json['phm_id'];
    type = json['type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    chatId = json['chat_id'];
    queImage = json['que_image'];
    promptChatImage = json['prompt_chat_image'];
    isGoodOrBad = json['is_good_or_bad'];
    pcmId = json['pcm_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['type'] = this.type;
    data['updated_at'] = this.updatedAt;
    data['phm_id'] = this.phmId;
    data['created_at'] = this.createdAt;
    data['chat_id'] = this.chatId;
    data['que_image'] = this.queImage;
    data['prompt_chat_image'] = this.promptChatImage;
    data['is_good_or_bad'] = this.isGoodOrBad;
    data['pcm_id'] = this.pcmId;
    return data;
  }
}
