import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/helper/font_family.dart';
import 'package:chatsy/app/modules/home/views/home_view.dart';
import 'package:chatsy/extension.dart';

// import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Localization/local_language.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../chat_gpt/views/chat_gpt_view.dart';
import '../controllers/chat_history_controller.dart';
import '../models/get_all_chat_history_model.dart';

class ChatHistoryView extends GetView<ChatHistoryController> {
  const ChatHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatHistoryController>(
      init: ChatHistoryController(),
      builder: (controller) {
        return Obx(() {
          return CommonScreen(
            title: Languages.of(context)!.chatHistory,
            actions: [
              if (controller.isDeleteButtonShow.value && controller.allHistoryList.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    controller.clearAllImageDialog();
                  },
                  child: AppText(
                    Languages.of(context)!.deleteAll.capitalizeFirst.toString(),
                    color: AppColors().grayColor,
                    fontSize: 12.px,
                    fontFamily: FontFamily.helveticaBold,
                  ),
                ),
              SizedBox(width: 16.px),
            ],
            body: Column(
              children: [
                TabBar(
                  labelColor: AppColors.white,
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(horizontal: 16.px),
                  indicatorSize: TabBarIndicatorSize.tab,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  controller: controller.tabController,
                  labelStyle: TextStyle(
                    height: 2,
                    fontSize: 12.px,
                    fontWeight: FontWeight.w700,
                    color: AppColors().darkAndWhite.changeOpacity(0.5),
                    fontFamily: FontFamily.helveticaRegular,
                  ),
                  indicatorPadding: EdgeInsets.symmetric(vertical: 5.px),
                  tabs: controller.historyTypeList.map((e) => Tab(text: e)).toList(),
                  indicator: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(51.px),
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 12.px,
                    fontWeight: FontWeight.w700,
                    color: AppColors.tebBartTextColor,
                    fontFamily: FontFamily.helveticaRegular,
                  ),
                ),
                SizedBox(height: 10.px),
                Expanded(
                  child:
                      (!controller.isAPICall.value)
                          ? ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: progressIndicatorView(
                                  height: 30.px,
                                  width: 50.px,
                                ).marginOnly(bottom: 10.px),
                              ),
                              progressIndicatorView(
                                height: 80.px,
                                width: 100.w,
                              ).marginOnly(bottom: 10.px),
                              progressIndicatorView(
                                height: 80.px,
                                width: 100.w,
                              ).marginOnly(bottom: 10.px),
                              progressIndicatorView(
                                height: 80.px,
                                width: 100.w,
                              ).marginOnly(bottom: 10.px),
                              progressIndicatorView(
                                height: 80.px,
                                width: 100.w,
                              ).marginOnly(bottom: 10.px),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: progressIndicatorView(
                                  height: 30.px,
                                  width: 50.px,
                                ).marginOnly(bottom: 10.px),
                              ),
                              progressIndicatorView(
                                height: 80.px,
                                width: 100.w,
                              ).marginOnly(bottom: 10.px),
                              progressIndicatorView(
                                height: 80.px,
                                width: 100.w,
                              ).marginOnly(bottom: 10.px),
                              progressIndicatorView(
                                height: 80.px,
                                width: 100.w,
                              ).marginOnly(bottom: 10.px),
                            ],
                          ).paddingSymmetric(horizontal: commonLeadingWith)
                          : TabBarView(
                            controller: controller.tabController,
                            children: [
                              Theme(
                                data: ThemeData(primaryColor: AppColors.primary),
                                child: Refresher(
                                  controller: controller.easyRefreshController,
                                  onRefresh: () async {
                                    try {
                                      controller.page = 1;
                                      await controller.getAllChatHistoryAPI(type: "all_history");
                                    } finally {
                                      controller.easyRefreshController.finishRefresh();
                                    }
                                  },
                                  child:
                                      (controller.allHistoryList.isEmpty &&
                                              controller.isAPICall.value)
                                          ? Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: commonLeadingWith,
                                            ),
                                            child: Center(
                                              child: AppText(
                                                Languages.of(context)!.noDataFound,
                                                fontSize: 16.px,
                                              ),
                                            ),
                                          )
                                          : ListView.separated(
                                            controller: controller.scrollController,
                                            padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context).padding.bottom + 10.px,
                                            ),
                                            itemCount: controller.allHistoryList.length,
                                            separatorBuilder: (context, index) {
                                              return SizedBox(height: 20.px);
                                            },
                                            itemBuilder: (context, index) {
                                              ChatHistory data = controller.allHistoryList[index];

                                              final label = getDateLabel(data.createdAt ?? "");
                                              return Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  if (index == 0 ||
                                                      getDateLabel(
                                                            controller
                                                                    .allHistoryList[index - 1]
                                                                    .createdAt ??
                                                                "",
                                                          ) !=
                                                          label)
                                                    if (!utils.isValidationEmpty(label))
                                                      Container(
                                                        padding: EdgeInsets.symmetric(
                                                          horizontal: 10.px,
                                                          vertical: 3.px,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color: AppColors().lightWithe,
                                                          borderRadius: BorderRadius.circular(
                                                            10.px,
                                                          ),
                                                        ),
                                                        child: AppText(label, fontSize: 12.px),
                                                      ).marginOnly(bottom: 10.px, left: 16.px),
                                                  controller.commonHistoryView(
                                                    type: data.type ?? "",
                                                    image:
                                                        data.title == "Real Time"
                                                            ? Get.put(BottomNavigationController())
                                                                    .toolsListModel
                                                                    .firstWhereOrNull(
                                                                      (element) =>
                                                                          element.model ==
                                                                          "real_time_web",
                                                                    )
                                                                    ?.logo ??
                                                                ""
                                                            : data.displayImg ?? "",
                                                    title:
                                                        data.title == "Real Time"
                                                            ? Get.put(BottomNavigationController())
                                                                    .toolsListModel
                                                                    .firstWhereOrNull(
                                                                      (element) =>
                                                                          element.model ==
                                                                          "real_time_web",
                                                                    )
                                                                    ?.name ??
                                                                ""
                                                            : data.displayTitle ?? "",
                                                    subTitle: data.lastChatMessage?.question ?? "",
                                                    time: data.lastChatMessage?.createdAt ?? "",
                                                    deleteOnTap: () {
                                                      controller.deleteAllHistoryAPI(
                                                        phmId: data.phmId,
                                                      );
                                                    },
                                                    onTap: () {
                                                      controller.getSingleChatHistoryAPI(
                                                        title: data.title,
                                                        phmId: data.phmId ?? "0",
                                                        type: data.type ?? "",
                                                        promptId: data.promptId,
                                                        stringMatch: data.stringMatch,
                                                      );
                                                    },
                                                    isFavorite: data.isFavourite ?? "0",
                                                    favoriteOnTap: () {
                                                      controller.favouriteUnFavouriteChatAPI(
                                                        phmId: data.phmId ?? "0",
                                                      );
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                ),
                              ),
                              Theme(
                                data: ThemeData(primaryColor: AppColors.primary),
                                child: Refresher(
                                  controller: controller.easyRefreshController2,
                                  onRefresh: () async {
                                    try {
                                      controller.page2 = 1;
                                      printAction(
                                        "SmartRefresherSmartRefresherSmartRefresherSmartRefresherSmartRefresher",
                                      );
                                      await controller.getAllChatHistoryAPI(type: "favourite");
                                    } finally {
                                      controller.easyRefreshController2.finishRefresh();
                                    }
                                  },
                                  child:
                                      (controller.allHistoryList2.isEmpty &&
                                              controller.isAPICall2.value)
                                          ? Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: commonLeadingWith,
                                            ),
                                            child: Center(
                                              child: AppText(
                                                Languages.of(context)!.noDataFound,
                                                fontSize: 16.px,
                                              ),
                                            ),
                                          )
                                          : ListView.separated(
                                            controller: controller.scrollController2,
                                            padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context).padding.bottom + 10.px,
                                            ),
                                            itemCount: controller.allHistoryList2.length,
                                            separatorBuilder: (context, index) {
                                              return SizedBox(height: 20.px);
                                            },
                                            itemBuilder: (context, index) {
                                              ChatHistory data = controller.allHistoryList2[index];
                                              final label = getDateLabel(data.createdAt ?? "");
                                              return Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  if (index == 0 ||
                                                      getDateLabel(
                                                            controller
                                                                    .allHistoryList2[index - 1]
                                                                    .createdAt ??
                                                                "",
                                                          ) !=
                                                          label)
                                                    if (!utils.isValidationEmpty(label))
                                                      Container(
                                                        padding: EdgeInsets.symmetric(
                                                          horizontal: 10.px,
                                                          vertical: 3.px,
                                                        ),
                                                        decoration: BoxDecoration(
                                                          color: AppColors().lightWithe,
                                                          borderRadius: BorderRadius.circular(
                                                            10.px,
                                                          ),
                                                        ),
                                                        child: AppText(label, fontSize: 12.px),
                                                      ).marginOnly(bottom: 10.px, left: 16.px),
                                                  controller.commonHistoryView(
                                                    type: data.type ?? "",
                                                    isDeleteButton: false,
                                                    image: data.displayImg ?? "",
                                                    title: data.displayTitle ?? "",
                                                    subTitle: data.lastChatMessage?.question ?? "",
                                                    time: data.lastChatMessage?.createdAt ?? "",
                                                    deleteOnTap: () {},
                                                    onTap: () {
                                                      controller.getSingleChatHistoryAPI(
                                                        phmId: data.phmId ?? "0",
                                                        type: data.type ?? "",
                                                        promptId: data.promptId,
                                                        stringMatch: data.stringMatch,
                                                        title: data.title,
                                                      );
                                                    },
                                                    isFavorite: data.isFavourite ?? "0",
                                                    favoriteOnTap: () {
                                                      controller.favouriteUnFavouriteChatAPI(
                                                        phmId: data.phmId ?? "0",
                                                      );
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                ),
                              ),
                            ],
                          ),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
