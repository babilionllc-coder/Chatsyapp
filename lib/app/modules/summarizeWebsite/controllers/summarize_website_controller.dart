import 'dart:developer';

import 'package:favicon/favicon.dart';
import 'package:http/http.dart' as http;

import '../../../api_repository/loading.dart';
import '../../../helper/all_imports.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../home/controllers/user_profile_model.dart';
import '../../newChat/controllers/new_chat_controller.dart';

class SummarizeWebsiteController extends GetxController {
  // Enhanced Website Summary Controller with full functionality

  var menu = false.obs;
  RxInt apiCall = 0.obs;

  String documentText = "";

  String urlQuestion = "";
  ToolsModel? toolModel;
  var urlIcon;
  var promptList = [
    'Summarize',
    'Explain in simple words',
    'Extract the key points',
    'Create bullet points',
    'Generate insights',
    'Find main themes',
    'Analyze content',
    'Extract quotes',
    'Website overview',
    'Technical details',
  ];
  RxList<ChatItem> chatItem = <ChatItem>[].obs;
  ScrollController scrollController = ScrollController();
  TextEditingController newChatController = TextEditingController();
  FocusNode newChatFocusNode = FocusNode();
  
  // Enhanced website analysis features
  RxBool isLoading = false.obs;
  RxString websiteTitle = "".obs;
  RxString websiteDescription = "".obs;
  RxString websiteLanguage = "en".obs;
  RxList<String> websiteKeywords = <String>[].obs;
  RxString websiteContent = "".obs;
  RxString websiteType = "".obs;
  RxInt wordCount = 0.obs;
  
