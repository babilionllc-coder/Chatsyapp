import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:chatsy/Customs/buttons.dart';
import 'package:chatsy/app/common_widget/comman_text_field.dart';
import 'package:chatsy/app/common_widget/common_button.dart';
import 'package:chatsy/app/helper/Global.dart';
import 'package:chatsy/app/helper/permission_controller.dart';
import 'package:chatsy/app/modules/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:chatsy/app/modules/chat_gpt/controllers/chat_gpt_controller.dart';
import 'package:chatsy/app/modules/home/controllers/user_profile_model.dart';
import 'package:chatsy/app/modules/newChat/component/summarize_text.dart';
import 'package:chatsy/extension.dart';
import 'package:chatsy/service/AI%20Chat/ai_chat_service.dart';
import 'package:chatsy/service/core/exception.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../Localization/local_language.dart';
import '../../../api_repository/api_function.dart';
import '../../../api_repository/loading.dart';
import '../../../common_widget/common_container.dart';
import '../../../common_widget/common_show_model_bottom_sheet.dart';
import '../../../common_widget/error_and_update_dialog.dart';
import '../../../common_widget/iphone_has_notch.dart';
import '../../../common_widget/rx_common_model.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/font_family.dart';
import '../../../helper/image_path.dart';
import '../../../routes/app_pages.dart';
import '../../AssistantsPage/controllers/assistants_page_controller.dart';
import '../../home/controllers/ai_assistants_model.dart';
import '../../home/controllers/all_prompt_model.dart';
import '../../home/controllers/home_controller.dart';
import '../../newChat/controllers/new_chat_controller.dart';
import '../../settings/controllers/settings_controller.dart';
import '../../splash/controllers/appsflyer_controller.dart';
import '../../splash/controllers/login_model.dart';

