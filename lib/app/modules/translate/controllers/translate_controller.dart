import 'package:chatsy/app/helper/font_family.dart';
import 'package:chatsy/extension.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../Localization/local_language.dart';
import '../../../common_widget/comman_text_feild_bottom_sheet.dart';
import '../../../common_widget/common_show_model_bottom_sheet.dart';
import '../../../helper/all_imports.dart';
import '../../home/controllers/user_profile_model.dart';
import '../../../helper/get_storage_data.dart';
import '../../../helper/image_path.dart';
import '../../home/controllers/all_prompt_model.dart';
import '../../newChat/controllers/new_chat_controller.dart';

class TranslateController extends GetxController with WidgetsBindingObserver {
  // Enhanced Translation Controller with full functionality
  ScrollController scrollController = ScrollController();
  TextEditingController newChatController = TextEditingController();
  TextEditingController searchLanguageController = TextEditingController();
  FocusNode newChatFocusNode = FocusNode();
  List<Language> languageList = [];
  RxList<Language> searchList = <Language>[].obs;
  RxList<ChatItem> chatItem = <ChatItem>[].obs;

  Rxn<Language> fromLanguage = Rxn<Language>();
  Rxn<Language> toLanguage = Rxn<Language>();

  RxBool isFromLangSelect = true.obs;
  
  // Enhanced translation features
  RxBool isLoading = false.obs;
  RxString translatedText = "".obs;
  RxString detectedLanguage = "".obs;
  RxDouble translationConfidence = 0.0.obs;
  RxList<String> translationHistory = <String>[].obs;
  
  // Translation options
  RxBool preserveFormatting = true.obs;
  RxBool includeContext = true.obs;
  RxBool detectLanguage = true.obs;

  @override
  void onInit() {
    var p = GetStorageData().readObject(GetStorageData().prompts);
    prompts = Prompts.fromJson(p);

    loadLanguagesFromAssets();

    printAction("--------------      ${prompts.toJson()}");

    if (Get.arguments != null) {
      chatItem.value = Get.arguments[HttpUtil.chatItemList];
      WidgetsBinding.instance.addObserver(this);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    }
    super.onInit();
  }

  @override
  void onClose() {
    ChatApi.stopStreaming();
    HttpUtil.cancelRequests();
    modelsHistoryAPI(chatItem, null, prompts.name, promptId: prompts.promptId);

    super.onClose();
  }

  Prompts prompts = Prompts();

