import 'package:chatsy/app/modules/settings/models/ask_something_model.dart';

class GetChatHistoryModel {
  List<ChatHistoryData>? data;
  int? responseCode;
  String? responseMsg;
  String? result;
  String? serverTime;

  GetChatHistoryModel({this.data, this.responseCode, this.responseMsg, this.result, this.serverTime});

  GetChatHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ChatHistoryData>[];
      json['data'].forEach((v) {
        data!.add(ChatHistoryData.fromJson(v));
      });
    }
    responseCode = json['ResponseCode'];
    responseMsg = json['ResponseMsg'];
    result = json['Result'];
    serverTime = json['ServerTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['ResponseCode'] = responseCode;
    data['ResponseMsg'] = responseMsg;
    data['Result'] = result;
    data['ServerTime'] = serverTime;
    return data;
  }
}

class ChatHistoryData {
  String? phmId;
  String? promptId;
  String? userId;
  String? sessionDate;
  String? type;
  String? createdAt;
  List<Data>? chat;

  ChatHistoryData({this.phmId, this.promptId, this.userId, this.sessionDate, this.type, this.createdAt, this.chat});

  ChatHistoryData.fromJson(Map<String, dynamic> json) {
    phmId = json['phm_id'];
    promptId = json['prompt_id'];
    userId = json['user_id'];
    sessionDate = json['session_date'];
    type = json['type'];
    createdAt = json['created_at'];
    if (json['chat'] != null) {
      chat = <Data>[];
      json['chat'].forEach((v) {
        chat!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phm_id'] = phmId;
    data['prompt_id'] = promptId;
    data['user_id'] = userId;
    data['session_date'] = sessionDate;
    data['type'] = type;
    data['created_at'] = createdAt;
    if (chat != null) {
      data['chat'] = chat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class GetChatHistoryModel {
//   List<ChatHistoryData>? data;
//   int? responseCode;
//   String? responseMsg;
//   String? result;
//   String? serverTime;
//
//   GetChatHistoryModel({this.data, this.responseCode, this.responseMsg, this.result, this.serverTime});
//
//   GetChatHistoryModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <ChatHistoryData>[];
//       json['data'].forEach((v) {
//         data!.add(new ChatHistoryData.fromJson(v));
//       });
//     }
//     responseCode = json['ResponseCode'];
//     responseMsg = json['ResponseMsg'];
//     result = json['Result'];
//     serverTime = json['ServerTime'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     data['ResponseCode'] = this.responseCode;
//     data['ResponseMsg'] = this.responseMsg;
//     data['Result'] = this.result;
//     data['ServerTime'] = this.serverTime;
//     return data;
//   }
// }
//
// class ChatHistoryData {
//   String? phmId;
//   String? promptId;
//   String? userId;
//   String? sessionDate;
//   String? type;
//   String? createdAt;
//   List<Chat>? chat;
//
//   ChatHistoryData({this.phmId, this.promptId, this.userId, this.sessionDate, this.type, this.createdAt, this.chat});
//
//   ChatHistoryData.fromJson(Map<String, dynamic> json) {
//     phmId = json['phm_id'];
//     promptId = json['prompt_id'];
//     userId = json['user_id'];
//     sessionDate = json['session_date'];
//     type = json['type'];
//     createdAt = json['created_at'];
//     if (json['chat'] != null) {
//       chat = <Chat>[];
//       json['chat'].forEach((v) {
//         chat!.add(new Chat.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['phm_id'] = this.phmId;
//     data['prompt_id'] = this.promptId;
//     data['user_id'] = this.userId;
//     data['session_date'] = this.sessionDate;
//     data['type'] = this.type;
//     data['created_at'] = this.createdAt;
//     if (this.chat != null) {
//       data['chat'] = this.chat!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Chat {
//   String? phmId;
//   String? question;
//   String? answer;
//
//   Chat({this.phmId, this.question, this.answer});
//
//   Chat.fromJson(Map<String, dynamic> json) {
//     phmId = json['phm_id'];
//     question = json['question'];
//     answer = json['answer'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['phm_id'] = this.phmId;
//     data['question'] = this.question;
//     data['answer'] = this.answer;
//     return data;
//   }
// }
