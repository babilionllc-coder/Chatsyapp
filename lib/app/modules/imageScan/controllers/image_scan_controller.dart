import 'dart:developer';

import 'package:chatsy/app/api_repository/api_function.dart';
import 'package:chatsy/app/helper/all_imports.dart';

import '../../../common_widget/error_and_update_dialog.dart';
import '../../../helper/Global.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../home/controllers/user_profile_model.dart';
import '../../newChat/models/phm_id_model.dart';

class ImageScanController extends GetxController with WidgetsBindingObserver {
  // Enhanced Image Scan Controller with full functionality
  ScrollController scrollController = ScrollController();

  TextEditingController newChatController = TextEditingController();
  FocusNode newChatFocusNode = FocusNode();

  RxString imagePath = "".obs;
  RxBool isAnimation = true.obs;
  RxString promptId = "".obs;
  RxString promptQuestion = "".obs;
  ToolsModel? toolModel;
  var promptList = [
    'Scan this image',
    'Describe the scene in this photo',
    'Write 10 captions',
    'Extract text from image',
    'Identify objects in image',
    'Analyze image composition',
    'Generate alt text',
    'Find faces in image',
    'Describe colors and mood',
    'Create image story',
  ];

  RxList<String> newQuestionList = <String>[].obs;

  var endAnimFinish = false.obs;
  
  // Enhanced image analysis features
  RxBool isLoading = false.obs;
  RxString imageAnalysis = "".obs;
  RxList<String> detectedObjects = <String>[].obs;
  RxString extractedText = "".obs;
  RxString imageDescription = "".obs;
  RxString imageMood = "".obs;
  RxList<String> imageColors = <String>[].obs;
  
  // Analysis options
  RxBool extractText = true.obs;
  RxBool detectObjects = true.obs;
  RxBool analyzeComposition = true.obs;
  RxBool detectFaces = true.obs;

  @override
  void onInit() {
    getStorageData.saveSend(value: false);
    getStorageData.saveListening(value: false);
    var arg =
        Get.arguments
            as ({
              List<PhmIdModelData>? askQuestionData,
              ToolsModel? model,
              String? promptId,
              String? imagePath,
              String? promptQuestion,
            });

    if (arg.askQuestionData != null) {
      isAnimation.value = false;
      askQuestionData.value = arg.askQuestionData!;
      WidgetsBinding.instance.addObserver(this);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    }

    toolModel = arg.model;

    if (arg.imagePath != null) {
      imagePath.value = arg.imagePath!;
    }

    if (arg.promptId != null) {
      promptId.value = arg.promptId!;
    }
    if (arg.promptQuestion != null) {
      promptQuestion.value = arg.promptQuestion!;
    }

    if (askQuestionData.isNotEmpty) {
      phmId = askQuestionData.last.phmId ?? "0";
    }

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    if ((!Utils().isValidationEmpty(promptId.value)) &&
        (!Utils().isValidationEmpty(promptQuestion.value)) &&
        (!Utils().isValidationEmpty(imagePath.value))) {
      photoIdentificationAPI(promptQuestion.value, false, imagePath.value);
    }
  }

  RxList<PhmIdModelData> askQuestionData = <PhmIdModelData>[].obs;

  void scrollToEnd() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  String phmId = "";

  RxBool isAPICall = false.obs;

  Future<void> photoIdentificationAPI(
    String question,
    bool isRegenerate,
    String imagePathNew,
  ) async {
    newQuestionList = <String>[].obs;
    isAnimation.value = true;
    newChatController.clear();
    isAPICall.value = true;
    imagePath.value = "";
    if (Global.isSubscription.value != "1" && Global.chatLimit.value < 1) {
      askQuestionData.add(PhmIdModelData(question: question, isUpgraded: true));

      scrollToEnd();
      return;
    }

    try {
      FormData formData = FormData.fromMap({
        if (!Utils().isValidationEmpty(promptId.value))
          "prompt_id": promptId.value,
        "phm_id": phmId,
        "photo_identification_type":
            utils.isValidationEmpty(imagePathNew) ? 'text' : 'img',
        "question": question,
        "user_id": getStorageData.readString(getStorageData.userId),
        "ai_model":
            (Get.put(BottomNavigationController()).selectAiModelList.isEmpty
                    ? "gpt-5"
                    : Get.put(BottomNavigationController())
                            .selectAiModelList[(getStorageData.containKey(
                                  getStorageData.selectModelIndex,
                                ))
                                ? int.parse(
                                  getStorageData.readString(
                                        getStorageData.selectModelIndex,
                                      ) ??
                                      "0",
                                )
                                : 0]
                            .model ??
                        "gpt-5")
                .toString(),
        "title": "Image Scan",
        "is_edit": isRegenerate ? "1" : "0",
      });
      if (imagePathNew.isNotEmpty) {
        formData.files.addAll([
          MapEntry(
            "img",
            MultipartFile.fromFileSync(
              imagePathNew,
              filename: imagePathNew.split("/").last,
            ),
          ),
        ]);
      }

      PhmIdModelData data1 = PhmIdModelData(
        question: question,
        img: imagePathNew,
      );

      endAnimFinish.value = true;

      if (!isRegenerate) {
        askQuestionData.add(data1);
      } else {
        askQuestionData.last = data1;
      }
      final data = await APIFunction().apiCall(
        params: formData,
        apiName: Constants.imageScan,
        isLoading: false,
        token: getStorageData.readString(getStorageData.token),
      );
      isAPICall.value = false;

      log("-=-=-= data is $data");
      PhmIdModel model = PhmIdModel.fromJson(data);
      if (model.responseCode == 1) {
        updateChatLimit();
        if (!utils.isValidationEmpty(imagePath.value)) {
          imagePath.value = "";
        }
        newChatController.clear();
        askQuestionData.last = model.data ?? PhmIdModelData();
        askQuestionData.refresh();
        phmId = model.data?.phmId ?? "";
        scrollToEnd();

        getStorageData.saveSend(value: false);
        getStorageData.saveListening(value: false);
        if (!utils.isValidationEmpty(model.data?.answer)) {
          Global.isVibrate = true;
          Global.vibrate();
        }
      } else if (model.responseCode == 0) {
        askQuestionData.removeLast();

        utils.showToast(message: model.responseMsg!);
        Get.back();
      } else if (model.responseCode == 26) {
        askQuestionData.removeLast();

        updateDialog(model.responseMsg);
      } else if (model.responseCode == 5) {
        askQuestionData.removeLast();

        Global.isVibrate = true;
        Global.vibrate();

        PhmIdModelData data = PhmIdModelData(
          question: question,
          isUpgraded: true,
        );
        askQuestionData.add(data);
        newChatController.clear();
        askQuestionData.refresh();
        update();
      } else {
        askQuestionData.removeLast();

        utils.showToast(message: model.responseMsg!);
      }
    } catch (e) {
      isAPICall.value = false;
      askQuestionData.removeLast();
    }
  }
  