class BottomNavigationController extends GetxController
    with GetTickerProviderStateMixin {
  SpeechToText speechToText = SpeechToText();

  List<RxCommonModel> addOtherPromptsList = [
    RxCommonModel(
      title: Languages.of(Get.context!)!.imageScan,
      image: ImagePath.imageScanIcon,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.uploadFile,
      image: ImagePath.file,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.summarizeWeb,
      image: ImagePath.link,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.generateImage,
      image: ImagePath.generateImagesIcon,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.scanText,
      image: ImagePath.scan,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.aiAssistants,
      image: ImagePath.assistants,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.templates,
      image: ImagePath.templates,
    ),
  ];
  String userId = "";
  RxInt selectedIndex = 1.obs;
  TabController? tabController;
  final promptTitleList = RxList<AllPromptData>();
  List<AssistantData> assistantsList = [];
  TextEditingController nameController = TextEditingController();
  RxList<BottomNavigationItem> bottomBarItem = <BottomNavigationItem>[].obs;

  bool isVisible = true;
  LoginData? loginData;

  String removeEmojis(String input) {
    return input.replaceAll(
      RegExp(
        r'[\u{1F600}-\u{1F64F}|' // Emoticons
        r'\u{1F300}-\u{1F5FF}|' // Misc Symbols and Pictographs
        r'\u{1F680}-\u{1F6FF}|' // Transport and Map
        r'\u{1F700}-\u{1F77F}|' // Alchemical Symbols
        r'\u{1F780}-\u{1F7FF}|' // Geometric Shapes Extended
        r'\u{1F800}-\u{1F8FF}|' // Supplemental Arrows-C
        r'\u{1F900}-\u{1F9FF}|' // Supplemental Symbols and Pictographs
        r'\u{1FA00}-\u{1FA6F}|' // Chess Symbols
        r'\u{1FA70}-\u{1FAFF}|' // Symbols and Pictographs Extended-A
        r'\u{2600}-\u{26FF}|' // Miscellaneous Symbols
        r'\u{2700}-\u{27BF}|' // Dingbats
        r'\u{FE00}-\u{FE0F}|' // Variation Selectors
        r'\u{1F1E0}-\u{1F1FF}|' // Flags
        r'\u{1F900}-\u{1F9FF}|' // Supplemental Symbols and Pictographs
        r'\u{1FA70}-\u{1FAFF}|' // Symbols and Pictographs Extended-A
        r'\u{200D}|' // Zero Width Joiner
        r'\u{2640}-\u{2642}|' // Gender Symbols
        r'\u{2600}-\u{2B55}|' // Miscellaneous Symbols and Arrows
        r'\u{2300}-\u{23FF}|' // Miscellaneous Technical
        r'\u{2B50}-\u{2B55}]', // Stars
        unicode: true,
        caseSensitive: false,
      ),
      '',
    );
  }

  Future<void> getLoginData() async {
    if (getStorageData.containKey(getStorageData.loginData)) {
      loginData = LoginData.fromJson(
        getStorageData.readObject(getStorageData.loginData),
      );
      userId = loginData!.userId!;
      // printAction("data User Id:++++++$userId");
    }
    update();
  }

  @override
  Future<void> onReady() async {
    await getUserProfileAPI(isLoading: false);

    AppsFlyerController.afStart();
    if (Platform.isIOS) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final status =
            await AppTrackingTransparency.requestTrackingAuthorization();
      });
    }
    super.onReady();
  }

  bool? navigatePurchase;

  dynamic argumentsData;

  @override
  Future<void> onInit() async {
    argumentsData = Get.arguments;
    getStorageData.saveSend(value: false);
    getStorageData.saveListening(value: false);

    valueSetUpUserProfile(
      userProfileData: getStorageData.readUserProfileData(),
      goToPurchaseScreen: true,
      apiCall: false,
    );

    assistantsList = getStorageData.readAssistantsList();
    promptTitleList.value = getStorageData.readAllPromptData();
    if (promptTitleList.isNotEmpty) {
      tabBarSetUp();
      Get.find<HomeController>().update();
    }
    selectedIndex = 1.obs;
    getLoginData();
    if (argumentsData != null) {
      await Future.delayed(const Duration(seconds: 1), () async {
        await welcomeBottomSheet();
      });
    }
    super.onInit();
  }

  List<RxCommonModel> lengthList = [
    RxCommonModel(title: "Auto"),
    RxCommonModel(title: "Short"),
    RxCommonModel(title: "Medium"),
    RxCommonModel(title: "Long"),
  ];

  List<RxCommonModel> responseToneList = [
    RxCommonModel(title: "🤖 Default"),
    RxCommonModel(title: "🧐 Professional"),
    RxCommonModel(title: "😃 Friendly"),
    RxCommonModel(title: "😇 Inspirational"),
    RxCommonModel(title: "😂 Joyful"),
    RxCommonModel(title: "😉 Persuasive"),
    RxCommonModel(title: "️🙂 Empathetic"),
    RxCommonModel(title: "😯 Surprised"),
    RxCommonModel(title: "😋 Optimistic"),
    RxCommonModel(title: "😂 Funny"),
    RxCommonModel(title: "😏 Curious"),
    RxCommonModel(title: "🙃 Sarcastic"),
    RxCommonModel(title: "😌 Cooperative"),
    RxCommonModel(title: "🥰 Romantic"),
    RxCommonModel(title: "😍 Passionate"),
  ];

  welcomeBottomSheet() async {
    nameController.text = loginData?.name ?? "";
    RxBool isWellComeLight = isLight.obs;
    await Get.bottomSheet(
      isScrollControlled: true,
      enableDrag: true,
      isDismissible: true,
      Obx(() {
        isWellComeLight;
        return Container(
          width: double.infinity,
          constraints: BoxConstraints(maxHeight: 80.h),
          decoration: BoxDecoration(
            color: AppColors().backgroundColor1,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.px),
              topRight: Radius.circular(30.px),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 64.px,
                      height: 4.px,
                      margin: EdgeInsets.only(top: 12.px),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(43.px),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        height: 85.px,
                        ImagePath.introLogo,
                      ).marginOnly(bottom: 12.px),
                      AppText(
                        fontSize: 24.px,
                        fontFamily: FontFamily.helveticaBold,
                        color: AppColors().darkAndWhite,
                        Languages.of(Get.context!)!.welcomeToAICHATSY,
                      ).marginOnly(bottom: 8.px),
                      AppText(
                        fontSize: 14.px,
                        Languages.of(Get.context!)!.wereDelightedToHaveYouHere,
                        color: AppColors().darkAndWhite.changeOpacity(.60),
                      ).marginOnly(bottom: 32.px),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    Languages.of(
                                      Get.context!,
                                    )!.howShouldWeCallYou,
                                style: TextStyle(
                                  fontSize: 12.px,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors().darkAndWhite,
                                ),
                              ),
                              TextSpan(
                                text:
                                    " (${Languages.of(Get.context!)!.optional})",
                                style: TextStyle(
                                  fontSize: 12.px,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors().darkAndWhite.changeOpacity(
                                    .50,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      CommonTextField(
                        // color: Colors.transparent,
                        hintText: Languages.of(Get.context!)!.enterName,

                        padding: EdgeInsets.symmetric(
                          vertical: 12.px,
                          horizontal: 10.px,
                        ),
                        borderRadius: BorderRadius.circular(15.px),
                        borderColor: AppColors().darkAndWhite.changeOpacity(
                          0.1,
                        ),
                        // hintTextStyle: TextStyle(
                        //   fontSize: 14.px,
                        //   fontWeight: FontWeight.w400,
                        //   color: AppColors().darkAndWhite.changeOpacity(.5),
                        // ),
                        controller: nameController,
                      ).marginOnly(top: 8.px, bottom: 12.px),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AppText(
                          fontSize: 12.px,
                          "${Languages.of(Get.context!)!.theme}:",
                          color: AppColors().darkAndWhite,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.px, bottom: 20.px),
                        padding: EdgeInsets.symmetric(
                          vertical: 10.px,
                          horizontal: 12.px,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15.px),
                          border: Border.all(
                            color: AppColors().darkAndWhite.changeOpacity(.1),
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              ImagePath.brightness2,
                              height: 25.px,
                              color: AppColors().darkAndWhite,
                            ).marginOnly(right: 8.px),
                            Expanded(
                              child: AppText(
                                fontSize: 14.px,
                                Languages.of(Get.context!)!.lightMode,
                                color: AppColors().darkAndWhite,
                              ),
                            ),
                            Transform.scale(
                              scale: 0.8,
                              child: CupertinoSwitch(
                                value: isWellComeLight.value,
                                activeTrackColor: AppColors.primary,
                                onChanged: (val) {
                                  isWellComeLight.value = val;
                                  HapticFeedback.mediumImpact();
                                  isLight = isWellComeLight.value;
                                  Loading.loadingInit();
                                  getStorageData.saveBool(
                                    getStorageData.isLight,
                                    isLight,
                                  );
                                  Get.put<ChatGptController>(
                                    ChatGptController(),
                                  ).update();
                                  Get.find<HomeController>().update();
                                  Get.put<BottomNavigationController>(
                                    BottomNavigationController(),
                                  ).update();
                                  Get.put<AssistantsPageController>(
                                    AssistantsPageController(),
                                  ).update();
                                  update();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      CommonButton(
                        textSize: 14.px,
                        textWeight: FontWeight.w600,
                        title: Languages.of(Get.context!)!.continues,
                        onTap: () async {
                          // isLight = isWellComeLight.value;
                          // Loading.loadingInit();
                          // getStorageData.saveString(getStorageData.isLight, isLight);
                          // Get.put<ChatGptController>(ChatGptController()).update();
                          // Get.put<HomeController>(HomeController()).update();
                          // Get.put<BottomNavigationController>(BottomNavigationController()).update();
                          // Get.put<AssistantsPageController>(AssistantsPageController()).update();
                          Get.back();

                          if (nameController.text.isNotEmpty) {
                            updateProfile(
                              image: ImagePath.user4,
                              userName: nameController.text.trim(),
                              filePath: null,
                            );
                          }
                        },
                      ),
                    ],
                  ).marginSymmetric(
                    horizontal: 16.px,
                    vertical: (IphoneHasNotch.hasNotch) ? 30.px : 20.px,
                  ),
                  SizedBox(height: 10.px),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget commonResponseToneBottomBar() {
    if (!utils.isValidationEmpty(loginData?.length)) {
      for (var item in lengthList) {
        item.isSelected = false;
      }
      for (var item in responseToneList) {
        item.isSelected = false;
      }
      for (var item in lengthList) {
        if (item.title.toLowerCase().contains(
          loginData?.length?.toLowerCase() ?? "",
        )) {
          item.isSelected = true;
        }
      }
    }

    if (!utils.isValidationEmpty(loginData?.responseTone)) {
      for (var item in responseToneList) {
        if (loginData!.responseTone!.toLowerCase().contains(
          removeEmojis(item.title.toLowerCase()).trim(),
        )) {
          item.isSelected = true;
        }
      }
    }

    return GestureDetector(
      onTap: () {
        CommonShowModelBottomSheet(
          // isDismissible: false,
          // enableDrag: false,
          child: GetBuilder<BottomNavigationController>(
            init: BottomNavigationController(),
            builder: (controller) {
              return Container(
                // constraints: BoxConstraints(maxHeight: 90.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      Languages.of(Get.context!)!.length,
                      fontFamily: FontFamily.helveticaBold,
                    ),
                    SizedBox(height: 10.px),
                    Wrap(
                      spacing: 10.px,
                      runSpacing: 10.px,
                      children:
                          lengthList.map((e) {
                            return GestureDetector(
                              onTap: () {
                                if (!e.isSelected) {
                                  for (var item in lengthList) {
                                    item.isSelected = false;
                                  }
                                  e.isSelected = true;
                                  controller.update();
                                }
                              },
                              child: CommonContainer(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.px,
                                  horizontal: 10.px,
                                ),
                                isBorder: true,
                                color:
                                    e.isSelected
                                        ? AppColors.primary
                                        : Colors.transparent,
                                radius: 44.px,
                                border: Border.all(
                                  color:
                                      e.isSelected
                                          ? Colors.transparent
                                          : AppColors().darkAndWhite
                                              .changeOpacity(0.04),
                                  width: 2,
                                ),
                                child: AppText(
                                  e.title,
                                  color: AppColors().darkAndWhite,
                                  fontSize: 14.px,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 24.px),
                    AppText(
                      Languages.of(Get.context!)!.responseTone,
                      fontFamily: FontFamily.helveticaBold,
                    ),
                    SizedBox(height: 10.px),
                    Wrap(
                      spacing: 10.px,
                      runSpacing: 10.px,
                      children:
                          responseToneList.map((e) {
                            return GestureDetector(
                              onTap: () {
                                for (var element in responseToneList) {
                                  element.isSelected = false;
                                }
                                e.isSelected = true;
                                controller.update();
                              },
                              child: CommonContainer(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.px,
                                  horizontal: 10.px,
                                ),
                                isBorder: true,
                                color:
                                    e.isSelected
                                        ? AppColors.primary
                                        : Colors.transparent,
                                radius: 44.px,
                                border: Border.all(
                                  color:
                                      e.isSelected
                                          ? Colors.transparent
                                          : AppColors().darkAndWhite
                                              .changeOpacity(0.04),
                                  width: 2,
                                ),
                                child: AppText(
                                  e.title,
                                  color: AppColors().darkAndWhite,
                                  fontSize: 14.px,
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 24.px),
                    CommonButton(
                      onTap: () {
                        responseToneAPI();
                      },
                      title: Languages.of(Get.context!)!.save,
                    ),
                  ],
                ).paddingSymmetric(
                  vertical: (IphoneHasNotch.hasNotch) ? 30.px : 20.px,
                ),
              );
            },
          ).paddingSymmetric(horizontal: 15.px),
        );
      },
      child: Container(
        padding: EdgeInsets.all(10.px),
        color: Colors.transparent,
        child: Image.asset(
          ImagePath.tools,
          height: 20.px,
          width: 20.px,
          color: AppColors().darkAndWhite,
        ),
      ),
    );
  }

  responseToneAPI() async {
    String uid = getStorageData.readString(getStorageData.userId) ?? "";
    String responseTone = "";

    for (var item in responseToneList) {
      if (item.isSelected) {
        if (utils.isValidationEmpty(responseTone)) {
          responseTone = removeEmojis(item.title).trim();
        } else {
          responseTone = "$responseTone,${removeEmojis(item.title).trim()}";
        }
      }
    }
    log("========================$responseTone");
    log("========================$responseTone");
    log("========================$responseTone");
    log("========================$responseTone");
    FormData formData = FormData.fromMap({
      "user_id": uid,
      "length":
          lengthList
              .where((user) => user.isSelected)
              .map((user) => user.title)
              .toList(),
      'response_tone': responseTone,
    });
    final data = await APIFunction().apiCall(
      apiName: Constants.changeLengthOrTone,
      params: formData,
      token: getStorageData.readString(getStorageData.token),
    );
    LoginModel model = LoginModel.fromJson(data);
    if (model.responseCode == 1) {
      Utils().showCustomToast(message: responseTone);

      getStorageData.saveObject(getStorageData.loginData, model.data);
      getStorageData.saveString(getStorageData.userId, model.data!.userId);
      getStorageData.saveString(getStorageData.token, model.data!.token);
      getStorageData.saveString(
        getStorageData.chatLimit,
        model.data!.chatLimit,
      );
      getStorageData.saveString(
        getStorageData.isSubscription,
        model.data!.isSubscription,
      );
      if (getStorageData.containKey(getStorageData.loginData)) {
        loginData = LoginData.fromJson(
          getStorageData.readObject(getStorageData.loginData),
        );
        userId = loginData!.userId!;
        // printAction("data User Id:++++++$userId");
      }
      Get.back();
      update();
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

  /* Future<void> getAssistantData({bool? isLoading}) async {
    try {
      // Loading.show();
      userId = getStorageData.readString(getStorageData.userId) ?? "";
      FormData formData = FormData.fromMap({
        "user_id": userId,
        // "is_test": kDebugMode,
      });
      final data = await APIFunction().apiCall(
        apiName: Constants.getAssistantData,
        params: formData,
        isLoading: isLoading ?? false,
        token: getStorageData.readString(getStorageData.token),
      );
      AssistantDataModel model = AssistantDataModel.fromJson(data);
      if (model.responseCode == 1) {
        if (!isAssistantAPICall) {
          isAssistantAPICall = true;
        }

        assistantsList = model.data ?? [];
        getStorageData.saveAssistantsList(value: assistantsList);
        Get.find<AssistantsPageController>().update();
        // Loading.dismiss();
      } else if (model.responseCode == 0) {
        errorDialog(model.responseMsg);
      } else if (model.responseCode == 26) {
        updateDialog(model.responseMsg);
      } else {
        utils.showToast(message: model.responseMsg!);
        // Loading.dismiss();
      }
    } catch (e) {
      // Loading.dismiss();
    }
  } */

  List<ToolsModel> selectAiModelList = [];
  List<ToolsModel> toolsListModel = [];

  String? firstTimeSubscription;
  String? isFirstTime;

  Timer? timer;

  RxString remainingTimeValue = " 00 : 00 : 00 ".obs;
  RxString refilledTimeValue = " 00 : 00 : 00 ".obs;

  formatDuration(Duration d) {
    final int hours = d.inHours;
    final int minutes = d.inMinutes % 60;
    final int seconds = d.inSeconds % 60;
    remainingTimeValue.value =
        " ${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')} ";
  }

  formatRefilledDuration(Duration d) {
    final int hours = d.inHours;
    final int minutes = d.inMinutes % 60;
    final int seconds = d.inSeconds % 60;
    refilledTimeValue.value =
        " ${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')} ";
  }

  bool? firstTimeGotoSubscriptionScreen = true;

  setUpModel({required String selectGptId}) async {
    for (var item in selectAiModelList) {
      printAction("item.model ${item.model}");
      if (item.modelId == selectGptId) {
        printAction(
          "123123ChatApi.selectModelIndexChatApi.selectModelIndexChatApi.selectModelIndex ${ChatApi.selectModelIndex}",
        );
        getStorageData.saveString(
          getStorageData.selectModelIndex,
          selectAiModelList.indexOf(item).toString(),
        );
        ChatApi.selectModelIndex = selectAiModelList.indexOf(item);
        printAction(
          "123123ChatApi.selectModelIndexChatApi${(getStorageData.containKey(getStorageData.selectModelIndex)) ? int.parse(getStorageData.readString(getStorageData.selectModelIndex) ?? "0") : 0}",
        );
        break;
      }

      if (Get.isRegistered<NewChatController>()) {
        Get.put(NewChatController()).update();
      }
    }
  }

  Future<void> valueSetUpUserProfile({
    required UserProfileData? userProfileData,
    required bool? goToPurchaseScreen,
    required bool apiCall,
  }) async {
    if (!utils.isValidationEmpty(userProfileData?.realTimeGeminiModel)) {
      ChatApi.geminiModel = userProfileData?.realTimeGeminiModel ?? "";
    }
    if (!utils.isValidationEmpty(userProfileData?.systemPromptGPT)) {
      ChatApi.toolsSystemPrompt = userProfileData!.systemPromptGPT!;
    }
    if (!utils.isValidationEmpty(userProfileData?.systemPromptGemini)) {
      ChatApi.geminiToolsSystemPrompt = userProfileData!.systemPromptGemini!;
    }
    if (!utils.isValidationEmpty(userProfileData?.gptTemperature)) {
      ChatApi.gptTemperature = userProfileData!.gptTemperature!;
    }
    if (!utils.isValidationEmpty(userProfileData?.tavilyApiKey)) {
      ChatApi.tavilyApiKey = userProfileData!.tavilyApiKey!;
    }
    if (!utils.isValidationEmpty(userProfileData?.followUpQuestionPrompt)) {
      SummarizeText.suggestionSystemPrompt =
          userProfileData!.followUpQuestionPrompt!;
    }
    if (!utils.isValidationEmpty(userProfileData?.realTimeGptModel)) {
      SummarizeText.gptModel = userProfileData!.realTimeGptModel!;
    }
    if (!utils.isValidationEmpty(userProfileData?.weatherKey)) {
      Constants.weatherKey = userProfileData!.weatherKey!;
    }
    if (!utils.isValidationEmpty(userProfileData?.isShowElevenLab)) {
      Constants.isShowElevenLab =
          userProfileData?.isShowElevenLab ?? Constants.isShowElevenLab;
    }
    if (!utils.isValidationEmpty(userProfileData?.elevenLabVoiceKey)) {
      Constants.elevenLabVoiceKey =
          userProfileData!.elevenLabVoiceKey ?? Constants.elevenLabVoiceKey;
    }
    if (!utils.isValidationEmpty(userProfileData?.voiceDtl?.elevenLabId)) {
      Constants.elevenLabId =
          userProfileData?.voiceDtl?.elevenLabId ?? Constants.elevenLabId;
    }
    if (!utils.isValidationEmpty(userProfileData?.youtubeApiKey)) {
      Constants.youtubeKey =
          userProfileData?.youtubeApiKey ?? Constants.youtubeKey;
    }
    if (!utils.isValidationEmpty(userProfileData?.gptApiKey)) {
      Constants.chatToken = userProfileData?.gptApiKey ?? Constants.chatToken;
    }
    if (!utils.isValidationEmpty(userProfileData?.geminiApiKey)) {
      Constants.geminiKey =
          userProfileData?.geminiApiKey ?? Constants.geminiKey;
    }
    if (!utils.isValidationEmpty(userProfileData?.geminiApiKey)) {
      Constants.magicStickPrompt =
          userProfileData?.magic_stick_prompt ?? Constants.magicStickPrompt;
    }
    selectAiModelList = userProfileData?.aiModels ?? [];
    Global.elevenLabInit();

    toolsListModel = userProfileData?.toolsList ?? [];
    if (userProfileData?.toolsList != null &&
        userProfileData!.toolsList!.isNotEmpty) {
      toolsListModel.add(
        ToolsModel(
          logo: (isLight) ? ImagePath.darkLogo : ImagePath.logo,
          name: Constants.comingSoon,
        ),
      );
    }
    Get.put(AssistantsPageController()).update();
    update();
    Get.put(ChatGptController()).update();
    update();
    Global.saveLoginData(data: userProfileData?.userDtl);
    setUpModel(selectGptId: userProfileData?.userDtl?.modelId.toString() ?? "");
    if (userProfileData?.userDtl != null) {
      loginData = LoginData.fromJson(
        getStorageData.readObject(getStorageData.loginData),
      );
    }
    if (userProfileData?.userDtl != null) {
      FirebaseCrashlytics.instance.setUserIdentifier(
        loginData!.userId.toString(),
      );
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      if ((goToPurchaseScreen ?? false) &&
          userProfileData?.userDtl?.isSubscription != null) {
        if (Global.isSubscription.value != "1" &&
            argumentsData == null &&
            firstTimeGotoSubscriptionScreen != null &&
            Global.offerType == null) {
          firstTimeGotoSubscriptionScreen = null;
          Get.put(ChatGptController()).goToPurchasePage();
        } else {
          Get.put(ChatGptController()).goToOfferPage();
        }
      }
    });
    firstTimeSubscription = userProfileData?.userDtl?.firstTimeSubscription;
    if (Global.isSubscription.value != "1" ||
        Get.put(ChatGptController()).purchaseList.isEmpty) {
      await Get.put(ChatGptController()).getPlanDetailAPI(isLoading: false);
    }
    if (Global.isSubscription.value != "1" &&
        apiCall &&
        (!isUserProfileAPICall)) {
      // isFirstTime = userProfileData.userDtl?.isFirstTime;
      isFirstTime = "1";

      timer ??= Timer.periodic(const Duration(seconds: 1), (tick) {
        formatDuration(
          Duration(seconds: (const Duration(minutes: 4).inSeconds - tick.tick)),
        );

        if (tick.tick >= const Duration(minutes: 4).inSeconds) {
          isFirstTime = null;

          timer?.cancel();
          timer = null;
          Get.put(ChatGptController()).update();
        }
      });
    }

    update();
  }

  Widget refilledView({required BuildContext context}) {
    return (Global.isSubscription.value != "1" && Global.chatLimit.value == 0)
        ? CommonContainer(
          radius: 0,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 5.px, horizontal: 15.px),
          color: AppColors.primary,
          child: Row(
            children: [
              Expanded(
                child: AppText(
                  Languages.of(context)!.yourCreditsRefilled,
                  color: AppColors.white,
                  fontSize: 14.px,
                  maxLines: 2,
                ),
              ),
              CommonContainer(
                color: AppColors.white,
                radius: 32.px,
                padding: EdgeInsets.all(8.px),
                child: Row(
                  children: [
                    SvgPicture.asset(ImagePath.watch),
                    SizedBox(width: 8.px),
                    AppText(
                      "00",
                      color: AppColors.black,
                      fontSize: 14.px,
                      fontFamily: FontFamily.helveticaBold,
                    ),
                    Container(
                      width: 2,
                      height: 15.px,
                      color: AppColors.greyLight4,
                    ).paddingSymmetric(horizontal: 8.px),
                    AppText(
                      "59",
                      color: AppColors.black,
                      fontSize: 14.px,
                      fontFamily: FontFamily.helveticaBold,
                    ),
                    Container(
                      width: 2,
                      height: 15.px,
                      color: AppColors.greyLight4,
                    ).paddingSymmetric(horizontal: 8.px),
                    AppText(
                      "56",
                      color: AppColors.black,
                      fontSize: 14.px,
                      fontFamily: FontFamily.helveticaBold,
                    ),
                    SizedBox(width: 6.px),
                  ],
                ),
              ),
            ],
          ),
        ).paddingOnly(bottom: 12.px)
        : const SizedBox();
  }

  Future<void> getUserProfileAPI({bool? isLoading}) async {
    // try {
    userId = getStorageData.readString(getStorageData.userId) ?? "";
    UserDataService()
        .getUserProfile(userId: userId)
        .handler(
          null,
          isLoading: isLoading ?? true,
          onSuccess: (value) async {
            if (value.responseCode == 1) {
              var goToPurchasesScreen =
                  !getStorageData.containKey(getStorageData.userProfileData);

              await getStorageData.saveUserProfileData(
                value.data ?? UserProfileData(),
              );

              await valueSetUpUserProfile(
                userProfileData: value.data,
                goToPurchaseScreen: goToPurchasesScreen,
                apiCall: true,
              );

              if (!isUserProfileAPICall) {
                isUserProfileAPICall = true;
              }
            } else if (value.responseCode == 0) {
              errorDialog(value.responseMsg);
            } else {
              utils.showToast(message: value.responseMsg!);
            }
          },
          onFailed: (value) {
            value.showToast();
          },
        );
    //   FormData formData = FormData.fromMap({"user_id": userId});
    //   final data = await APIFunction().apiCall(
    //     apiName: Constants.getUserProfile,
    //     params: formData,
    //     token: getStorageData.readString(getStorageData.token),
    //     isLoading: isLoading ?? true,
    //   );
    //   data.toString().log;
    //   UserProfileModel model = UserProfileModel.fromJson(data);

    //   if (model.responseCode == 1) {
    //     if (!getStorageData.containKey(getStorageData.userProfileData)) {
    //       getStorageData.saveUserProfileData(model.data ?? UserProfileData());

    //       await valueSetUpUserProfile(
    //         userProfileData: model.data,
    //         goToPurchaseScreen: true,
    //         apiCall: true,
    //       );
    //     } else {
    //       getStorageData.saveUserProfileData(model.data ?? UserProfileData());

    //       await valueSetUpUserProfile(
    //         userProfileData: model.data,
    //         goToPurchaseScreen: false,
    //         apiCall: true,
    //       );
    //     }
    //     if (!isUserProfileAPICall) {
    //       isUserProfileAPICall = true;
    //     }
    //   } else if (model.responseCode == 0) {
    //     errorDialog(model.responseMsg);
    //   } else if (model.responseCode == 26) {
    //     updateDialog(model.responseMsg);
    //   } else {
    //     utils.showToast(message: model.responseMsg!);
    //     Loading.dismiss();
    //   }
    // } finally {
    //   Loading.dismiss();
    // }
  }

  void tabBarSetUp() {
    tabController ??= TabController(
      vsync: this,
      initialIndex: 0,
      length: promptTitleList.length,
    );
  }

  Future<void> getAllPromptAPI({bool? isLoading}) async {
    userId = getStorageData.readString(getStorageData.userId) ?? "";
    FormData formData = FormData.fromMap({"user_id": userId});
    final data = await APIFunction().apiCall(
      apiName: Constants.getAllPrompt,
      params: formData,
      isLoading: isLoading ?? false,
    );
    AllPromptModel model = AllPromptModel.fromJson(data);
    Get.find<HomeController>().easyRefreshController.finishRefresh();

    if (model.responseCode == 1) {
      if (!isTemplateAPICall) {
        isTemplateAPICall = true;
      }
      promptTitleList.value = [];

      promptTitleList.addAll(model.data!);
      getStorageData.saveAllPromptData(value: promptTitleList);
      tabBarSetUp();
      Get.find<HomeController>().update();
      update();
    } else if (model.responseCode == 0) {
      errorDialog(model.responseMsg);
    } else if (model.responseCode == 26) {
      updateDialog(model.responseMsg);
    } else {
      utils.showToast(message: model.responseMsg!);
    }
  }

  updateProfile({
    required String? image,
    required String userName,
    required String? filePath,
  }) async {
    FormData formData = FormData.fromMap({
      if (filePath == null) 'profile': image,
      'name': userName,
      'user_id': getStorageData.readString(getStorageData.userId),
    });

    if (filePath != null) {
      formData.files.add(
        MapEntry(
          HttpUtil.profileImg,
          MultipartFile.fromFileSync(
            filePath,
            filename: filePath.split("/").last,
          ),
        ),
      );
    }
    final data = await APIFunction().apiCall(
      params: formData,
      apiName: Constants.updateProfile,
      token: getStorageData.readString(getStorageData.token),
    );
    LoginModel model = LoginModel.fromJson(data);
    if (model.responseCode == 1) {
      Global.saveLoginData(data: model.data);
      Get.put(SettingsController()).update();
      Get.put(ChatGptController()).update();

      Get.back(result: {});
      utils.showToast(message: model.responseMsg!);
    } else if (model.responseCode == 0) {
      utils.showToast(message: model.responseMsg!);
    }
  }

  bool isTemplateAPICall = false;
  bool isUserProfileAPICall = false;
  bool isAssistantAPICall = false;

  backToTemplateOrAssistants({required RxInt apiCall}) async {
    if (apiCall.value == 1) {
      printAction(
        "apiCall.valueapiCall.valueapiCall.valueapiCall.value ${apiCall.value}",
      );
      apiCall.value = 0;
      await Future.delayed(const Duration(milliseconds: 100), () {});
      for (var element in bottomBarItem) {
        element.isCheck?.value = false;
      }
      selectedIndex.value = 2;

      bottomBarItem[2].isCheck?.value = true;
      if (!Get.find<AssistantsPageController>().apiState.isSuccess) {
        Get.find<AssistantsPageController>().getAssistantData(refresh: true);
      }
    } else if (apiCall.value == 2) {
      printAction(
        "apiCall.valueapiCall.valueapiCall.valueapiCall.value ${apiCall.value}",
      );

      apiCall.value = 0;
      await Future.delayed(const Duration(milliseconds: 100), () {
        selectedIndex.value = 0;
        for (var element in bottomBarItem) {
          element.isCheck?.value = false;
        }
        bottomBarItem[0].isCheck?.value = true;
        if (!isTemplateAPICall) {
          getAllPromptAPI();
        }
      });
    }
  }

  Widget commonRedeemView({required BuildContext context}) {
    return (Global.isSubscription.value != "1")
        ? GestureDetector(
          onTap: () async {
            if (Get.put(ChatGptController()).purchaseList.isEmpty) {
              await Get.put(
                ChatGptController(),
              ).getPlanDetailAPI(isLoading: true);
            }
            Get.put(ChatGptController()).goToPurchasePage(
              arguments: {
                "plan_id":
                    Get.put(ChatGptController()).purchaseList
                        .firstWhereOrNull((element) => element.name == 'weekly')
                        ?.productId ??
                    "",
              },
            );
          },
          child: CommonContainer(
            padding: EdgeInsets.symmetric(vertical: 16.px, horizontal: 26.px),
            isBorder: true,
            child: Column(
              children: [
                AppRichText(
                  firstText: Languages.of(context)!.unlockAccessTo,
                  firstFontSize: 14.px,
                  firstTextColor: AppColors().darkAndWhite,
                  firstTextFontFamily: FontFamily.helveticaBold,
                  secondText: Languages.of(context)!.pro,
                  secondFontSize: 14.px,
                  secondTextFontFamily: FontFamily.helveticaBold,
                  thirdText: Languages.of(context)!.forUnlimitedCredits,
                  thirdFontSize: 14.px,
                  thirdTextColor: AppColors().darkAndWhite,
                  thirdTextFontFamily: FontFamily.helveticaBold,
                  secondTextColor: AppColors.primary,
                ).paddingOnly(bottom: 16.px),
                CommonButton(
                  onTap: () async {
                    if (Get.put(ChatGptController()).purchaseList.isEmpty) {
                      await Get.put(
                        ChatGptController(),
                      ).getPlanDetailAPI(isLoading: true);
                    }
                    Get.put(ChatGptController()).goToPurchasePage(
                      arguments: {
                        "plan_id":
                            Get.put(ChatGptController()).purchaseList
                                .firstWhereOrNull(
                                  (element) => element.name == 'weekly',
                                )
                                ?.productId ??
                            "",
                      },
                    );
                  },
                  title: Languages.of(context)!.redeemYourFreeTrial,
                ).paddingOnly(bottom: 12.px),
                AppText(
                  Languages.of(context)!.dayFreeTrialWeekCancelAnytime(
                    price:
                        Get.put(ChatGptController()).purchaseList
                            .firstWhereOrNull(
                              (element) => element.name == 'weekly',
                            )
                            ?.price ??
                        "",
                  ),
                  fontSize: 14.px,
                  color: AppColors().darkAndWhite.changeOpacity(0.5),
                ),
              ],
            ),
          ).paddingOnly(bottom: 20.px),
        )
        : const SizedBox();
  }

  Widget commonTrialView() {
    return CommonContainer(
      color: AppColors.primary,
      padding: EdgeInsets.all(12.px),
      radius: 10.px,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6.px),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              Global.isSubscription.value == "1"
                  ? ImagePath.diamond
                  : ImagePath.star,
              height: 20.px,
            ),
          ),
          SizedBox(width: 12.px),
          Expanded(
            child: Row(
              children: [
                AppText(
                  Global.isSubscription.value == "1"
                      ? Languages.of(Get.context!)!.pro
                      : Languages.of(Get.context!)!.free,
                  fontSize: 16.px,
                  color: AppColors.white,
                  fontFamily: FontFamily.helveticaBold,
                ),
                SizedBox(width: 20.px),
                if (Global.isSubscription.value != "1")
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 2,
                          height: 18.px,
                          color: AppColors.white,
                        ),
                        SizedBox(width: 12.px),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: AppText(
                                      Languages.of(Get.context!)!.todayCredits,
                                      fontSize: 12.px,
                                      color: AppColors.white,
                                    ),
                                  ),
                                  AppText(
                                    Global.chatLimit.value.toString(),
                                    fontSize: 12.px,
                                    color: AppColors.white,
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.px),
                              Row(
                                children: List.generate(
                                  4,
                                  (index) => Expanded(
                                    child: CommonContainer(
                                      height: 8,
                                      color:
                                          (index >= Global.chatLimit.value)
                                              ? AppColors.white.changeOpacity(
                                                0.5,
                                              )
                                              : AppColors.white,
                                    ).paddingOnly(right: 15.px),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    timer?.cancel();

    super.onClose();
  }
}

Future<File?> imagePickerBottomSheet({required bool isSub}) async {
  printAction("isSubisSubisSubisSubisSubisSub $isSub");
  printAction(
    "isSubisSubisSubisSubisSubisSub ${Global.isSubscription.value != "1"}",
  );

  if (Global.isSubscription.value != "1" && isSub) {
    printAction("adsljkfgnlgkdndgslefgmnln");
    Get.put(ChatGptController()).goToPurchasePage();
    // Get.put(ChatGptController()).creditBottomSheet();
    return null;
  }
  File? image;
  await showModalBottomSheet(
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    context: Get.context!,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            // padding: MediaQuery.of(context).viewInsets,
            padding: EdgeInsets.all(16.px),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors().whiteAndDark,
                      borderRadius: BorderRadius.all(Radius.circular(20.px)),
                    ),
                    child: Column(
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () async {
                            HapticFeedback.mediumImpact();
                            if (await PermissionHandle().cameraPermission()) {
                              if (await PermissionHandle().micPermission()) {
                                Get.toNamed(Routes.CAMERA_CUSTOM)?.then((
                                  value,
                                ) {
                                  debugPrint(
                                    "*file.path bottom  ************** CAMERA_CUSTOM$value",
                                  );
                                  if (value != null) {
                                    image = File(value);
                                  }
                                  Get.back();
                                });
                              }
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(16.px),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  ImagePath.icCamera,
                                  height: 24.px,
                                  width: 24.px,
                                  color: AppColors().darkAndWhite,
                                ).marginOnly(right: 12.px),
                                AppText(
                                  height: 0.8,
                                  Languages.of(context)!.useCamera,
                                  fontSize: 14.px,

                                  /// TODO: Font change top margin change
                                ).marginOnly(top: 5),
                              ],
                            ),
                          ),
                        ),
                        Divider(
                          height: 1.px,
                          thickness: 0.5.px,
                          color: AppColors().darkAndWhite.changeOpacity(0.4),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.px),
                          child: GestureDetector(
                            onTap: () async {
                              HapticFeedback.mediumImpact();
                              final ImagePicker picker = ImagePicker();
                              final XFile? image2 = await picker.pickImage(
                                source: ImageSource.gallery,
                              );
                              if (image2 != null) {
                                if ((!await Utils().isImageCorrupted(
                                  image2.path,
                                ))) {
                                  image = await cropImageProcess(
                                    imagePath: image2.path,
                                  );
                                  Get.back();
                                } else {
                                  Utils().showToast(
                                    message:
                                        "The selected image is corrupted. Please choose a different one.",
                                  );
                                }
                              } else {}
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  ImagePath.icGallery,
                                  height: 24.px,
                                  width: 24.px,
                                  color: AppColors().darkAndWhite,
                                ).marginOnly(right: 12.px),
                                AppText(
                                  Languages.of(context)!.uploadImage,
                                  fontSize: 14.px,
                                ).marginOnly(top: 5),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.px),
                  CommonButton(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    title: Languages.of(Get.context!)!.cancel,
                    textColor: AppColors.white,
                  ),

                  // Center(
                  //   child: AppText(text ?? "", fontSize: 25.px, fontWeight: FontWeight.w600),
                  // ),
                  // SizedBox(height: 39.px),
                ],
              ),
            ),
          );
        },
      );
    },
  );
  return image;
}

Future<File?> cropImageProcess({
  required String imagePath,
  CropAspectRatio? aspectRatio,
}) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: imagePath,
    aspectRatio: aspectRatio /*  CropAspectRatio(ratioX: 1, ratioY: 1) */,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: AppColors().conColor,
        toolbarWidgetColor: AppColors().darkAndWhite,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(title: 'Cropper'),
      WebUiSettings(context: Get.context!),
    ],
  );
  if (croppedFile != null) {
    return File(croppedFile.path);
  } else {
    return File(imagePath);
  }
}