  // Analysis options
  RxBool includeMetaData = true.obs;
  RxBool includeContent = true.obs;
  RxBool includeInsights = true.obs;
  RxBool includeTechnical = true.obs;

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
  }

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
  
  // Enhanced website analysis methods
  Future<void> analyzeWebsiteWithGPT5() async {
    try {
      isLoading.value = true;
      
      // Analyze website properties
      await _analyzeWebsiteProperties();
      
      // Enhanced prompt for GPT-5 analysis
      String enhancedPrompt = _buildEnhancedWebsitePrompt();
      
      // Call GPT-5 with advanced analysis
      await ChatApi.chatGPTAPI(
        message: enhancedPrompt,
        modelType: ModelType.chatGPT,
        isRealTime: true,
        chatGPTAddData: null,
        systemText: _getWebsiteAnalysisSystemPrompt(),
        documentText: documentText,
        modelPrompt: null,
        fileName: urlQuestion,
        fileText: enhancedPrompt,
      );
      
    } catch (e) {
      printAction("Website analysis error: $e");
      utils.showSnackBar("Error analyzing website: $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> _analyzeWebsiteProperties() async {
    try {
      if (Utils().isValidationEmpty(urlQuestion)) return;
      
      // Extract website metadata
      Uri uri = Uri.parse(urlQuestion);
      websiteTitle.value = uri.host;
      
      // Count words in document text
      wordCount.value = documentText.split(' ').length;
      
      // Detect website type based on content
      if (documentText.toLowerCase().contains('blog') || 
          documentText.toLowerCase().contains('article')) {
        websiteType.value = "Blog/Article";
      } else if (documentText.toLowerCase().contains('shop') ||
                 documentText.toLowerCase().contains('buy') ||
                 documentText.toLowerCase().contains('price')) {
        websiteType.value = "E-commerce";
      } else if (documentText.toLowerCase().contains('news') ||
                 documentText.toLowerCase().contains('breaking')) {
        websiteType.value = "News";
      } else if (documentText.toLowerCase().contains('documentation') ||
                 documentText.toLowerCase().contains('api')) {
        websiteType.value = "Documentation";
      } else if (documentText.toLowerCase().contains('about') ||
                 documentText.toLowerCase().contains('company')) {
        websiteType.value = "Corporate";
      } else {
        websiteType.value = "General Website";
      }
      
      // Extract keywords (simple keyword extraction)
      List<String> words = documentText.toLowerCase()
          .replaceAll(RegExp(r'[^\w\s]'), '')
          .split(' ')
          .where((word) => word.length > 4)
          .toList();
      
      Map<String, int> wordFreq = {};
      for (String word in words) {
        wordFreq[word] = (wordFreq[word] ?? 0) + 1;
      }
      
      websiteKeywords.value = wordFreq.entries
          .where((entry) => entry.value > 2)
          .map((entry) => entry.key)
          .take(10)
          .toList();
      
    } catch (e) {
      printAction("Website properties analysis error: $e");
    }
  }
  
  String _buildEnhancedWebsitePrompt() {
    String basePrompt = """
**Advanced Website Analysis Task**

Generate a comprehensive analysis of the website using GPT-5's advanced capabilities.

**Website Information:**
- URL: ${urlQuestion}
- Website Type: ${websiteType.value}
- Word Count: ${wordCount.value}
- Keywords: ${websiteKeywords.join(', ')}
- Domain: ${Uri.parse(urlQuestion).host}

**Website Content:**
${documentText.length > 15000 ? documentText.substring(0, 15000) + "... [Content truncated for analysis]" : documentText}

**Analysis Requirements:**
""";

    basePrompt += """
**Analysis Components:**
1. **Website Overview** - Purpose, target audience, and main goals
2. **Content Summary** - Key information and main topics covered
3. **Structure Analysis** - Organization and navigation insights
4. **Key Points** - Important information and takeaways
5. **Technical Insights** - Website features, functionality, and design
6. **User Experience** - Accessibility, usability, and engagement factors
7. **SEO Analysis** - Content optimization and search visibility
8. **Action Items** - Recommendations for improvement or further exploration

**Advanced Features:**
- Analyze content quality and relevance
- Identify target audience and purpose
- Suggest improvements and optimizations
- Extract important quotes and insights
- Provide technical recommendations

**Response Format:**
Use clear headings, bullet points, and structured formatting for easy reading.
""";

    return basePrompt;
  }
  
  String _getWebsiteAnalysisSystemPrompt() {
    return """
You are an expert website analyst powered by GPT-5. Your role is to provide comprehensive, accurate, and insightful analysis of websites and web content.

**Core Capabilities:**
- Deep website content analysis and summarization
- Website structure and navigation analysis
- User experience and accessibility assessment
- SEO and content optimization insights
- Technical analysis and recommendations
- Target audience identification

**Analysis Standards:**
- Always maintain accuracy and objectivity
- Provide structured, easy-to-read responses
- Highlight actionable insights and recommendations
- Identify the website's purpose and target audience
- Suggest improvements and optimizations
- Consider both content and technical aspects

**Response Guidelines:**
- Use clear headings and bullet points
- Include executive summary for quick understanding
- Provide detailed analysis for comprehensive understanding
- Highlight key insights and recommendations
- Suggest practical applications or next steps
- Maintain professional, informative tone

Always prioritize user value and actionable insights in your website analysis.
""";
  }
  
  // Method to generate different types of website analysis
  Future<void> generateCustomWebsiteAnalysis(String analysisType) async {
    String customPrompt = "";
    
    switch (analysisType.toLowerCase()) {
      case 'bullet points':
        customPrompt = "Create bullet points summarizing the key information from this website.";
        break;
      case 'insights':
        customPrompt = "Generate deep insights and analysis from this website content.";
        break;
      case 'technical details':
        customPrompt = "Analyze the technical aspects, features, and functionality of this website.";
        break;
      case 'website overview':
        customPrompt = "Provide a comprehensive overview of this website's purpose, content, and structure.";
        break;
      case 'seo analysis':
        customPrompt = "Analyze the SEO aspects and content optimization of this website.";
        break;
      case 'user experience':
        customPrompt = "Analyze the user experience, accessibility, and usability of this website.";
        break;
      default:
        customPrompt = "Provide a comprehensive analysis of this website.";
    }
    
    await ChatApi.chatGPTAPI(
      message: customPrompt,
      modelType: ModelType.chatGPT,
      isRealTime: true,
      chatGPTAddData: null,
      systemText: _getWebsiteAnalysisSystemPrompt(),
      documentText: documentText,
      modelPrompt: null,
      fileName: urlQuestion,
      fileText: customPrompt,
    );
  }
}
