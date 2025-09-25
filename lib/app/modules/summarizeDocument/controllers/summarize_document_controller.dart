import 'dart:developer';

import 'package:chatsy/app/helper/all_imports.dart';

import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../home/controllers/user_profile_model.dart';

import '../../newChat/controllers/new_chat_controller.dart';

class SummarizeDocumentController extends GetxController with WidgetsBindingObserver {
  // Enhanced Document Summary Controller with full functionality

  TextEditingController newChatController = TextEditingController();
  FocusNode newChatFocusNode = FocusNode();
  var menu = false.obs;
  RxInt apiCall = 0.obs;

  ToolsModel? toolModel;
  String documentText = "";
  RxString fileName = "".obs;
  RxString sizeInMb = "0.0".obs;
  var promptList = [
    'Summarize it',
    'Rewrite it', 
    'Translate it',
    'Extract key points',
    'Create bullet points',
    'Generate insights',
    'Find main themes',
    'Analyze content',
    'Create outline',
    'Extract quotes',
  ];
  RxList<ChatItem> chatItem = <ChatItem>[].obs;
  ScrollController scrollController = ScrollController();
  
  // Enhanced document analysis features
  RxBool isLoading = false.obs;
  RxString documentType = "".obs;
  RxInt wordCount = 0.obs;
  RxString language = "en".obs;
  RxList<String> keyTopics = <String>[].obs;
  RxString documentSummary = "".obs;
  
  // Analysis options
  RxBool includeKeyPoints = true.obs;
  RxBool includeQuotes = true.obs;
  RxBool includeInsights = true.obs;
  RxBool includeOutline = true.obs;

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
  
  // Enhanced document analysis methods
  Future<void> analyzeDocumentWithGPT5() async {
    try {
      isLoading.value = true;
      
      // Analyze document properties
      await _analyzeDocumentProperties();
      
      // Enhanced prompt for GPT-5 analysis
      String enhancedPrompt = _buildEnhancedDocumentPrompt();
      
      // Call GPT-5 with advanced analysis
      await ChatApi.chatGPTAPI(
        message: enhancedPrompt,
        modelType: ModelType.chatGPT,
        isRealTime: true,
        chatGPTAddData: null,
        systemText: _getDocumentAnalysisSystemPrompt(),
        documentText: documentText,
        modelPrompt: null,
        fileName: fileName.value,
        fileText: enhancedPrompt,
      );
      
    } catch (e) {
      printAction("Document analysis error: $e");
      utils.showSnackBar("Error analyzing document: $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> _analyzeDocumentProperties() async {
    try {
      // Count words
      wordCount.value = documentText.split(' ').length;
      
      // Detect document type based on content
      if (documentText.toLowerCase().contains('abstract') && 
          documentText.toLowerCase().contains('introduction')) {
        documentType.value = "Academic Paper";
      } else if (documentText.toLowerCase().contains('agenda') ||
                 documentText.toLowerCase().contains('meeting')) {
        documentType.value = "Meeting Notes";
      } else if (documentText.toLowerCase().contains('contract') ||
                 documentText.toLowerCase().contains('agreement')) {
        documentType.value = "Legal Document";
      } else if (documentText.toLowerCase().contains('report') ||
                 documentText.toLowerCase().contains('analysis')) {
        documentType.value = "Report";
      } else {
        documentType.value = "General Document";
      }
      
      // Extract key topics (simple keyword extraction)
      List<String> words = documentText.toLowerCase()
          .replaceAll(RegExp(r'[^\w\s]'), '')
          .split(' ')
          .where((word) => word.length > 4)
          .toList();
      
      Map<String, int> wordFreq = {};
      for (String word in words) {
        wordFreq[word] = (wordFreq[word] ?? 0) + 1;
      }
      
      keyTopics.value = wordFreq.entries
          .where((entry) => entry.value > 2)
          .map((entry) => entry.key)
          .take(10)
          .toList();
      
    } catch (e) {
      printAction("Document properties analysis error: $e");
    }
  }
  
  String _buildEnhancedDocumentPrompt() {
    String basePrompt = """
**Advanced Document Analysis Task**

Generate a comprehensive analysis of the document using GPT-5's advanced capabilities.

**Document Information:**
- File Name: ${fileName.value}
- File Size: ${sizeInMb.value}
- Document Type: ${documentType.value}
- Word Count: ${wordCount.value}
- Key Topics: ${keyTopics.join(', ')}

**Document Content:**
${documentText.length > 10000 ? documentText.substring(0, 10000) + "... [Content truncated for analysis]" : documentText}

**Analysis Requirements:**
""";

    basePrompt += """
**Analysis Components:**
1. **Executive Summary** - Key insights in 2-3 sentences
2. **Main Topics** - Core themes and subjects covered
3. **Key Points** - Important information and takeaways
4. **Notable Quotes** - Significant statements or insights
5. **Content Structure** - Organization and flow analysis
6. **Action Items** - Practical steps or recommendations
7. **Related Topics** - Additional areas for exploration

**Advanced Features:**
- Provide actionable insights
- Suggest related topics
- Analyze content quality and structure
- Identify key learning points
- Extract important quotes and their context

**Response Format:**
Use clear headings, bullet points, and structured formatting for easy reading.
""";

    return basePrompt;
  }
  
  String _getDocumentAnalysisSystemPrompt() {
    return """
You are an expert document analyst powered by GPT-5. Your role is to provide comprehensive, accurate, and insightful analysis of various document types.

**Core Capabilities:**
- Deep content analysis and summarization
- Document structure and organization analysis
- Key point extraction and organization
- Quote identification and context
- Actionable insight generation
- Content quality assessment

**Analysis Standards:**
- Always maintain accuracy and objectivity
- Provide structured, easy-to-read responses
- Highlight actionable insights and takeaways
- Identify the document's purpose and target audience
- Suggest related topics for further exploration
- Preserve important context and nuance

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
  
  // Method to generate different types of document analysis
  Future<void> generateCustomDocumentAnalysis(String analysisType) async {
    String customPrompt = "";
    
    switch (analysisType.toLowerCase()) {
      case 'bullet points':
        customPrompt = "Create bullet points summarizing the key information from this document.";
        break;
      case 'insights':
        customPrompt = "Generate deep insights and analysis from this document content.";
        break;
      case 'quotes':
        customPrompt = "Extract and analyze the most significant quotes from this document.";
        break;
      case 'outline':
        customPrompt = "Create a detailed outline of this document's structure and content.";
        break;
      case 'translate':
        customPrompt = "Translate this document to a different language while maintaining its meaning and structure.";
        break;
      case 'rewrite':
        customPrompt = "Rewrite this document to improve clarity, flow, and readability.";
        break;
      default:
        customPrompt = "Provide a comprehensive analysis of this document.";
    }
    
    await ChatApi.chatGPTAPI(
      message: customPrompt,
      modelType: ModelType.chatGPT,
      isRealTime: true,
      chatGPTAddData: null,
      systemText: _getDocumentAnalysisSystemPrompt(),
      documentText: documentText,
      modelPrompt: null,
      fileName: fileName.value,
      fileText: customPrompt,
    );
  }
}
