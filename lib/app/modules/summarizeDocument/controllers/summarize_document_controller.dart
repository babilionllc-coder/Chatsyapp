import 'dart:developer';

import 'package:chatsy/app/helper/all_imports.dart';

import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../home/controllers/user_profile_model.dart';

import '../../newChat/controllers/new_chat_controller.dart';

class SummarizeDocumentController extends GetxController with WidgetsBindingObserver {
  //TODO: Implement SummarizeDocumentController

  TextEditingController newChatController = TextEditingController();
  FocusNode newChatFocusNode = FocusNode();
  var menu = false.obs;
  RxInt apiCall = 0.obs;

  ToolsModel? toolModel;
  String documentText = "";
  RxString fileName = "".obs;
  RxString sizeInMb = "0.0".obs;
  var promptList = ['Summarize it', 'Rewrite it', 'Translate it'];
  RxList<ChatItem> chatItem = <ChatItem>[].obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    if (ChatApi.isStreamingData.value) {
      ChatApi.isStreamingData.value = false;
    }
    if (Get.arguments[HttpUtil.chatItemList] != null) {
      chatItem.value = Get.arguments[HttpUtil.chatItemList];

      log("============123" + Get.arguments[HttpUtil.fileName]);
      fileName.value = Get.arguments[HttpUtil.fileName];
      sizeInMb.value = Get.arguments[HttpUtil.fileSize];
      documentText = Get.arguments[HttpUtil.fileText];
      toolModel = Get.arguments["toolModel"];

      printAction("======================${chatItem.first.question}");
      WidgetsBinding.instance.addObserver(this);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    }
    if (Get.arguments != null && Get.arguments["upload"] != null) {
      documentText = Get.arguments["upload"];
      fileName.value = Get.arguments["file_name"];
      sizeInMb.value = Get.arguments["sizeInMb"] + " MB";
      toolModel = Get.arguments["toolModel"];
      debugPrint("que --------------- $documentText");
    }

    getStorageData.saveSend(value: false);
    getStorageData.saveListening(value: false);
    super.onInit();
  }

  @override
  Future<void> onClose() async {
    ChatApi.stopStreaming();
    HttpUtil.cancelRequests();

    modelsHistoryAPI(
      chatItem,
      "",
      "Summarize Doc",
      fileName: fileName.value,
      fileText: documentText,
      fileSize: sizeInMb.value,
    );
    Get.put(BottomNavigationController()).backToTemplateOrAssistants(apiCall: apiCall);
    super.onClose();
  }
}
