import 'package:chatsy/app/api_repository/api_function.dart';
import 'package:chatsy/app/modules/chat_gpt/controllers/chat_gpt_controller.dart';

import '../../../Localization/locale_constant.dart';
import '../../../common_widget/error_and_update_dialog.dart';
import '../../../helper/all_imports.dart';
import '../../AssistantsPage/controllers/assistants_page_controller.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../purchase/controllers/purchase_controller.dart';
import '../model/change_lan_model.dart';

class LanguagePageController extends GetxController {
  //TODO: Implement LanguagePageController

  List<SubscriptionCarousel> languageList = [];
  RxInt count = 0.obs;

  changeLanguageAPI({required String languageCode}) async {
    String uid = getStorageData.readString(getStorageData.userId) ?? "";
    String token = getStorageData.readString(getStorageData.token) ?? "";
    printAction("getStorageData.saveString--- $token");

    FormData formData = FormData.fromMap({"user_id": uid, 'language': languageCode});

    final data = await APIFunction().apiCall(
      apiName: Constants.changeLanguage,
      params: formData,
      token: token,
    );

    ChangeLanModel model = ChangeLanModel.fromJson(data);

    if (model.responseCode == 1) {
      await changeLanguage(Get.context!, languageCode);
      getStorageData.saveObject(getStorageData.loginData, model.data!);
      getStorageData.saveString(getStorageData.userId, model.data?.userId);
      getStorageData.saveString(getStorageData.token, model.data?.token);
      printAction("getStorageData.saveString ${model.data!}");
      printAction("getStorageData.saveString ${getStorageData.readString(getStorageData.token)}");
      getStorageData.saveString(getStorageData.chatLimit, model.data?.chatLimit);
      getStorageData.saveString(getStorageData.isSubscription, model.data?.isSubscription);

      await Get.find<BottomNavigationController>().getUserProfileAPI(isLoading: true);
      await Get.find<BottomNavigationController>().getAllPromptAPI(isLoading: true);
      await Get.find<AssistantsPageController>().getAssistantData(refresh: true);

      Get.put(BottomNavigationController()).update();
    } else if (model.responseCode == 0) {
      errorDialog(model.responseMsg);
    } else if (model.responseCode == 26) {
      updateDialog(model.responseMsg);
    } else {
      if (model.responseMsg == "Your chat limit used.") {
        Get.put(ChatGptController()).goToPurchasePage();
      }
      utils.showToast(message: model.responseMsg!);
    }
  }
}
