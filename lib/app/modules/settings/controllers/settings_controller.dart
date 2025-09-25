import 'package:chatsy/app/common_widget/common_button.dart';
import 'package:chatsy/app/helper/image_path.dart';
import 'package:chatsy/app/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:chatsy/app/modules/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:chatsy/app/modules/splash/controllers/login_model.dart';
import 'package:chatsy/extension.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../Localization/local_language.dart';
import '../../../api_repository/api_function.dart';
import '../../../common_widget/common_container.dart';
import '../../../common_widget/error_and_update_dialog.dart';
import '../../../helper/Global.dart';
import '../../../helper/all_imports.dart';
import '../../chat_gpt/controllers/chat_gpt_controller.dart';
import '../../chat_gpt/views/chat_gpt_view.dart';
import '../../home/controllers/user_profile_model.dart';
import '../../purchase/controllers/purchase_controller.dart';
import '../models/ask_something_model.dart';

class SettingsController extends GetxController with GetSingleTickerProviderStateMixin {
  String uid = "";
  String userIdentification = "";
  String chatGptModel = "";
  RxInt index = 0.obs;

  RxBool isFollowUpValues = false.obs;

  List<SubscriptionCarousel> themeList = [
    SubscriptionCarousel(
      title: Languages.of(Get.context!)!.lightMode,
      description: ImagePath.brightness2,
    ),
    SubscriptionCarousel(title: Languages.of(Get.context!)!.darkMode, description: ImagePath.dark),
  ];

  AnimationController? animationController;

  String insertFirstFiveAfter(String fullName, String subString) {
    if (fullName.isEmpty) {
      return "";
    }

    // Check if the length is less than 5 characters
    if (fullName.length < 5) {
      return "$fullName${subString}a";
    }
    String firstFive = fullName.substring(0, 5);
    String remaining = fullName.substring(5);

    return "$firstFive${subString}a$remaining";
  }

  LoginData loginData = LoginData();

  @override
  Future<void> onInit() async {
    animationController = AnimationController(vsync: this);
    isFollowUpValues =
        getStorageData.readString(getStorageData.suggestionView) != "0" ? true.obs : false.obs;
    index.value = isLight ? 0 : 1;
    uid = getStorageData.readString(getStorageData.userId) ?? "";
    loginData = LoginData.fromJson(getStorageData.readObject(getStorageData.loginData));

    // deviceId = await getStorageData.readString(getStorageData.deviceId) ?? "";

    debugPrint("-=-=-=-uid: $uid");
    userIdentification = insertFirstFiveAfter(
      (!utils.isValidationEmpty(loginData.deviceId.toString()))
          ? loginData.deviceId.toString()
          : getStorageData.readString(getStorageData.deviceId) ?? "",
      uid,
    );

    update();
    super.onInit();
  }

  bool isFollowUs = false;
  bool isLegal = false;
}

editChatGptModelAPI({required String modelId, required String title}) async {
  String uid = getStorageData.readString(getStorageData.userId) ?? "";
  String token = getStorageData.readString(getStorageData.token) ?? "";
  FormData formData = FormData.fromMap({"user_id": uid, "model_id": modelId});

  final data = await APIFunction().apiCall(
    apiName: Constants.editChatGptModel,
    params: formData,
    token: token,
    isLoading: false,
  );
  AskQuestionModel model = AskQuestionModel.fromJson(data);
  if (model.responseCode == 1) {
    // utils.showToast( message: model.responseMsg!, );
    //  utils.showToast(message: model.responseMsg!);

    // Global.selectModelName.value = title;

    // for (var item in Get.put(BottomNavigationController()).selectAiModelList) {
    //   if (item.modelId == modelId) {
    //     getStorageData.saveString(getStorageData.selectModelIndex, Get.put(BottomNavigationController()).selectAiModelList.indexOf(item).toString());
    //     ChatApi.selectModelIndex = Get.put(BottomNavigationController()).selectAiModelList.indexOf(item);
    //     printAction("123123ChatApi.selectModelIndexChatApi.selectModelIndexChatApi.selectModelIndex ${ChatApi.selectModelIndex}");
    //     printAction("123123ChatApi.selectModelIndexChatApi${(getStorageData.containKey(getStorageData.selectModelIndex)) ? int.parse(getStorageData.readString(getStorageData.selectModelIndex)) : 0}");
    //     break;
    //   }
    //
    //   if (Get.isRegistered<NewChatController>()) {
    //     Get.put(NewChatController()).update();
    //   }
    // }

    // Get.back();
  } else if (model.responseCode == 0) {
    utils.showToast(message: model.responseMsg!);
    Get.back();
  } else if (model.responseCode == 26) {
    updateDialog(model.responseMsg);
  } else if (model.responseCode == 5) {
    utils.showToast(message: model.responseMsg!);
    Get.put(ChatGptController()).goToPurchasePage();
  } else {
    utils.showToast(message: model.responseMsg!);
  }
}

int selectModelIndex =
    (getStorageData.containKey(getStorageData.selectModelIndex))
        ? int.parse(getStorageData.readString(getStorageData.selectModelIndex) ?? "0")
        : 0;

