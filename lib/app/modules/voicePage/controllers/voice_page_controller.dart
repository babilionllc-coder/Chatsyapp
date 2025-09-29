import 'package:chatsy/app/modules/home/controllers/user_profile_model.dart';

import '../../../api_repository/api_function.dart';
import '../../../api_repository/loading.dart';
import '../../../common_widget/error_and_update_dialog.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/Global.dart';
import '../models/get_voice_model.dart';

class VoicePageController extends GetxController {
  RxInt count = 0.obs;

  RxList<VoiceDtl> voiceList = <VoiceDtl>[].obs;

  void getVoiceListAPI() async {
    try {
      var userId = getStorageData.readString(getStorageData.userId);
      FormData formData = FormData.fromMap({"user_id": userId});

      final data = await APIFunction().apiCall(
        apiName: Constants.getVoiceList,
        params: formData,
        token: getStorageData.readString(getStorageData.token),
      );

      GetVoiceModel model = GetVoiceModel.fromJson(data);

      if (model.responseCode == 1) {
        voiceList.value = model.data?.voiceList ?? voiceList;

        count.value = voiceList.indexWhere((element) {
          return element.isSelected == "1";
        });
        if (count.value < 0) {
          count.value = 0;
        }
      } else if (model.responseCode == 0) {
        errorDialog(model.responseMsg);
      } else if (model.responseCode == 26) {
        updateDialog(model.responseMsg);
      } else {
        utils.showToast(message: model.responseMsg!);
        Loading.dismiss();
      }
    } catch (e) {
      Loading.dismiss();
    }
  }

  void updateVoiceStatusAPI({required String voiceId, required int index}) async {
    try {
      var userId = getStorageData.readString(getStorageData.userId);
      FormData formData = FormData.fromMap({"user_id": userId, "voice_id": voiceId});
      final data = await APIFunction().apiCall(
        apiName: Constants.updateVoiceStatus,
        params: formData,
        token: getStorageData.readString(getStorageData.token),
      );
      GetVoiceModel model = GetVoiceModel.fromJson(data);

      if (model.responseCode == 1) {
        count.value = index;
        Constants.elevenLabId = voiceList[count.value].elevenLabId ?? Constants.elevenLabId;
      } else if (model.responseCode == 0) {
        errorDialog(model.responseMsg);
      } else if (model.responseCode == 26) {
        updateDialog(model.responseMsg);
      } else {
        utils.showToast(message: model.responseMsg!);
        Loading.dismiss();
      }
    } catch (e) {
      Loading.dismiss();
    }
  }

  @override
  void onInit() {
    if (Constants.isShowElevenLab == "1") {
      // Load all ElevenLabs voices and select top 3
      fetchElevenLabsVoices();
    }
    super.onInit();
  }
  
  // Enhanced method to fetch voices directly from ElevenLabs and select top 3
  Future<void> fetchElevenLabsVoices() async {
    try {
      // Initialize ElevenLabs API
      await Global.elevenLabInit();
      
      // Fetch voices directly from ElevenLabs
      final voices = await Global.elevenLabs.listVoices();
      
      printAction("=== ElevenLabs Voices Available ===");
      printAction("Total voices: ${voices.length}");
      
      // Select the top 3 best voices for the app
      List<String> topVoiceIds = [
        "EXAVITQu4vr4xnSDxMaL", // Sarah - Professional female voice
        "2EiwWnXFnvU5JabPnv8n", // Clyde - Character male voice
        "CwhRBWXzGAHq8TQ4Fs17", // Roger - Casual male voice
      ];
      
      // Filter to get only the top 3 voices
      final selectedVoices = voices.where((voice) => topVoiceIds.contains(voice.voiceId)).toList();
      
      printAction("=== Selected Top 3 Voices ===");
      for (int i = 0; i < selectedVoices.length; i++) {
        final voice = selectedVoices[i];
        printAction("Voice ${i + 1}:");
        printAction("  - Name: ${voice.name}");
        printAction("  - ID: ${voice.voiceId}");
        printAction("  - Category: ${voice.category}");
        printAction("  - Language: ${voice.language ?? 'Not specified'}");
        printAction("  - Description: ${voice.description ?? 'No description'}");
        printAction("  ---");
      }
      
      // Convert ElevenLabs voices to app format
      List<VoiceDtl> elevenLabsVoices = selectedVoices.map((voice) => VoiceDtl(
        voiceId: voice.voiceId,
        name: voice.name,
        elevenLabId: voice.voiceId,
        img: voice.previewUrl,
        isActive: "1",
        isSelected: voice.voiceId == Constants.elevenLabId ? "1" : "0",
      )).toList();
      
      // Update voice list with top 3 ElevenLabs voices
      voiceList.value = elevenLabsVoices;
      
      printAction("Updated voice list with ${voiceList.length} top ElevenLabs voices");
      
    } catch (e) {
      printAction("Error fetching ElevenLabs voices: $e");
      utils.showToast(message: "Error fetching voices: $e");
    }
  }
}
