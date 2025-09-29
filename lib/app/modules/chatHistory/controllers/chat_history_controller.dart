import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatsy/app/modules/imageGeneration/controllers/image_generation_controller.dart';
import 'package:chatsy/app/modules/imageScan/controllers/image_scan_controller.dart';
import 'package:chatsy/app/modules/imageScan/views/image_scan_view.dart';
import 'package:chatsy/app/modules/summarizeDocument/controllers/summarize_document_controller.dart';
import 'package:chatsy/app/modules/summarizeWebsite/controllers/summarize_website_controller.dart';
import 'package:chatsy/app/modules/translate/controllers/translate_controller.dart';
import 'package:chatsy/app/modules/youtubeSummary/controllers/youtube_summary_controller.dart';
import 'package:chatsy/extension.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Localization/local_language.dart';
import '../../../api_repository/api_function.dart';
import '../../../common_widget/common_button.dart';
import '../../../common_widget/common_container.dart';
import '../../../common_widget/common_show_model_bottom_sheet.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/font_family.dart';
import '../../../helper/get_storage_data.dart';
import '../../../helper/image_path.dart';
import '../../../routes/app_pages.dart';
import '../../chat_gpt/views/chat_gpt_view.dart';
import '../../newChat/controllers/new_chat_controller.dart';
import '../../newChat/models/phm_id_model.dart';
import '../../promptChat/controllers/prompt_chat_controller.dart';
import '../models/favourite_chat_model.dart';
import '../models/get_all_chat_history_model.dart';
import '../models/get_single_chat_history_model.dart';