Future<String> imageToText({required File file}) async {
  final textRecognizer = TextRecognizer();

  final inputImage = InputImage.fromFile(file);
  printAction("file path is ${file.path}");

  final recognizedText = await textRecognizer.processImage(inputImage);
  return recognizedText.text;
}

class ImagePickerSheet extends StatelessWidget {
  const ImagePickerSheet({super.key, this.onCamera, this.onGallery});

  final VoidCallback? onCamera;

  final VoidCallback? onGallery;

  static Future<File?> cropFunction(
    File image, {
    CropAspectRatio? aspectRatio,
  }) async {
    if ((!await Utils().isImageCorrupted(image.path))) {
      return cropImageProcess(imagePath: image.path, aspectRatio: aspectRatio);
    } else {
      Utils().showToast(
        message:
            "The selected image is corrupted. Please choose a different one.",
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: MediaQuery.paddingOf(
        context,
      ).min(bottom: 16, right: 16, left: 16, top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors().whiteAndDark,
              borderRadius: BorderRadius.all(Radius.circular(20.px)),
            ),
            child: Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap:
                      onCamera ??
                      () async {
                        HapticFeedback.mediumImpact();
                        if (await PermissionHandle().cameraPermission()) {
                          if (await PermissionHandle().micPermission()) {
                            Get.toNamed(Routes.CAMERA_CUSTOM)?.then((value) {
                              debugPrint(
                                "*file.path bottom  ************** CAMERA_CUSTOM$value",
                              );
                              Get.back(
                                result: value == null ? null : File(value),
                              );
                            });
                          }
                        }
                      },
                  child: AbsorbPointer(
                    child: Padding(
                      padding: EdgeInsets.all(16.px),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            ImagePath.icCamera,
                            height: 24.px,
                            width: 24.px,
                            color: AppColors().darkAndWhite,
                          ).marginOnly(right: 12.px),
                          AppText(
                            height: 0.8,
                            Languages.of(context)!.useCamera,
                            fontSize: 14.px,

                            /// TODO: Font change top margin change
                          ).marginOnly(top: 5),
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 1.px,
                  thickness: 0.5.px,
                  color: AppColors().darkAndWhite.changeOpacity(0.4),
                ),
                Padding(
                  padding: EdgeInsets.all(16.px),
                  child: GestureDetector(
                    onTap:
                        onGallery ??
                        () async {
                          HapticFeedback.mediumImpact();
                          final ImagePicker picker = ImagePicker();
                          final XFile? image2 = await picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (image2 != null) {
                            if ((!await Utils().isImageCorrupted(
                              image2.path,
                            ))) {
                              final image = await cropImageProcess(
                                imagePath: image2.path,
                              );
                              Get.back(result: image);
                            } else {
                              Utils().showToast(
                                message:
                                    "The selected image is corrupted. Please choose a different one.",
                              );
                            }
                          } else {}
                        },
                    child: AbsorbPointer(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            ImagePath.icGallery,
                            height: 24.px,
                            width: 24.px,
                            color: AppColors().darkAndWhite,
                          ).marginOnly(right: 12.px),
                          AppText(
                            Languages.of(context)!.uploadImage,
                            fontSize: 14.px,
                          ).marginOnly(top: 5),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.px),
          AppButton(
            onPressed: Get.back,
            child: Text(Languages.of(Get.context!)!.cancel),
          ),
        ],
      ),
    );
  }
}