Future<void> selectAIModel() async {
  int selectModelIndex =
      (getStorageData.containKey(getStorageData.selectModelIndex))
          ? int.parse(getStorageData.readString(getStorageData.selectModelIndex) ?? "0")
          : 0;
  await showDialog(
    context: Get.context!,
    builder: (context) {
      return AlertDialog(
        actionsPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        buttonPadding: EdgeInsets.zero,
        iconPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        alignment: const Alignment(0, -0.76),
        backgroundColor: Colors.transparent,
        content: StatefulBuilder(
          builder: (context, setState) {
            return Stack(
              alignment: const Alignment(0, -1.2),
              children: [
                Image.asset(
                  ImagePath.vector,
                  color: AppColors().whiteAndDark,
                  height: 30.px,
                  width: 30.px,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.px),
                  decoration: BoxDecoration(
                    color: AppColors().whiteAndDark,
                    borderRadius: BorderRadius.circular(10.px),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // SizedBox(height: 10.px),
                      // AppText(Languages.of(context)!.selectAIModel, fontSize: 24.px),
                      SizedBox(height: 10.px),
                      ...List.generate(
                        Get.put(BottomNavigationController()).selectAiModelList.length,
                        (index) {
                          ToolsModel data =
                              Get.put(BottomNavigationController()).selectAiModelList[index];

                          return GestureDetector(
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              setState(() {
                                selectModelIndex = index;
                                editChatGptModelAPI(
                                  modelId:
                                      Get.put(
                                        BottomNavigationController(),
                                      ).selectAiModelList[selectModelIndex].modelId ??
                                      "",
                                  title:
                                      Get.put(
                                        BottomNavigationController(),
                                      ).selectAiModelList[selectModelIndex].modelId ??
                                      "",
                                );
                              });
                            },
                            child: Column(
                              children: [
                                SizedBox(height: 10.px),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipOval(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            data.logo ??
                                            "${Constants.imageBaseUrl}ai_model/chat_gpt.png",
                                        width: 25.px,
                                        height: 25.px,
                                        progressIndicatorBuilder:
                                            (context, url, progress) =>
                                                progressIndicatorView(borderRadius: 10.px),
                                        errorWidget:
                                            (context, url, uri) =>
                                                errorWidgetView().paddingAll(8.px),
                                      ),
                                    ),
                                    SizedBox(width: 15.px),
                                    Expanded(child: AppText(data.name ?? "", fontSize: 16.px)),
                                    if (data.isPremium == "1")
                                      if (Global.isSubscription.value != "1")
                                        CommonContainer(
                                          color: const Color(0xFF3BDBD4),
                                          child: Padding(
                                            /// TODO: Font change padding change
                                            padding: EdgeInsets.fromLTRB(10.px, 5.px, 10.px, 3.px),
                                            child: AppText(
                                              Languages.of(context)!.pro,
                                              fontSize: 13.px,
                                              color: AppColors().whiteAndDark,
                                            ),
                                          ),
                                        ),
                                    SizedBox(width: 10.px),
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color:
                                              (index == selectModelIndex)
                                                  ? AppColors.primary
                                                  : AppColors().darkAndWhite.changeOpacity(0.4),
                                        ),
                                      ),
                                      child: Container(
                                        height: 18.px,
                                        width: 18.px,
                                        padding: EdgeInsets.all(4.px),
                                        decoration: BoxDecoration(
                                          color:
                                              (index == selectModelIndex)
                                                  ? AppColors.primary
                                                  : AppColors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child:
                                            (index == selectModelIndex)
                                                ? Image.asset(ImagePath.trues, height: 5.px)
                                                : const SizedBox(),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.px),
                                if (!(index ==
                                        (Get.put(
                                              BottomNavigationController(),
                                            ).selectAiModelList.length -
                                            1) &&
                                    Global.isSubscription.value == "1"))
                                  Container(
                                    height: 2,
                                    color: AppColors().darkAndWhite.changeOpacity(0.04),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10.px),
                      if (Global.isSubscription.value != "1")
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 5.px),
                            LimitAndHistoryButtonView(),
                            SizedBox(width: 3.px),
                            Expanded(
                              child: AppText(
                                "${Global.chatLimit} ${Languages.of(context)!.creditsLeftToday}",
                                fontSize: 16.px,
                              ),
                            ),
                          ],
                        ),
                      if (Global.isSubscription.value != "1") SizedBox(height: 10.px),
                      if (Global.isSubscription.value != "1")
                        CommonButton(
                          onTap: () {
                            Get.back();
                            Get.put(ChatGptController()).creditBottomSheet();
                          },
                          title: Languages.of(context)!.upgradeToPRO,
                          verticalPadding: 10.px,
                        ).paddingSymmetric(horizontal: 5.w),
                      /*ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 10.px),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: Get.put(BottomNavigationController()).selectAiModelList.length,
                        separatorBuilder: (context, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 10.px),
                              Container(height: 1, color: AppColors().darkAndWhite.changeOpacity(0.04)),
                              SizedBox(height: 10.px),
                            ],
                          );
                        },
                        itemBuilder: (context, index) {
                          ToolsModel data = Get.put(BottomNavigationController()).selectAiModelList[index];
                          return GestureDetector(
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              setState(() {
                                selectModelIndex = index;
                                editChatGptModelAPI(modelName: Get.put(BottomNavigationController()).selectAiModelList[selectModelIndex].model ?? "", title: Get.put(BottomNavigationController()).selectAiModelList[selectModelIndex].name ?? "");
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.px),
                                  child: CachedNetworkImage(
                                    imageUrl: data.logo ?? "${Constants.imageBaseUrl}ai_model/chat_gpt.png",
                                    width: 30.px,
                                    height: 30.px,
                                    progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(borderRadius: 10.px),
                                    errorWidget: (context, url, uri) => errorWidgetView().paddingAll(8.px),
                                  ),
                                ),
                                SizedBox(width: 15.px),
                                Expanded(
                                  child: AppText(
                                    data.name ?? "",
                                    fontSize: 18.px,
                                  ),
                                ),
                                if (data.isPremium == "1")
                                  if (Global.isSubscription.value != "1")
                                    CommonContainer(
                                      color: const Color(0xFF3BDBD4),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 5.px),
                                        child: AppText(
                                          Languages.of(context)!.pro,
                                          fontSize: 13.px,
                                          color: AppColors().whiteAndDark,
                                        ),
                                      ),
                                    ),
                                SizedBox(width: 10.px),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: (index == selectModelIndex) ? AppColors.primary : AppColors().darkAndWhite.changeOpacity(0.4)),
                                  ),
                                  child: Container(
                                    height: 18.px,
                                    width: 18.px,
                                    padding: EdgeInsets.all(4.px),
                                    decoration: BoxDecoration(color: (index == selectModelIndex) ? AppColors.primary : AppColors.white, shape: BoxShape.circle),
                                    child: (index == selectModelIndex)
                                        ? Image.asset(
                                            ImagePath.trues,
                                            height: 5.px,
                                          )
                                        : const SizedBox(),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),*/
                      if (Global.isSubscription.value != "1") SizedBox(height: 15.px),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );
    },
  );
}

/*Future<void> selectAIModel() async {
  int selectModelIndex = (getStorageData.containKey(getStorageData.selectModelIndex)) ? int.parse(getStorageData.readString(getStorageData.selectModelIndex)) : 0;
  await CommonShowModelBottomSheet(
    // isScrollControlled: true,
    // backgroundColor: Colors.transparent,
    // context: Get.context!,

    child: StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.px),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10.px),
              AppText(
                Languages.of(context)!.selectAIModel,
                fontSize: 24.px,
              ),
              SizedBox(height: 20.px),
              ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 10.px),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: Get.put(BottomNavigationController()).selectAiModelList.length,
                separatorBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(height: 10.px),
                      Container(height: 1, color: AppColors().darkAndWhite.changeOpacity(0.04)),
                      SizedBox(height: 10.px),
                    ],
                  );
                },
                itemBuilder: (context, index) {
                  ToolsModel data = Get.put(BottomNavigationController()).selectAiModelList[index];
                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      setState(() {
                        selectModelIndex = index;
                        editChatGptModelAPI(modelName: Get.put(BottomNavigationController()).selectAiModelList[selectModelIndex].model ?? "", title: Get.put(BottomNavigationController()).selectAiModelList[selectModelIndex].name ?? "");
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10.px),
                          child: CachedNetworkImage(
                            imageUrl: data.logo ?? "${Constants.imageBaseUrl}ai_model/chat_gpt.png",
                            width: 30.px,
                            height: 30.px,
                            progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(borderRadius: 10.px),
                            errorWidget: (context, url, uri) => errorWidgetView().paddingAll(8.px),
                          ),
                        ),
                        SizedBox(width: 15.px),
                        Expanded(
                          child: AppText(
                            data.name ?? "",
                            fontSize: 18.px,
                          ),
                        ),
                        if (data.isPremium == "1")
                          if (Global.isSubscription.value != "1")
                            CommonContainer(
                              color: const Color(0xFF3BDBD4),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 5.px),
                                child: AppText(
                                  Languages.of(context)!.pro,
                                  fontSize: 13.px,
                                  color: AppColors().whiteAndDark,
                                ),
                              ),
                            ),
                        SizedBox(width: 10.px),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: (index == selectModelIndex) ? AppColors.primary : AppColors().darkAndWhite.changeOpacity(0.4)),
                          ),
                          child: Container(
                            height: 18.px,
                            width: 18.px,
                            padding: EdgeInsets.all(4.px),
                            decoration: BoxDecoration(color: (index == selectModelIndex) ? AppColors.primary : AppColors.white, shape: BoxShape.circle),
                            child: (index == selectModelIndex)
                                ? Image.asset(
                                    ImagePath.trues,
                                    height: 5.px,
                                  )
                                : const SizedBox(),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 10.px),
            ],
          ),
        );
      },
    ),
  );
}*/
