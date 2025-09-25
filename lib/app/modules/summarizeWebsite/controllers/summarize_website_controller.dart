import 'dart:developer';

import 'package:favicon/favicon.dart';
import 'package:http/http.dart' as http;

import '../../../api_repository/loading.dart';
import '../../../helper/all_imports.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../home/controllers/user_profile_model.dart';
import '../../newChat/controllers/new_chat_controller.dart';

class SummarizeWebsiteController extends GetxController {
  //TODO: Implement SummarizeWebsiteController

  var menu = false.obs;
  RxInt apiCall = 0.obs;

  String documentText = "";

  String urlQuestion = "";
  ToolsModel? toolModel;
  var urlIcon;
  var promptList = ['Summarize', 'Explain in simple words', 'Extract the key points'];
  RxList<ChatItem> chatItem = <ChatItem>[].obs;
  ScrollController scrollController = ScrollController();
  TextEditingController newChatController = TextEditingController();
  FocusNode newChatFocusNode = FocusNode();

  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<String?> getFavicon(String websiteUrl) async {
    try {
      // Append /favicon.ico to the website URL to get the favicon directly
      Uri uri = Uri.parse(websiteUrl);
      String faviconUrl = "${uri.scheme}://${uri.host}/favicon.ico";

      // Send a request to check if the favicon exists
      final response = await http.get(Uri.parse(faviconUrl));

      if (response.statusCode == 200) {
        return faviconUrl; // Return favicon URL if found
      } else {
        return null; // Return null if not found
      }
    } catch (e) {
      debugPrint("Error fetching favicon: $e");
      return null;
    }
  }

  @override
  Future<void> onReady() async {
    if (ChatApi.isStreamingData.value) {
      ChatApi.isStreamingData.value = false;
    }
    if (Get.arguments[HttpUtil.chatItemList] != null) {
      chatItem.value = Get.arguments[HttpUtil.chatItemList];
      urlQuestion = Get.arguments[HttpUtil.link];
      documentText = Get.arguments[HttpUtil.fileText];
      toolModel = Get.arguments["toolModel"];
      try {
        Loading.show();
        urlIcon = await FaviconFinder.getBest(urlQuestion);
        update();
        Loading.dismiss();
      } catch (e) {
        Loading.dismiss();
      }
    }

    if (Get.arguments != null && Get.arguments["question"] != null) {
      urlQuestion = Get.arguments["question"];
      toolModel = Get.arguments["toolModel"];
      documentText = Get.arguments["documentText"];
      log("website test is $documentText");

      update();
      try {
        Future.delayed(const Duration(milliseconds: 200), () async {
          Loading.show();
          urlIcon = await FaviconFinder.getBest(urlQuestion);
          update();
          Loading.dismiss();
        });
      } catch (e) {
        Loading.dismiss();
      }
    }
    getStorageData.saveSend(value: false);
    getStorageData.saveListening(value: false);

    super.onReady();

    @override
    Future<void> onClose() async {
      ChatApi.stopStreaming();
      HttpUtil.cancelRequests();

      modelsHistoryAPI(
        chatItem,
        "",
        "Summarize Web",
        fileName: urlQuestion,
        fileText: documentText,
      );
      Get.put(BottomNavigationController()).backToTemplateOrAssistants(apiCall: apiCall);
      super.onClose();
    }
  }
}
