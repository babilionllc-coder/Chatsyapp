class AskQuestionModel {
  final Data? data;
  final int? responseCode;
  final String? responseMsg;
  final String? result;
  final String? serverTime;

  AskQuestionModel({
    this.data,
    this.responseCode,
    this.responseMsg,
    this.result,
    this.serverTime,
  });

  AskQuestionModel.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as Map<String, dynamic>?) != null ? Data.fromJson(json['data'] as Map<String, dynamic>) : null,
        responseCode = json['ResponseCode'] as int?,
        responseMsg = json['ResponseMsg'] as String?,
        result = json['Result'] as String?,
        serverTime = json['ServerTime'] as String?;

  Map<String, dynamic> toJson() => {'data': data?.toJson(), 'ResponseCode': responseCode, 'ResponseMsg': responseMsg, 'Result': result, 'ServerTime': serverTime};
}

class Data {
  String? chatId;
  String? phmId;
  String? userId;
  String? question;
  String? chatGptModel;
  String? answer;
  String? type;
  String? queImage;
  String? chatImage;
  String? secondChatImg;
  String? ansType;
  String? isGoodOrBad;
  String? createdAt;
  bool? isUpgrade;
  String? updatedAt;
  String? img;

  Data({this.chatId, this.phmId, this.userId, this.question, this.img, this.secondChatImg, this.answer, this.type, this.queImage, this.isUpgrade, this.chatImage, this.ansType, this.isGoodOrBad, this.chatGptModel, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
    phmId = json['phm_id'];
    userId = json['user_id'];
    question = json['question'];
    answer = json['answer'];
    chatGptModel = json['chat_gpt_model'];
    type = json['type'];
    queImage = json['que_image'];
    chatImage = json['chat_image'];
    secondChatImg = json['second_chat_img'];
    ansType = json['ans_type'];
    isGoodOrBad = json['is_good_or_bad'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_id'] = this.chatId;
    data['phm_id'] = this.phmId;
    data['user_id'] = this.userId;
    data['question'] = this.question;
    data['answer'] = this.answer;
    data['img'] = this.img;
    data['type'] = this.type;
    data['chat_gpt_model'] = this.chatGptModel;
    data['que_image'] = this.queImage;
    data['chat_image'] = this.chatImage;
    data['second_chat_img'] = this.secondChatImg;
    data['ans_type'] = this.ansType;
    data['is_good_or_bad'] = this.isGoodOrBad;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
