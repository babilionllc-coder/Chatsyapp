import 'dart:developer';

import 'package:chatsy/app/api_repository/api_function.dart';
import 'package:chatsy/app/helper/all_imports.dart';

import '../../../common_widget/error_and_update_dialog.dart';
import '../../../helper/Global.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../home/controllers/user_profile_model.dart';
import '../../newChat/models/phm_id_model.dart';

class ImageScanController extends GetxController with WidgetsBindingObserver {
  //TODO: Implement ImageScanController
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
  ];

  RxList<String> newQuestionList = <String>[].obs;

  var endAnimFinish = false.obs;

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
}
