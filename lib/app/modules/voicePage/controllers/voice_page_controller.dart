import 'package:chatsy/app/modules/home/controllers/user_profile_model.dart';

import '../../../api_repository/api_function.dart';
import '../../../api_repository/loading.dart';
import '../../../common_widget/error_and_update_dialog.dart';
import '../../../helper/all_imports.dart';
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
      getVoiceListAPI();
    }
    super.onInit();
  }
  
  // Enhanced method to fetch voices directly from ElevenLabs
  Future<void> fetchElevenLabsVoices() async {
    try {
      // Initialize ElevenLabs API
      await Global.elevenLabInit();
      
      // Fetch voices directly from ElevenLabs
      final voices = await Global.elevenLabs.listVoices();
      
      printAction("=== ElevenLabs Voices Available ===");
      printAction("Total voices: ${voices.length}");
      
      for (int i = 0; i < voices.length; i++) {
        final voice = voices[i];
        printAction("Voice ${i + 1}:");
        printAction("  - Name: ${voice.name}");
        printAction("  - ID: ${voice.voiceId}");
        printAction("  - Category: ${voice.category}");
        printAction("  - Language: ${voice.language ?? 'Not specified'}");
        printAction("  - Preview URL: ${voice.previewUrl}");
        printAction("  - Description: ${voice.description ?? 'No description'}");
        printAction("  ---");
      }
      
      // Convert ElevenLabs voices to app format
      List<VoiceDtl> elevenLabsVoices = voices.map((voice) => VoiceDtl(
        voiceId: voice.voiceId,
        name: voice.name,
        elevenLabId: voice.voiceId,
        img: voice.previewUrl,
        isActive: "1",
        isSelected: voice.voiceId == Constants.elevenLabId ? "1" : "0",
      )).toList();
      
      // Update voice list with ElevenLabs voices
      voiceList.value = elevenLabsVoices;
      
      printAction("Updated voice list with ${voiceList.length} ElevenLabs voices");
      
    } catch (e) {
      printAction("Error fetching ElevenLabs voices: $e");
      utils.showSnackBar("Error fetching voices: $e");
    }
  }
}