class ChatHistoryController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // RefreshController refreshController = RefreshController(initialRefresh: false);
  // RefreshController refreshController2 = RefreshController(initialRefresh: false);
  final easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
  );
  final easyRefreshController2 = EasyRefreshController(
    controlFinishRefresh: true,
  );

  RxBool isAPICall = false.obs;
  int page = 1;
  ScrollController scrollController = ScrollController();
  int limit = 30;
  var totalItem = 0.obs;
  RxBool isLoading = false.obs;

  RxBool isAPICall2 = false.obs;
  int page2 = 1;
  ScrollController scrollController2 = ScrollController();
  int limit2 = 30;
  var totalItem2 = 0.obs;
  RxBool isLoading2 = false.obs;

  TabController? tabController;

  List historyTypeList = [
    Languages.of(Get.context!)!.allHistory,
    Languages.of(Get.context!)!.favorites,
  ];

  RxList<ChatHistory> allHistoryList = <ChatHistory>[].obs;
  RxList<ChatHistory> allHistoryList2 = <ChatHistory>[].obs;

  RxBool isDeleteButtonShow = true.obs;

  commonHistoryView({
    required String image,
    required String title,
    required String type,
    required String isFavorite,
    required String subTitle,
    bool? isDeleteButton,
    required String time,
    required Function()? onTap,
    required Function()? favoriteOnTap,
    required Function()? deleteOnTap,
  }) {
    return Slidable(
      key: UniqueKey(),
      endActionPane: ActionPane(
        extentRatio: 0.15,
        motion: const ScrollMotion(),
        children:
            (isDeleteButton ?? true)
                ? [
                  GestureDetector(
                    onTap: deleteOnTap,
                    child: Container(
                      padding: EdgeInsets.all(12.px),
                      decoration: BoxDecoration(
                        color: AppColors().lightWithe,
                        borderRadius: BorderRadius.circular(10.px),
                      ),
                      child: Image.asset(
                        ImagePath.delete,
                        height: 17.px,
                        color: AppColors().darkAndWhite,
                      ),
                    ),
                  ),
                ]
                : [],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: CommonContainer(
          padding: EdgeInsets.symmetric(horizontal: 16.px),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: image,
                  progressIndicatorBuilder:
                      (context, url, progress) =>
                          progressIndicatorView(circle: true),
                  errorWidget:
                      (context, url, uri) =>
                          errorWidgetView(height: 32.px, wight: 32.px),
                  height: 40.px,
                  width: 40.px,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12.px),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!Utils().isValidationEmpty(title))
                      AppText(
                        title,
                        fontFamily: FontFamily.helveticaBold,
                        fontSize: 14.px,
                        maxLines: 1,
                      ),
                    if (!Utils().isValidationEmpty(subTitle))
                      AppText(
                        subTitle,
                        fontFamily: FontFamily.helveticaRegular,
                        fontSize: 12.px,
                        maxLines: 1,
                        color: AppColors().darkAndWhite.changeOpacity(0.5),
                      ),
                  ],
                ),
              ),
              SizedBox(width: 12.px),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppText(
                    utils.getDateLabel(time, "hh:mm aa"),
                    fontFamily: FontFamily.helveticaRegular,
                    fontSize: 12.px,
                    color: AppColors().darkAndWhite.changeOpacity(0.5),
                  ),
                  GestureDetector(
                    onTap: favoriteOnTap,
                    child: Icon(
                      isFavorite == "1" ? Icons.star : Icons.star_border,
                      color:
                          isFavorite == "1"
                              ? AppColors.primary
                              : AppColors().darkAndWhite.changeOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isCall = false;

  getAllChatHistoryAPI({required String type}) async {
    if (!isCall) {
      isCall = true;
    } else {
      return;
    }
    if (type != "all_history") {
      processing = true;
    }
    try {
      String userId = getStorageData.readString(getStorageData.userId) ?? "0";
      FormData formData = FormData.fromMap({
        "user_id": userId,
        "type": type,
        "page": type == "all_history" ? page : page2,
        "limit": type == "all_history" ? limit : limit2,
      });

      type == "all_history"
          ? isLoading.value = false
          : isLoading2.value = false;

      final data = await APIFunction().apiCall(
        apiName: Constants.getAllChatHistory,
        params: formData,
        token: getStorageData.readString(getStorageData.token),
        isLoading: false,
      );
      isCall = false;
      GetAllChatHistoryModel model = GetAllChatHistoryModel.fromJson(data);

      if (model.responseCode == 1) {
        if (page == 1 && type == "all_history") {
          allHistoryList.clear();

          allHistoryList.refresh();
        } else if (page2 == 1 && type == "favourite") {
          allHistoryList2.clear();
          allHistoryList2.refresh();
        }
        if (type == "all_history") {
          if (!isAPICall.value) {
            isAPICall.value = true;
          }
          allHistoryList.addAll(model.data ?? []);

          page++;
          totalItem.value = model.totalRecord ?? 0;
        } else {
          if (!isAPICall2.value) {
            isAPICall2.value = true;
          }

          allHistoryList2.addAll(model.data ?? []);
          page2++;

          totalItem2.value = model.totalRecord ?? 0;
        }
      } else {
        utils.showToast(message: model.responseMsg ?? "");
      }
    } catch (e) {
      isCall = false;
    }
  }

  deleteAllHistoryAPI({String? phmId}) async {
    String userId = getStorageData.readString(getStorageData.userId) ?? "";
    FormData formData = FormData.fromMap({
      "user_id": userId,
      if (!utils.isValidationEmpty(phmId)) "phm_id": phmId,
    });

    final data = await APIFunction().apiCall(
      apiName: Constants.deleteHistory,
      params: formData,
      token: getStorageData.readString(getStorageData.token),
    );

    GetAllChatHistoryModel model = GetAllChatHistoryModel.fromJson(data);

    if (model.responseCode == 1) {
      if (utils.isValidationEmpty(phmId)) {
        if (tabController!.index == 0) {
          allHistoryList.clear();
          allHistoryList2.clear();
          totalItem.value = 0;
          totalItem2.value = 0;
        } else {
          allHistoryList2.clear();
          totalItem2.value = 0;
          for (var item in allHistoryList) {
            if (item.isFavourite == "1") {
              item.isFavourite = "0";
            }
          }
        }
      } else {
        allHistoryList.removeWhere((element) {
          if (element.phmId == phmId) {
            --totalItem;
          }
          return element.phmId == phmId;
        });
        allHistoryList2.removeWhere((element) {
          if (element.phmId == phmId) {
            --totalItem2;
          }

          return element.phmId == phmId;
        });
      }
    } else {
      utils.showToast(message: model.responseMsg ?? "");
    }
  }

  getSingleChatHistoryAPI({
    required String phmId,
    required String type,
    String? promptId,
    String? stringMatch,
    String? title,
  }) async {
    String userId = getStorageData.readString(getStorageData.userId) ?? "";
    FormData formData = FormData.fromMap({"user_id": userId, "phm_id": phmId});

    final data = await APIFunction().apiCall(
      apiName: Constants.getSingleChatHistory,
      params: formData,
      token: getStorageData.readString(getStorageData.token),
    );
    log("datadatadatadatadatadata $data");
    GetSingleChatHistoryModel model = GetSingleChatHistoryModel.fromJson(data);

    if (model.responseCode == 1) {
      if (model.data?.promptDtl != null) {
        GetStorageData().saveObject(
          GetStorageData().prompts,
          model.data?.promptDtl,
        );
      }
      printAction("teletypewriter $type");
      List<ChatItem> chatItemList = <ChatItem>[];

      for (var item in model.data?.chatList ?? <ChatMessage>[]) {
        chatItemList.add(
          ChatItem(
            question: item.question,
            answer: item.answer,
            isHistorySave: true,
            isUpgraded: false,
            phmID: item.phmId,
            modelLogo: item.modelLogo,
          ),
        );
      }

      printAction(
        "chatItemListchatItemListchatItemList ${chatItemList.length}",
      );
      if (type == "real_time_web") {
        Get.delete<NewChatController>();
        Get.toNamed(
          Routes.NEW_CHAT,
          arguments: {
            HttpUtil.isAssistant: false,
            HttpUtil.chatItemList: chatItemList,
            HttpUtil.isRealTime: true,
            "toolModel": model.data?.modelDtl,
          },
        );
      } else if (type == "normal_chat") {
        Get.delete<NewChatController>();
        Get.toNamed(
          Routes.NEW_CHAT,
          arguments: {
            HttpUtil.isAssistant: false,
            HttpUtil.chatItemList: chatItemList,
            HttpUtil.isRealTime: title == "Real Time",
            // "toolModel": model.data?.modelDtl,
            "toolModel": null,
          },
        );
      } else if (type == "model_chat") {
        Get.delete<NewChatController>();
        Get.toNamed(
          Routes.NEW_CHAT,
          arguments: {
            HttpUtil.isAssistant: false,
            HttpUtil.chatItemList: chatItemList,
            HttpUtil.isModel: model.data?.modelDtl,
          },
        );
      } else if (type == "assistant") {
        Get.delete<NewChatController>();
        Get.toNamed(
          Routes.NEW_CHAT,
          arguments: {
            HttpUtil.isAssistant: true,
            HttpUtil.chatItemList: chatItemList,
            HttpUtil.assistantData: model.data?.assistantDtl,
          },
        );
      } else if (type == "text_scan") {
        Get.delete<NewChatController>();
        Get.toNamed(
          Routes.NEW_CHAT,
          arguments: {
            HttpUtil.isAssistant: false,
            HttpUtil.isTextScan: true,
            "toolModel": model.data?.modelDtl,
            HttpUtil.chatItemList: chatItemList,
          },
        );
      } else if (type == "summarize_doc") {
        Get.delete<SummarizeDocumentController>();

        Get.toNamed(
          Routes.SUMMARIZE_DOCUMENT,
          arguments: {
            HttpUtil.chatItemList: chatItemList,
            HttpUtil.fileName: model.data?.chatList?.first.fileName,
            HttpUtil.fileSize: model.data?.chatList?.first.fileSize,
            HttpUtil.fileText: model.data?.chatList?.first.fileText,
            "toolModel": model.data?.modelDtl,
          },
        );
      } else if (type == "summarize_web") {
        printAction(
          "=============112=========${model.data?.chatList?.first.fileText}",
        );
        printAction(
          "=============112=========${model.data?.chatList?.first.link}",
        );
        printAction(
          "=============112=========${model.data?.chatList?.first.link}",
        );
        Get.delete<SummarizeWebsiteController>();

        Get.toNamed(
          Routes.SUMMARIZE_WEBSITE,
          arguments: {
            HttpUtil.chatItemList: chatItemList,
            HttpUtil.link: model.data?.chatList?.first.link,
            HttpUtil.fileText: model.data?.chatList?.first.fileText,
            "toolModel": model.data?.modelDtl,
          },
        );
      } else if (type == "image_scan") {
        List<PhmIdModelData> askQuestionData = [];

        for (var item in model.data?.chatList ?? <ChatMessage>[]) {
          askQuestionData.add(
            PhmIdModelData(
              isUpgraded: false,
              question: item.question,
              answer: item.answer,
              phmId: item.phmId,
              userId: item.userId,
              img: item.img,
              scmId: item.scmId,
            ),
          );
        }
        Get.delete<ImageScanController>();
        ImageScanView.toNamed(
          askQuestionData: askQuestionData,
          model: model.data?.modelDtl,
        );
      } else if (type == "image_generation") {
        List<PhmIdModelData> askQuestionData = [];

        for (var item in model.data?.chatList ?? <ChatMessage>[]) {
          askQuestionData.add(
            PhmIdModelData(
              isUpgraded: false,
              question: item.question,
              phmId: item.phmId,
              userId: item.userId,
              img: item.img,
              scmId: item.scmId,
              createdAt: item.createdAt,
            ),
          );
        }
        Get.delete<ImageGenerationController>();

        Get.toNamed(
          Routes.IMAGE_GENERATION,
          arguments: {
            HttpUtil.chatItemList: askQuestionData,
            "toolModel": model.data?.modelDtl,
          },
        );
      } else if (type == "youtube_summarize") {
        Get.delete<YoutubeSummaryController>();

        Get.toNamed(
          Routes.YOUTUBE_SUMMARY,
          arguments: {
            HttpUtil.chatItemList: chatItemList,
            HttpUtil.link: model.data?.chatList?.first.link,
            HttpUtil.youtubeTitle: model.data?.chatList?.first.youtubeTitle,
            HttpUtil.fileText: model.data?.chatList?.first.fileText,
            "toolModel": model.data?.modelDtl,
          },
        );
      } else if (type == "prompt") {
        if (stringMatch == "math") {
          List<PhmIdModelData> askQuestionData = [];

          for (var item in model.data?.chatList ?? <ChatMessage>[]) {
            askQuestionData.add(
              PhmIdModelData(
                isUpgraded: false,
                question: item.question,
                answer: item.answer,
                phmId: item.phmId,
                userId: item.userId,
                img: item.img,
                scmId: item.scmId,
              ),
            );
          }
          Get.delete<ImageScanController>();

          ImageScanView.toNamed(
            askQuestionData: askQuestionData,
            model: model.data?.modelDtl,
            promptId: model.data?.chatList?.first.promptId,
          );

          // Get.toNamed(
          //   Routes.IMAGE_SCAN,
          //   arguments: {
          //     HttpUtil.chatItemList: askQuestionData,
          //     "toolModel": model.data?.modelDtl,
          //     "promptId": model.data?.chatList?.first.promptId,
          //   },
          // );
        } else if (stringMatch == "translation") {
          Get.delete<TranslateController>();

          Get.toNamed(
            Routes.TRANSLATE,
            arguments: {HttpUtil.chatItemList: chatItemList},
          );
        } else {
          Get.delete<PromptChatController>();

          Get.toNamed(
            Routes.PROMPT_CHAT,
            arguments: {
              "promptId": model.data?.chatList?.first.promptId,
              "name": "",
              HttpUtil.chatItemList: chatItemList,
            },
          );
        }
      }
    } else {
      utils.showToast(message: model.responseMsg ?? "");
    }
  }

  favouriteUnFavouriteChatAPI({required String phmId}) async {
    String userId = getStorageData.readString(getStorageData.userId) ?? "0";
    FormData formData = FormData.fromMap({"user_id": userId, "phm_id": phmId});

    final data = await APIFunction().apiCall(
      apiName: Constants.favouriteUnFavouriteChat,
      params: formData,
      token: getStorageData.readString(getStorageData.token),
    );

    FavouriteUnFavouriteChatModel model =
        FavouriteUnFavouriteChatModel.fromJson(data);

    if (model.responseCode == 1) {
      for (var item in allHistoryList) {
        if (item.phmId == phmId) {
          if (model.data ?? false) {
            item.isFavourite = "1";
          } else {
            item.isFavourite = "0";
          }
        }
      }
      ChatHistory? temp;
      for (var item in allHistoryList2) {
        if (item.phmId == phmId) {
          if (model.data ?? false) {
            item.isFavourite = "1";
          } else {
            temp = item;
          }
        }
      }
      bool isAdd = allHistoryList2.contains((p0) => p0.phmId == phmId);

      printAction("isAddisAddisAddisAdd $isAdd");
      if (!isAdd) {
        for (var item in allHistoryList) {
          if (item.phmId == phmId) {
            allHistoryList2.insert(0, item);
            ++totalItem2;
          }
        }
      }

      if (temp != null) {
        printAction("temptemptemptemptemp");

        allHistoryList2.removeWhere((element) => element.phmId == phmId);
        --totalItem2;
      }

      allHistoryList.refresh();
      allHistoryList2.refresh();
    } else {
      utils.showToast(message: model.responseMsg ?? "");
    }
  }

  clearAllImageDialog() async {
    CommonShowModelBottomSheet(
      child: Column(
        children: [
          Container(
            child: AppText(
              Languages.of(Get.context!)!.deleteAll,
              fontFamily: FontFamily.helveticaBold,
              fontSize: 18.px,
            ).marginOnly(top: 15.px, bottom: 10.px),
          ),
          AppText(
            textAlign: TextAlign.center,
            Languages.of(Get.context!)!.wouldYouLikeToDeleteAll,
          ),
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  verticalPadding: 12.px,
                  buttonColor: AppColors.grey1,
                  onTap: () {
                    Get.back();
                  },
                  textSize: 14.px,
                  textColor: Colors.white,
                  title: Languages.of(Get.context!)!.cancel,
                ),
              ),
              SizedBox(width: 15.px),
              Expanded(
                child: CommonButton(
                  verticalPadding: 12.px,
                  onTap: () {
                    deleteAllHistoryAPI();
                    Get.back();
                  },
                  textSize: 14.px,
                  textColor: Colors.white,
                  title: Languages.of(Get.context!)!.yes,
                ),
              ),
            ],
          ).marginOnly(top: 10.px, left: 15.px, right: 15.px, bottom: 10.px),
        ],
      ),
    );
  }

  scrollListener() {
    scrollController.addListener(() {
      if (totalItem.value > allHistoryList.length) {
        if ((scrollController.position.maxScrollExtent ==
            scrollController.position.pixels)) {
          isLoading.value = true;
          getAllChatHistoryAPI(type: "all_history");
        }
      }
    });
  }

  scrollListener2() {
    scrollController2.addListener(() {
      if (totalItem2.value > allHistoryList2.length) {
        if ((scrollController2.position.maxScrollExtent ==
                scrollController2.position.pixels) &&
            !isLoading2.value) {
          printAction("calacaclacclcalaclacaclaclacl");
          isLoading2.value = true;
          getAllChatHistoryAPI(type: "favourite");
        }
      }
    });
  }

  bool processing = false;

  @override
  void onInit() {
    scrollListener();
    scrollListener2();

    tabController = TabController(
      vsync: this,
      initialIndex: 0,
      length: historyTypeList.length,
    );
    getAllChatHistoryAPI(type: "all_history");

    tabController!.addListener(() async {
      printAction("tabController!.value.index ${tabController!.index}");
      if (tabController!.index == 0) {
        isDeleteButtonShow.value = true;
      } else {
        isDeleteButtonShow.value = false;
      }

      if (tabController!.index == 0 && !isAPICall.value) {
        page = 1;
        getAllChatHistoryAPI(type: "all_history");
      } else if (tabController!.index == 1 && !isAPICall2.value) {
        if (!processing) {
          page2 = 1;
          getAllChatHistoryAPI(type: "favourite");
        }
      }
    });

    super.onInit();
  }
}

String getDateLabel(String dateString) {
  try {
    var date = DateTime.parse(dateString).toLocal();

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final startOfWeek = today.subtract(Duration(days: today.weekday - 1));

    if (date.isAfter(today) &&
        date.isBefore(today.add(const Duration(days: 1)))) {
      return Languages.of(Get.context!)!.today;
    } else if (date.isAfter(yesterday) && date.isBefore(today)) {
      return Languages.of(Get.context!)!.yesterday;
    } else if (date.isAfter(startOfWeek)) {
      return Languages.of(Get.context!)!.thisWeek;
    } else {
      return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
    }
  } catch (e) {
    return "";
  }
}
