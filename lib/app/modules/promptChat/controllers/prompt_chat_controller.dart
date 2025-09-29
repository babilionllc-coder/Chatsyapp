import '../../../helper/all_imports.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../home/controllers/user_profile_model.dart';
import '../../newChat/controllers/new_chat_controller.dart';

class PromptChatController extends GetxController
    with WidgetsBindingObserver, ModelSwitcher {
  final scrollController = ScrollController();
  RxList<ChatItem> chatItem = <ChatItem>[].obs;
  final newChatController = TextEditingController();
  final newChatFocusNode = FocusNode();
  var menu = false.obs;
  RxInt apiCall = 0.obs;

  String promptId = "";
  String promptName = "";

  @override
  void onInit() {
    getInitialModel();
    if (ChatApi.isStreamingData.value) {
      ChatApi.isStreamingData.value = false;
    }
    getStorageData.saveSend(value: false);
    getStorageData.saveListening(value: false);
    if (Get.arguments != null) {
      promptId = Get.arguments['promptId'];
      promptName = Get.arguments['name'];

      if (!utils.isValidationEmpty(Get.arguments['question'])) {
        ChatApi().apiCalling(
          textQuestion: Get.arguments['question'],
          chatItem: chatItem,
          scrollController: scrollController,
          promptId: promptId,
          modelTitle: promptName,
          modelName: modelTypeForDropDown?.value?.model,
          modelType: modelTypeForDropDown?.value?.modelType,
        );
      }

      if (Get.arguments[HttpUtil.chatItemList] != null) {
        chatItem.value = Get.arguments[HttpUtil.chatItemList];

        WidgetsBinding.instance.addObserver(this);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        });
      }
    }
    super.onInit();
  }

  @override
  Future<void> onClose() async {
    ChatApi.stopStreaming();
    HttpUtil.cancelRequests();
    modelsHistoryAPI(chatItem, null, promptName, promptId: promptId);

    Get.put(
      BottomNavigationController(),
    ).backToTemplateOrAssistants(apiCall: apiCall);

    super.onClose();
  }
}

mixin ModelSwitcher on GetxController {
  Rx<ToolsModel?>? modelTypeForDropDown;

  void getInitialModel({ToolsModel? otherModel}) {
    if (otherModel != null) {
      modelTypeForDropDown = Rx(otherModel);
      return;
    }

    var index = 0;

    if (getStorageData.containKey(getStorageData.selectModelIndex)) {
      index = int.parse(
        getStorageData.readString(getStorageData.selectModelIndex) ?? "0",
      );
    }

    modelTypeForDropDown = Rx(
      Get.find<BottomNavigationController>().selectAiModelList[index],
    );
  }
}
