import 'dart:developer';

import '../../../helper/all_imports.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../home/controllers/user_profile_model.dart';
import '../../newChat/controllers/new_chat_controller.dart';

class YoutubeSummaryController extends GetxController with WidgetsBindingObserver {
  //TODO: Implement YoutubeSummaryController

  final count = 0.obs;
  RxString title = "".obs;
  RxString image = "".obs;
  RxString url = "".obs;
  RxString transcription = "".obs;
  RxString channelId = "".obs;
  RxString channelTitle = "".obs;
  ToolsModel? toolModel;
  RxList<ChatItem> chatItem = <ChatItem>[].obs;
  ScrollController scrollController = ScrollController();
  TextEditingController newChatController = TextEditingController();
  FocusNode newChatFocusNode = FocusNode();
  var menu = false.obs;

  var promptList = [
    'Summarize',
    'Explain in simple words',
    'Extract the key points',
  ];
  String qq = "";

  @override
  void onInit() {
    if (ChatApi.isStreamingData.value) {
      ChatApi.isStreamingData.value = false;
    }
    if (Get.arguments[HttpUtil.chatItemList] != null) {
      chatItem.value = Get.arguments[HttpUtil.chatItemList];

      url.value = Get.arguments[HttpUtil.link];
      title.value = Get.arguments[HttpUtil.youtubeTitle];
      qq = Get.arguments[HttpUtil.fileText];

      printAction("=====================url.value=${url.value}");
      printAction("=====================title.value=${title.value}");
      if ((!Utils().isValidationEmpty(url.value))) {
        String? videoId = Utils().getYouTubeVideoId(url.value);
        image.value = "https://img.youtube.com/vi/$videoId/hqdefault.jpg";
      }
      WidgetsBinding.instance.addObserver(this);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    }

    if (Get.arguments != null && Get.arguments.containsKey("toolModel")) {
      toolModel = Get.arguments["toolModel"];
    }

    getStorageData.saveSend(value: false);
    getStorageData.saveListening(value: false);
    if (Get.arguments != null && Get.arguments["title"] != null) {
      title.value = Get.arguments["title"];
      url.value = Get.arguments["url"];
      transcription.value = Get.arguments["transcription"];
      channelId.value = Get.arguments["channelId"];
      channelTitle.value = Get.arguments["channelTitle"];

      if ((!Utils().isValidationEmpty(url.value))) {
        String? videoId = Utils().getYouTubeVideoId(url.value);
        image.value = "https://img.youtube.com/vi/$videoId/hqdefault.jpg";
      }
    }
    if ((!Utils().isValidationEmpty(url.value)) && (!Utils().isValidationEmpty(transcription.value)) && (!Utils().isValidationEmpty(channelId.value))) {
      printAction("ifififififififififififififififi");

      qq = "**Task:**\n\nGenerate a **detailed yet concise analysis** of the provided YouTube video transcription. "
          "Ensure that your response is **accurate**, reflects the **content's intent**, and follows the **structure provided below**."
          "\n\nAnalysis Components:\nKey Ideas: Summarize the main topics or themes.\n\nMain Takeaways: Highlight conclusions or actionable insights."
          "\nNotable Quotes: Extract key quotes.\nContent Consistency: Ensure the analysis remains true to the transcription’s ideas and tone.\n\n\n"
          "Video Information:\n\nTitle: ${title.value}\nChannel: ${channelId.value}\nTranscription:\"\"\" ${transcription.value}\"\" \n\n"
          "**Constraints:**\n  - Language Style: Maintain the tone and style used in the transcription.\n -"
          " Response Language: Write the answer in the **same language** as used in the transcription."
          "\n- Structure: Organize the response according to the **Analysis Components** outlined above";

      // qq = "**Instruction**:\n\n**Generate a detailed analysis** of a YouTube video based on its transcription. "
      //     "The analysis must be in the video's transcription language code, and should cover the key ideas and conclusions."
      //     "\n\n**Input**:\n- **Title**:\" '${title.value}' \"\n- **Channel**: \"'${channelId.value}\"\n- **Transcription**: \"\"\" ${transcription.value}\"\"";

      log("qqqqqqqqqqqqqq $qq");
    } else {
      printAction("elseelseelseelseelseelseelseelseelseelse");
      // qq = "**Instruction**:\n\n**Generate a detailed analysis** of a YouTube video based on its transcription. "
      //     "The analysis must be in the video's description language code, and should cover the key ideas and conclusions."
      //     "\n\n**Input**:\n- **Title**:\" '${title.value}' \"\n- **Channel**: \"'${channelId.value}\"\n- **Description**: \"\"\" ${title.value}\"\"";

      qq = " **Task:**\nGenerate a **detailed yet concise analysis** of the provided YouTube video from its metadata. Ensure that your response is"
          " **accurate**, reflects the **content's intent**, and follows the **structure provided below**.\n\n\nAnalysis Components:\n\nKey Ideas: Summarize the main topics or themes.\nMain Takeaways: Highlight conclusions or actionable insights."
          "\nNotable Quotes: Extract key quotes.\nContent Consistency: Ensure the analysis remains true to the transcription’s ideas and tone.\n\nVideo Information:\n\n"
          "Title:  '${title.value}'\nChannel: \"'${channelId.value}\"\nDescriptions:\"\"\" ${title.value}\"\"\n\n**Constraints:** \n"
          "- Language Style: Maintain the tone and style used in the transcription. \n- Response Language: Write the answer in the **same language** as used in the description."
          "\n- Structure: Organize the response according to the **Analysis Components** outlined above.";
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  RxInt apiCall = 0.obs;

  @override
  onClose() {
    ChatApi.stopStreaming();
    HttpUtil.cancelRequests();

    modelsHistoryAPI(chatItem, "", Constants.youtubeSummaryType, fileName: title.value, fileText: qq, link: url.value);

    Get.put(BottomNavigationController()).backToTemplateOrAssistants(apiCall: apiCall);
    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
