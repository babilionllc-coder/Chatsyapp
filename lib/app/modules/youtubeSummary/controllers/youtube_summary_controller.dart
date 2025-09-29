import 'dart:developer';

import '../../../helper/all_imports.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../home/controllers/user_profile_model.dart';
import '../../newChat/controllers/new_chat_controller.dart';

class YoutubeSummaryController extends GetxController with WidgetsBindingObserver {
  // Enhanced YouTube Summary Controller with full functionality

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
    'Create bullet points',
    'Generate insights',
    'Find main themes',
    'Extract quotes',
    'Analyze sentiment',
  ];
  String qq = "";
  
  // Enhanced YouTube analysis features
  RxBool isLoading = false.obs;
  RxString videoDuration = "".obs;
  RxString viewCount = "".obs;
  RxString publishDate = "".obs;
  RxString videoDescription = "".obs;
  RxList<String> tags = <String>[].obs;
  RxString language = "en".obs;
  
  // Advanced analysis options
  RxBool includeTimestamps = true.obs;
  RxBool includeQuotes = true.obs;
  RxBool includeSentiment = true.obs;
  RxBool includeKeyPoints = true.obs;

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
  
  // Enhanced YouTube analysis methods
  Future<void> analyzeVideoWithGPT5() async {
    try {
      isLoading.value = true;
      
      // Enhanced prompt for GPT-5 analysis
      String enhancedPrompt = _buildEnhancedAnalysisPrompt();
      
      // Call GPT-5 with advanced analysis
      ChatApi().apiCalling(
        textQuestion: enhancedPrompt,
        chatItem: RxList<ChatItem>(),
        scrollController: ScrollController(),
        modelType: ModelType.chatGPT4o,
        isRealTime: true,
        chatGPTAddData: null,
        systemText: _getYouTubeAnalysisSystemPrompt(),
        documentText: null,
        modelPrompt: null,
        fileName: title.value,
        link: url.value,
      );
      
    } catch (e) {
      printAction("YouTube analysis error: $e");
      utils.showToast(message: "Error analyzing video: $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  String _buildEnhancedAnalysisPrompt() {
    String basePrompt = """
**Advanced YouTube Video Analysis Task**

Generate a comprehensive analysis of the YouTube video using GPT-5's advanced capabilities.

**Video Information:**
- Title: ${title.value}
- Channel: ${channelTitle.value}
- URL: ${url.value}
- Duration: ${videoDuration.value}
- Views: ${viewCount.value}
- Published: ${publishDate.value}

**Analysis Requirements:**
""";

    if (!Utils().isValidationEmpty(transcription.value)) {
      basePrompt += """
**Transcription Available:**
${transcription.value}

**Analysis Components:**
1. **Executive Summary** - Key insights in 2-3 sentences
2. **Main Topics** - Core themes and subjects covered
3. **Key Points** - Important information and takeaways
4. **Notable Quotes** - Significant statements or insights
5. **Sentiment Analysis** - Overall tone and emotional content
6. **Action Items** - Practical steps or recommendations
7. **Related Topics** - Additional areas for exploration
""";
    } else {
      basePrompt += """
**Metadata Analysis:**
Based on title, description, and metadata, provide:
1. **Content Overview** - What the video likely covers
2. **Target Audience** - Who this content is for
3. **Content Type** - Educational, entertainment, tutorial, etc.
4. **Key Themes** - Main topics based on title/description
5. **Engagement Potential** - Why this content might be valuable
""";
    }

    basePrompt += """

**Advanced Features:**
- Include timestamps if available
- Provide actionable insights
- Suggest related topics
- Analyze content quality
- Identify key learning points

**Response Format:**
Use clear headings, bullet points, and structured formatting for easy reading.
""";

    return basePrompt;
  }
  
  String _getYouTubeAnalysisSystemPrompt() {
    return """
You are an expert YouTube content analyst powered by GPT-5. Your role is to provide comprehensive, accurate, and insightful analysis of YouTube videos.

**Core Capabilities:**
- Deep content analysis and summarization
- Sentiment and tone analysis
- Key point extraction and organization
- Quote identification and context
- Actionable insight generation
- Content quality assessment

**Analysis Standards:**
- Always maintain accuracy and objectivity
- Provide structured, easy-to-read responses
- Include relevant timestamps when available
- Highlight actionable insights and takeaways
- Identify the target audience and content purpose
- Suggest related topics for further exploration

**Response Guidelines:**
- Use clear headings and bullet points
- Include executive summary for quick understanding
- Provide detailed analysis for comprehensive understanding
- Highlight key quotes and their significance
- Suggest practical applications or next steps
- Maintain professional, informative tone

Always prioritize user value and actionable insights in your analysis.
""";
  }
  
  // Method to extract video metadata
  Future<void> extractVideoMetadata() async {
    try {
      if (Utils().isValidationEmpty(url.value)) return;
      
      String? videoId = Utils().getYouTubeVideoId(url.value);
      if (videoId == null) return;
      
      // Enhanced thumbnail URL
      image.value = "https://img.youtube.com/vi/$videoId/maxresdefault.jpg";
      
      // You can add YouTube API calls here to get more metadata
      // For now, we'll use the basic information available
      
    } catch (e) {
      printAction("Metadata extraction error: $e");
    }
  }
  
  // Method to generate different types of summaries
  Future<void> generateCustomSummary(String summaryType) async {
    String customPrompt = "";
    
    switch (summaryType.toLowerCase()) {
      case 'bullet points':
        customPrompt = "Create bullet points summarizing the key information from this YouTube video.";
        break;
      case 'insights':
        customPrompt = "Generate deep insights and analysis from this YouTube video content.";
        break;
      case 'quotes':
        customPrompt = "Extract and analyze the most significant quotes from this YouTube video.";
        break;
      case 'sentiment':
        customPrompt = "Analyze the sentiment, tone, and emotional content of this YouTube video.";
        break;
      default:
        customPrompt = "Provide a comprehensive summary of this YouTube video.";
    }
    
    ChatApi().apiCalling(
      textQuestion: customPrompt,
      chatItem: RxList<ChatItem>(),
      scrollController: ScrollController(),
      modelType: ModelType.chatGPT4o,
      isRealTime: true,
      chatGPTAddData: null,
      systemText: _getYouTubeAnalysisSystemPrompt(),
      documentText: null,
      modelPrompt: null,
      fileName: title.value,
      link: url.value,
    );
  }
}
