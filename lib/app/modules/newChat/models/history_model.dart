import '../../../helper/all_imports.dart';
import '../controllers/new_chat_controller.dart';

class HistoryModel {
  RxList<ChatItem>? chatItemList;
  String? modelName;
  String? title;
  String? fileName;
  String? fileSize;
  String? fileText;
  String? promptId;
  String? link;
  String? assistantId;
  String? type;

  HistoryModel({
    this.chatItemList,
    this.modelName,
    this.title,
    this.fileName,
    this.fileSize,
    this.fileText,
    this.promptId,
    this.link,
    this.assistantId,
    this.type,
  });

  toJson() {}
}
