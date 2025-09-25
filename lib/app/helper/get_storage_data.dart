import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/modules/newChat/models/history_model.dart';
import 'package:chatsy/app/routes/app_pages.dart';
import 'package:get_storage/get_storage.dart';

import '../modules/home/controllers/ai_assistants_model.dart';
import '../modules/home/controllers/all_prompt_model.dart';
import '../modules/home/controllers/user_profile_model.dart';
import 'app_colors.dart' as appColor;

/// <<< To store data in phone storage --------- >>>
class GetStorageData {
  String palm = "palm";
  String token = "token";
  String gpt4o = "gpt4o";
  String email = "email";
  String userId = "userId";
  String gemini = "gemini";
  String deepseek = "deepseek";
  String isLight = "isLight";
  String profile = "profile";
  String isGuestMode = "is_guest_mode";
  String prompts = "prompts";
  String chatGPT = "chat_GPT";
  String isIntro = "is_intro";
  String deviceId = "deviceId";
  String userName = "user_name";
  String isReview = "is_review";
  String loginData = "new_login_data";
  String chatLimit = "chatLimit";
  String visionScan = "visionScan";
  String summarizeWebsite = "SummarizeWebsite";
  String textScan = "TextScan";
  String summarizePDF = "Summarize PDF";
  String isProductId = "product_id";
  String uploadAndAsk = "uploadAndAsk";
  String previousDate = "previousDate";
  String imageGeneration = "imageGeneration";
  String isSubscription = "is_subscription";
  String selectModelIndex = "selectModelIndex";
  String isSend = "is_send";
  String isListening = "is_listening";
  String deviceToken = "device_token";
  String firstTimeAppOpen = "firstTimeAppOpen";

  String userProfileData = "user_profile_data";

  String assistantsList = "assistants_list";
  String allPromptData = "all_promptData";
  String historyList = "history_list";
  String suggestionView = "suggestion_view";
  String elevenLabId = "eleven_lab_id";

  saveSend({required bool value}) {
    final box = GetStorage();
    // if (ChatApi.isStreamingData.value) {
    //   return null;
    // } else {
    return box.write(isSend, value);
    // }
  }

  bool readSend() {
    if (containKey(isSend)) {
      final box = GetStorage();
      var result = box.read(isSend);
      return result;
    } else {
      return false;
    }
  }

  saveListening({required bool value}) {
    final box = GetStorage();
    return box.write(isListening, value);
  }

  bool readListening() {
    if (containKey(isListening)) {
      final box = GetStorage();
      var result = box.read(isListening);
      return result;
    } else {
      return false;
    }
  }

  saveUserProfileData(UserProfileData value) {
    final box = GetStorage();

    box.write(userProfileData, value.toJson());
  }

  UserProfileData readUserProfileData() {
    if (containKey(userProfileData)) {
      printAction(" if fif fifififififfifififi");
      final box = GetStorage();
      var result = box.read(userProfileData);

      return UserProfileData.fromJson(result);
    } else {
      printAction("  else else else else else else else ");

      return UserProfileData();
    }
  }

  saveAssistantsList({required List<AssistantData> value}) {
    final box = GetStorage();
    final List<Map<String, dynamic>> jsonList =
        value.map((model) => model.toJson()).toList();
    // Save to GetStorage
    box.write(assistantsList, jsonList);
  }

  List<AssistantData> readAssistantsList() {
    final box = GetStorage();

    final List<dynamic> jsonList = box.read(assistantsList) ?? [];
    return jsonList.map((json) => AssistantData.fromJson(json)).toList();
  }

  saveAllPromptData({required List<AllPromptData> value}) async {
    final box = GetStorage();
    final List<Map<String, dynamic>> jsonList =
        value.map((model) => model.toJson()).toList();
    // Save to GetStorage
    box.write(allPromptData, jsonList);
  }

  List<AllPromptData> readAllPromptData() {
    final box = GetStorage();

    final List<dynamic> jsonList = box.read(allPromptData) ?? [];
    return jsonList.map((json) => AllPromptData.fromJson(json)).toList();
  }

  /// <<< To save object data --------- >>>
  saveString(String key, String? value) async {
    final box = GetStorage();
    return box.write(key, value);
  }

  saveBool(String key, bool value) async {
    final box = GetStorage();
    return box.write(key, value);
  }

  /// <<< To read object data --------- >>>
  String? readString(String key) {
    if (containKey(key)) {
      final box = GetStorage();
      if (box.hasData(key)) {
        return box.read(key).toString();
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  bool? readBool(String key) {
    if (containKey(key)) {
      final box = GetStorage();
      if (box.hasData(key)) {
        return box.read(key);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  /// <<< To remove data --------- >>>
  removeData(String key) async {
    final box = GetStorage();
    return box.remove(key);
  }

  /// <<< To Store Key data --------- >>>
  bool containKey(String key) {
    final box = GetStorage();
    return box.hasData(key);
  }

  saveObject(String key, value) {
    final box = GetStorage();
    String allData = jsonEncode(value);
    box.write(key, allData);
  }

  Map<String, dynamic> readObject(String key) {
    final box = GetStorage();
    var result = box.read(key);
    if (result == null) return {};
    return jsonDecode(result);
  }

  saveHistory({required HistoryModel value}) {
    final box = GetStorage();

    return box.write(historyList, value);
  }

  Future<void> removeLoginData() async {
    final box = GetStorage();
    await Future.wait([
      box.remove(palm),
      box.remove(token),
      box.remove(gpt4o),
      box.remove(email),
      box.remove(userId),
      box.remove(gemini),
      box.remove(isLight),
      box.remove(profile),
      box.remove(prompts),
      box.remove(chatGPT),
      box.remove(isIntro),
      box.remove(deviceId),
      box.remove(userName),
      box.remove(isReview),
      box.remove(loginData),
      box.remove(chatLimit),
      box.remove(visionScan),
      box.remove(summarizeWebsite),
      box.remove(textScan),
      box.remove(summarizePDF),
      box.remove(isProductId),
      box.remove(uploadAndAsk),
      box.remove(previousDate),
      box.remove(imageGeneration),
      box.remove(isSubscription),
      box.remove(selectModelIndex),
      box.remove(isSend),
      box.remove(isListening),
      box.remove(firstTimeAppOpen),
      box.remove(suggestionView),
      box.remove(userProfileData),
      box.remove(historyList),
      box.remove(isGuestMode),
    ]);

    Get.offAllNamed(Routes.SPLASH);
    bool darkLight = getStorageData.readBool(getStorageData.isLight) ?? true;

    if (darkLight) {
      appColor.isLight = true;
    } else {
      appColor.isLight = false;
    }
  }
}