  // Enhanced image analysis methods
  Future<void> analyzeImageWithGPT5() async {
    try {
      isLoading.value = true;
      
      // Enhanced prompt for GPT-5 image analysis
      String enhancedPrompt = _buildEnhancedImagePrompt();
      
      // Call GPT-5 with advanced image analysis
      await ChatApi.chatGPTAPI(
        message: enhancedPrompt,
        modelType: ModelType.chatGPT,
        isRealTime: true,
        chatGPTAddData: null,
        systemText: _getImageAnalysisSystemPrompt(),
        documentText: null,
        modelPrompt: null,
        fileName: "image_analysis",
        fileText: enhancedPrompt,
      );
      
    } catch (e) {
      printAction("Image analysis error: $e");
      utils.showSnackBar("Error analyzing image: $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  String _buildEnhancedImagePrompt() {
    String basePrompt = """
**Advanced Image Analysis Task**

Generate a comprehensive analysis of the image using GPT-5's advanced vision capabilities.

**Image Information:**
- Image Path: ${imagePath.value}
- Analysis Options: 
  - Extract Text: ${extractText.value}
  - Detect Objects: ${detectObjects.value}
  - Analyze Composition: ${analyzeComposition.value}
  - Detect Faces: ${detectFaces.value}

**Analysis Requirements:**
""";

    basePrompt += """
**Analysis Components:**
1. **Visual Description** - Detailed description of what you see
2. **Object Detection** - List all objects, people, and elements
3. **Text Extraction** - Extract any visible text in the image
4. **Composition Analysis** - Analyze layout, colors, and visual elements
5. **Mood and Atmosphere** - Describe the emotional tone and atmosphere
6. **Context and Setting** - Identify location, time period, or situation
7. **Technical Details** - Analyze lighting, focus, and photographic elements

**Advanced Features:**
- Provide detailed object identification
- Extract and transcribe any text
- Analyze color palette and mood
- Identify faces and expressions
- Suggest image improvements
- Generate creative captions

**Response Format:**
Use clear headings, bullet points, and structured formatting for easy reading.
""";

    return basePrompt;
  }
  
  String _getImageAnalysisSystemPrompt() {
    return """
You are an expert image analyst powered by GPT-5 with advanced vision capabilities. Your role is to provide comprehensive, accurate, and insightful analysis of images.

**Core Capabilities:**
- Detailed visual description and analysis
- Object detection and identification
- Text extraction and transcription
- Composition and artistic analysis
- Mood and atmosphere assessment
- Face detection and expression analysis
- Color palette and lighting analysis

**Analysis Standards:**
- Always maintain accuracy and objectivity
- Provide structured, easy-to-read responses
- Include specific details and observations
- Identify both obvious and subtle elements
- Suggest practical applications or insights
- Maintain professional, informative tone

**Response Guidelines:**
- Use clear headings and bullet points
- Include detailed visual descriptions
- Highlight important elements and details
- Provide context and interpretation
- Suggest creative applications
- Include technical observations when relevant

Always prioritize accuracy, detail, and user value in your image analysis.
""";
  }
  
  // Method to generate different types of image analysis
  Future<void> generateCustomImageAnalysis(String analysisType) async {
    String customPrompt = "";
    
    switch (analysisType.toLowerCase()) {
      case 'extract text':
        customPrompt = "Extract and transcribe all visible text from this image.";
        break;
      case 'identify objects':
        customPrompt = "Identify and list all objects, people, and elements in this image.";
        break;
      case 'analyze composition':
        customPrompt = "Analyze the composition, colors, lighting, and visual elements of this image.";
        break;
      case 'generate alt text':
        customPrompt = "Generate comprehensive alt text for accessibility purposes.";
        break;
      case 'find faces':
        customPrompt = "Detect and analyze any faces, expressions, and emotions in this image.";
        break;
      case 'describe colors':
        customPrompt = "Describe the color palette, mood, and atmosphere of this image.";
        break;
      case 'create story':
        customPrompt = "Create a creative story or narrative based on this image.";
        break;
      default:
        customPrompt = "Provide a comprehensive analysis of this image.";
    }
    
    await ChatApi.chatGPTAPI(
      message: customPrompt,
      modelType: ModelType.chatGPT,
      isRealTime: true,
      chatGPTAddData: null,
      systemText: _getImageAnalysisSystemPrompt(),
      documentText: null,
      modelPrompt: null,
      fileName: "image_analysis",
      fileText: customPrompt,
    );
  }
}