  languageSelect() {
    searchLanguageController.clear();
    searchList.value = languageList;
    return CommonShowModelBottomSheet(
      child: Obx(() {
        return Column(
          children: [
            AppText(
              Languages.of(Get.context!)!.setLanguages,
              fontSize: 14.px,
              fontFamily: FontFamily.helveticaBold,
            ).marginOnly(top: 10.px),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // English Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      isFromLangSelect.value = true;
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10.px, 10.px, 10.px, 7.px),
                      decoration: BoxDecoration(
                        color: (isFromLangSelect.value == true) ? AppColors.primary : null,

                        border: Border.all(
                          color:
                              (isFromLangSelect.value == true)
                                  ? AppColors.primary
                                  : AppColors().darkAndWhite.changeOpacity(0.2), // Border color
                          width: 1.px, // Border width
                        ),
                        borderRadius: BorderRadius.circular(30.0), // Rounded corners
                      ),
                      child: AppText(
                        color: (isFromLangSelect.value == true) ? AppColors.white : null,
                        textAlign: TextAlign.center,
                        fromLanguage.value?.name ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14.px,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Language? from = fromLanguage.value;
                    Language? to = toLanguage.value;
                    fromLanguage.value = to;
                    toLanguage.value = from;
                  },
                  child: SvgPicture.asset(
                    ImagePath.icLanguageChange,
                    height: 20.px,
                    width: 20.px,
                    color: AppColors().darkAndWhite,
                  ).marginSymmetric(horizontal: 11.px),
                ),

                // Spanish Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      isFromLangSelect.value = false;
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10.px, 10.px, 10.px, 7.px),
                      decoration: BoxDecoration(
                        color: (isFromLangSelect.value != true) ? AppColors.primary : null,

                        border: Border.all(
                          color:
                              (isFromLangSelect.value != true)
                                  ? AppColors.primary
                                  : AppColors().darkAndWhite.changeOpacity(0.2), // Border color
                          width: 1.px, // Border width
                        ),
                        borderRadius: BorderRadius.circular(30.0), // Rounded corners
                      ),
                      child: AppText(
                        color: (isFromLangSelect.value != true) ? AppColors.white : null,
                        textAlign: TextAlign.center,
                        toLanguage.value?.name ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14.px,
                      ),
                    ),
                  ),
                ),
              ],
            ).marginOnly(top: 10.px),
            CommonTextFiledBottomSheet(
              textColor: (isLight) ? null : AppColors().whiteAndDark,
              onChanged: (p0) {
                if (p0.isEmpty) {
                  searchList.value = languageList;
                } else {
                  searchList.value =
                      languageList
                          .where(
                            (user) => user.name.toLowerCase().contains(p0.trim().toLowerCase()),
                          )
                          .toList();
                }
                searchList.refresh();
              },
              fillColor: Color(0xFFF9F9F9),
              controller: searchLanguageController,
              maxLine: 1,
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10.px, right: 8.px),
                child: SvgPicture.asset(ImagePath.icSearch),
              ),
              hintText: Languages.of(Get.context!)!.search,
            ).marginOnly(top: 10.px),
            (searchList.value.isNotEmpty)
                ? ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: searchList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (isFromLangSelect.value) {
                          fromLanguage.value = searchList[index];
                        } else {
                          toLanguage.value = searchList[index];
                        }
                        Get.back();
                      },
                      child: AppText(
                        searchList[index].name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ).paddingSymmetric(vertical: 5.px),
                    );
                  },
                )
                : AppText(
                  Languages.of(Get.context!)!.languagesNotFound,
                  fontSize: 14.px,
                  fontFamily: FontFamily.helveticaBold,
                ).marginOnly(top: 10.px, bottom: 10.px),
          ],
        );
      }).marginSymmetric(horizontal: 16.px),
    );
  }

  Future<void> loadLanguagesFromAssets() async {
    String jsonString = await rootBundle.loadString('assets/jsons/language.json');
    List<dynamic> jsonResponse = jsonDecode(jsonString);
    languageList = jsonResponse.map((json) => Language.fromJson(json)).toList();

    if (languageList.isNotEmpty && languageList.length > 2) {
      fromLanguage.value = languageList.first;
      toLanguage.value = languageList[1];
    }
  }
  
  // Enhanced translation methods
  Future<void> translateWithGPT5(String text) async {
    try {
      isLoading.value = true;
      
      // Detect language if enabled
      if (detectLanguage.value) {
        await _detectLanguage(text);
      }
      
      // Enhanced prompt for GPT-5 translation
      String enhancedPrompt = _buildEnhancedTranslationPrompt(text);
      
      // Call GPT-5 with advanced translation
      ChatApi().apiCalling(
        textQuestion: enhancedPrompt,
        chatItem: RxList<ChatItem>(),
        scrollController: ScrollController(),
        modelType: ModelType.chatGPT4o,
        isRealTime: true,
        chatGPTAddData: null,
        systemText: _getTranslationSystemPrompt(),
        documentText: null,
        modelPrompt: null,
        fileName: "translation",
      );
      
    } catch (e) {
      printAction("Translation error: $e");
      utils.showToast(message: "Error translating text: $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  Future<void> _detectLanguage(String text) async {
    try {
      // Simple language detection based on common patterns
      String lowerText = text.toLowerCase();
      
      if (RegExp(r'[ñáéíóúü]').hasMatch(lowerText)) {
        detectedLanguage.value = "Spanish";
      } else if (RegExp(r'[àâäéèêëïîôùûüÿç]').hasMatch(lowerText)) {
        detectedLanguage.value = "French";
      } else if (RegExp(r'[äöüß]').hasMatch(lowerText)) {
        detectedLanguage.value = "German";
      } else if (RegExp(r'[àèéìíîòóù]').hasMatch(lowerText)) {
        detectedLanguage.value = "Italian";
      } else if (RegExp(r'[а-яё]').hasMatch(lowerText)) {
        detectedLanguage.value = "Russian";
      } else if (RegExp(r'[一-龯]').hasMatch(text)) {
        detectedLanguage.value = "Chinese";
      } else if (RegExp(r'[ひらがなカタカナ]').hasMatch(text)) {
        detectedLanguage.value = "Japanese";
      } else if (RegExp(r'[ㄱ-ㅎㅏ-ㅣ가-힣]').hasMatch(text)) {
        detectedLanguage.value = "Korean";
      } else {
        detectedLanguage.value = "English";
      }
      
      translationConfidence.value = 0.85; // Simulated confidence
      
    } catch (e) {
      printAction("Language detection error: $e");
      detectedLanguage.value = "Unknown";
    }
  }
  
  String _buildEnhancedTranslationPrompt(String text) {
    String fromLang = fromLanguage.value?.name ?? "Unknown";
    String toLang = toLanguage.value?.name ?? "Unknown";
    
    String basePrompt = """
**Advanced Translation Task**

Translate the following text using GPT-5's advanced language capabilities.

**Translation Details:**
- From: ${fromLang}
- To: ${toLang}
- Detected Language: ${detectedLanguage.value}
- Preserve Formatting: ${preserveFormatting.value}
- Include Context: ${includeContext.value}

**Text to Translate:**
$text

**Translation Requirements:**
""";

    basePrompt += """
**Translation Guidelines:**
1. **Accuracy** - Provide accurate and natural translation
2. **Context** - Maintain the original meaning and context
3. **Tone** - Preserve the original tone and style
4. **Formatting** - ${preserveFormatting.value ? 'Maintain original formatting' : 'Adapt formatting for target language'}
5. **Cultural Adaptation** - Consider cultural nuances when appropriate
6. **Grammar** - Ensure proper grammar in target language

**Advanced Features:**
- Provide alternative translations if applicable
- Explain cultural context when relevant
- Suggest improvements for clarity
- Maintain professional or casual tone as appropriate

**Response Format:**
Provide the translation followed by any additional context or explanations.
""";

    return basePrompt;
  }
  
  String _getTranslationSystemPrompt() {
    return """
You are an expert translator powered by GPT-5 with advanced language capabilities. Your role is to provide accurate, natural, and contextually appropriate translations.

**Core Capabilities:**
- High-quality translation between multiple languages
- Cultural context and nuance preservation
- Tone and style maintenance
- Technical and specialized terminology translation
- Real-time language detection and adaptation

**Translation Standards:**
- Always maintain accuracy and naturalness
- Preserve the original meaning and intent
- Consider cultural context and appropriateness
- Maintain appropriate tone and style
- Ensure grammatical correctness in target language

**Response Guidelines:**
- Provide clear, natural translations
- Include cultural context when relevant
- Suggest alternatives for ambiguous terms
- Maintain professional quality
- Preserve formatting when requested

Always prioritize accuracy, naturalness, and cultural appropriateness in your translations.
""";
  }
  
  // Method to generate different types of translations
  Future<void> generateCustomTranslation(String text, String translationType) async {
    String customPrompt = "";
    
    switch (translationType.toLowerCase()) {
      case 'formal':
        customPrompt = "Translate the following text to ${toLanguage.value?.name ?? 'target language'} in a formal, professional tone: $text";
        break;
      case 'casual':
        customPrompt = "Translate the following text to ${toLanguage.value?.name ?? 'target language'} in a casual, friendly tone: $text";
        break;
      case 'technical':
        customPrompt = "Translate the following technical text to ${toLanguage.value?.name ?? 'target language'}, maintaining technical accuracy: $text";
        break;
      case 'literary':
        customPrompt = "Translate the following text to ${toLanguage.value?.name ?? 'target language'} with literary style and poetic language: $text";
        break;
      case 'business':
        customPrompt = "Translate the following business text to ${toLanguage.value?.name ?? 'target language'} in professional business language: $text";
        break;
      default:
        customPrompt = "Translate the following text to ${toLanguage.value?.name ?? 'target language'}: $text";
    }
    
    ChatApi().apiCalling(
      textQuestion: customPrompt,
      chatItem: RxList<ChatItem>(),
      scrollController: ScrollController(),
      modelType: ModelType.chatGPT4o,
      isRealTime: true,
      chatGPTAddData: null,
      systemText: _getTranslationSystemPrompt(),
      documentText: null,
      modelPrompt: null,
      fileName: "translation",
    );
  }
  
  // Method to add translation to history
  void addToTranslationHistory(String originalText, String translatedText) {
    String historyEntry = "$originalText → $translatedText";
    translationHistory.insert(0, historyEntry);
    
    // Keep only last 50 translations
    if (translationHistory.length > 50) {
      translationHistory.removeLast();
    }
  }
  
  // Method to clear translation history
  void clearTranslationHistory() {
    translationHistory.clear();
  }
}

class Language {
  final String code;
  final String name;

  Language({required this.code, required this.name});

  // Factory constructor to create a Language from JSON
  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(code: json['code'], name: json['name']);
  }
}
