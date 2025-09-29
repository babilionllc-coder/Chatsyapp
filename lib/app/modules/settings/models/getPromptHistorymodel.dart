class GetPromptHistoryModel {
  List<GetPromptHistoryData>? data;
  int? responseCode;
  String? responseMsg;
  String? result;
  String? serverTime;

  GetPromptHistoryModel({this.data, this.responseCode, this.responseMsg, this.result, this.serverTime});

  GetPromptHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GetPromptHistoryData>[];
      json['data'].forEach((v) {
        data!.add(new GetPromptHistoryData.fromJson(v));
      });
    }
    responseCode = json['ResponseCode'];
    responseMsg = json['ResponseMsg'];
    result = json['Result'];
    serverTime = json['ServerTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['ResponseCode'] = this.responseCode;
    data['ResponseMsg'] = this.responseMsg;
    data['Result'] = this.result;
    data['ServerTime'] = this.serverTime;
    return data;
  }
}

class GetPromptHistoryData {
  String? phmId;
  String? promptId;
  String? userId;
  String? sessionDate;
  PromptDtl? promptDtl;
  List<ChatDtl>? chatDtl;

  GetPromptHistoryData({this.phmId, this.promptId, this.userId, this.sessionDate, this.promptDtl, this.chatDtl});

  GetPromptHistoryData.fromJson(Map<String, dynamic> json) {
    phmId = json['phm_id'];
    promptId = json['prompt_id'];
    userId = json['user_id'];
    sessionDate = json['session_date'];
    promptDtl = json['prompt_dtl'] != null ? new PromptDtl.fromJson(json['prompt_dtl']) : null;
    if (json['chat_dtl'] != null) {
      chatDtl = <ChatDtl>[];
      json['chat_dtl'].forEach((v) {
        chatDtl!.add(new ChatDtl.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phm_id'] = this.phmId;
    data['prompt_id'] = this.promptId;
    data['user_id'] = this.userId;
    data['session_date'] = this.sessionDate;
    if (this.promptDtl != null) {
      data['prompt_dtl'] = this.promptDtl!.toJson();
    }
    if (this.chatDtl != null) {
      data['chat_dtl'] = this.chatDtl!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PromptDtl {
  String? promptId;
  String? name;
  String? description;
  String? img;

  PromptDtl({this.promptId, this.name, this.description, this.img});

  PromptDtl.fromJson(Map<String, dynamic> json) {
    promptId = json['prompt_id'];
    name = json['name'];
    description = json['description'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['prompt_id'] = this.promptId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['img'] = this.img;
    return data;
  }
}

class ChatDtl {
  String? phmId;
  String? question;
  String? answer;

  ChatDtl({this.phmId, this.question, this.answer});

  ChatDtl.fromJson(Map<String, dynamic> json) {
    phmId = json['phm_id'];
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phm_id'] = this.phmId;
    data['question'] = this.question;
    data['answer'] = this.answer;
    return data;
  }
}
