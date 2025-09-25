import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatsy/app/helper/image_path.dart';
import 'package:chatsy/app/modules/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:chatsy/extension.dart';
import 'package:popover/popover.dart';

import '../../../Localization/local_language.dart';
import '../../../common_widget/common_button.dart';
import '../../../common_widget/common_container.dart';
import '../../../helper/Global.dart';
import '../../../helper/all_imports.dart';
import '../../chat_gpt/controllers/chat_gpt_controller.dart';
import '../../chat_gpt/views/chat_gpt_view.dart';
import '../../home/controllers/user_profile_model.dart';
import '../../imageScan/controllers/image_scan_controller.dart';
import '../../newChat/controllers/new_chat_controller.dart';
import '../../promptChat/controllers/prompt_chat_controller.dart';
import '../../settings/controllers/settings_controller.dart';
import '../../translate/controllers/translate_controller.dart';
import '../controllers/bottom_navigation_controller.dart';

class PopUpMenu extends StatefulWidget {
  const PopUpMenu({super.key, required this.data});

  final Rx<ToolsModel?>? data;

  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {
  Timer? currentTime;

  @override
  void dispose() {
    currentTime?.cancel();
    super.dispose();
  }

  late Rx<ToolsModel?> data;

  @override
  void initState() {
    super.initState();

    if (widget.data != null) {
      data = widget.data!;
    } else {
      var index = 0;

      if (getStorageData.containKey(getStorageData.selectModelIndex)) {
        index = int.parse(
          getStorageData.readString(getStorageData.selectModelIndex) ?? "0",
        );
      }

      data = Rx(controller.selectAiModelList[index]);
    }
  }

  BottomNavigationController get controller => Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
        child:
            data.value != null
                ? Padding(
                  padding: EdgeInsets.only(
                    right: 10.px,
                    bottom: 5.px,
                    top: 5.px,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.px,
                      vertical: 10.px,
                    ),
                    color: AppColors.transparent,
                    child: Row(
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: data.value?.logo ?? "",
                            height: 20.px,
                            width: 20.px,
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                    progressIndicatorView(circle: true),
                            errorWidget:
                                (context, url, uri) =>
                                    errorWidgetView().paddingAll(8.px),
                          ),
                        ),
                        SizedBox(width: 5.px),
                        AppText(
                          data.value?.name ?? "",
                          fontSize: 14.px,
                          color: AppColors().darkAndWhite,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors().darkAndWhite,
                          size: 18.px,
                        ),
                      ],
                    ),
                  ),
                )
                : const SizedBox(),
        onTap: () {
          showPopover(
            context: context,
            backgroundColor: AppColors().whiteAndDark,
            transitionDuration: const Duration(milliseconds: 150),
            bodyBuilder: (context) {
              int selectModelIndex =
                  (getStorageData.containKey(getStorageData.selectModelIndex))
                      ? int.parse(
                        getStorageData.readString(
                              getStorageData.selectModelIndex,
                            ) ??
                            "0",
                      )
                      : 0;
              var setStateUpdate = setState;
              return StatefulBuilder(
                builder: (context, setState) {
                  return Scrollbar(
                    child: Container(
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
                          ...List.generate(controller.selectAiModelList.length, (
                            index,
                          ) {
                            ToolsModel data = ToolsModel();
                            if (controller.selectAiModelList.length > index) {
                              data = controller.selectAiModelList[index];
                            }

                            return GestureDetector(
                              onTap: () async {
                                if (data.isComingSoon == "1") {
                                  return;
                                }

                                HapticFeedback.mediumImpact();

                                printAction("data.isPremium ${data.isPremium}");
                                if (data.isPremium == "1" &&
                                    Global.isSubscription.value != "1") {
                                  utils.showToast(
                                    message:
                                        Languages.of(
                                          context,
                                        )!.pleasePurchasePlanForAccess,
                                  );
                                  return;
                                }
                                selectModelIndex = index;

                                editChatGptModelAPI(
                                  modelId:
                                      controller
                                          .selectAiModelList[selectModelIndex]
                                          .modelId ??
                                      "",
                                  title:
                                      controller
                                          .selectAiModelList[selectModelIndex]
                                          .modelId ??
                                      "",
                                );

                                for (var item in controller.selectAiModelList) {
                                  if (item.modelId ==
                                      (controller
                                              .selectAiModelList[selectModelIndex]
                                              .modelId ??
                                          "")) {
                                    var indexOf = controller.selectAiModelList
                                        .indexOf(item);
                                    getStorageData.saveString(
                                      getStorageData.selectModelIndex,
                                      indexOf.toString(),
                                    );
                                    this.data.value =
                                        controller.selectAiModelList[indexOf];
                                    ChatApi.selectModelIndex = controller
                                        .selectAiModelList
                                        .indexOf(item);
                                    printAction(
                                      "123123ChatApi.selectModelIndexChatApi.selectModelIndexChatApi.selectModelIndex ${ChatApi.selectModelIndex}",
                                    );
                                    printAction(
                                      "123123ChatApi.selectModelIndexChatApi${(getStorageData.containKey(getStorageData.selectModelIndex)) ? int.parse(getStorageData.readString(getStorageData.selectModelIndex) ?? "0") : 0}",
                                    );
                                    break;
                                  }
                                }
                                setStateUpdate(() {});
                                setState(() {});

                                if (Get.isRegistered<NewChatController>()) {
                                  Get.put(NewChatController()).update();
                                }
                                if (Get.isRegistered<ImageScanController>()) {
                                  Get.put(ImageScanController()).update();
                                }
                                if (Get.isRegistered<PromptChatController>()) {
                                  Get.put(PromptChatController()).update();
                                }
                                if (Get.isRegistered<TranslateController>()) {
                                  Get.put(TranslateController()).update();
                                }

                                currentTime = Timer(
                                  const Duration(milliseconds: 500),
                                  () {
                                    Get.back();
                                  },
                                );
                              },
                              child: AbsorbPointer(
                                child: Column(
                                  children: [
                                    SizedBox(height: 10.px),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipOval(
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                data.logo ??
                                                "${Constants.imageBaseUrl}ai_model/cloud.png",
                                            width: 25.px,
                                            height: 25.px,
                                            progressIndicatorBuilder:
                                                (context, url, progress) =>
                                                    progressIndicatorView(
                                                      borderRadius: 10.px,
                                                    ),
                                            errorWidget:
                                                (context, url, uri) =>
                                                    errorWidgetView()
                                                        .paddingAll(8.px),
                                          ),
                                        ),
                                        SizedBox(width: 8.px),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppText(
                                                data.name ?? "",
                                                fontSize: 14.px,
                                              ),
                                              AppText(
                                                (data.isComingSoon == "1")
                                                    ? "Coming Soon"
                                                    : data.description ??
                                                        "Coming Soon",
                                                fontSize: 11.px,
                                                color: const Color(0xFF9B9B9B),
                                              ),
                                              // Expanded(
                                              //   child: AppText(
                                              //     data.name ?? "",
                                              //     fontSize: 16.px,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        if (data.isPremium == "1" &&
                                            data.isComingSoon == "0")
                                          if (Global.isSubscription.value !=
                                              "1")
                                            CommonContainer(
                                              color: const Color(0xFF3BDBD4),
                                              child: Padding(
                                                /// TODO: Font change padding change
                                                padding: EdgeInsets.fromLTRB(
                                                  10.px,
                                                  5.px,
                                                  10.px,
                                                  3.px,
                                                ),
                                                child: AppText(
                                                  Languages.of(context)!.pro,
                                                  fontSize: 13.px,
                                                  color:
                                                      AppColors().whiteAndDark,
                                                ),
                                              ),
                                            ),
                                        SizedBox(width: 10.px),

                                        Container(
                                          padding: EdgeInsets.all(6.px),
                                          decoration: BoxDecoration(
                                            color:
                                                (index == selectModelIndex)
                                                    ? AppColors.primary
                                                    : Colors.transparent,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color:
                                                  (index == selectModelIndex)
                                                      ? Colors.transparent
                                                      : AppColors()
                                                          .borderBottomBar,
                                              width: 1,
                                            ),
                                          ),
                                          child:
                                              (index == selectModelIndex)
                                                  ? Image.asset(
                                                    ImagePath.trues,
                                                    height: 8.px,
                                                  )
                                                  : SizedBox(
                                                    height: 8.px,
                                                    width: 8.px,
                                                  ),
                                        ),
                                        /*Builder(builder: (context) {
                                            return AnimCheckBox.done(
                                              dimensions: 20,
                                              selected: (index == selectModelIndex),
                                              duration: Durations.long4,
                                              checkedWidget: ColoredBox(
                                                color: AppColors.primary,
                                                child: Center(
                                                  child: SizedBox.square(
                                                    dimension: 12,
                                                    child: ColoredBox(color: AppColors.primary, child: Image.asset(ImagePath.trues, height: 3.px)),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),*/
                                        // Container(
                                        //   decoration: BoxDecoration(
                                        //     shape: BoxShape.circle,
                                        //     border: Border.all(color: (index == selectModelIndex) ? AppColors.primary : AppColors().darkAndWhite.changeOpacity(0.4)),
                                        //   ),
                                        //   child: Container(
                                        //     height: 18.px,
                                        //     width: 18.px,
                                        //     padding: EdgeInsets.all(4.px),
                                        //     decoration: BoxDecoration(color: (index == selectModelIndex) ? AppColors.primary : AppColors.white, shape: BoxShape.circle),
                                        //     child: (index == selectModelIndex)
                                        //         ? Image.asset(
                                        //             ImagePath.trues,
                                        //             height: 5.px,
                                        //           )
                                        //         : const SizedBox(),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    SizedBox(height: 10.px),
                                    if (!(index ==
                                            (controller
                                                .selectAiModelList
                                                .length) &&
                                        Global.isSubscription.value == "1"))
                                      Container(
                                        height: 2,
                                        color: AppColors().darkAndWhite
                                            .changeOpacity(0.04),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          SizedBox(height: 10.px),
                          if (Global.isSubscription.value != "1")
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 5.px),
                                LimitAndHistoryButtonView(padding: 0),
                                SizedBox(width: 3.px),
                                Expanded(
                                  child: AppText(
                                    "${Global.chatLimit} ${Languages.of(context)!.creditsLeftToday}",
                                    fontSize: 16.px,
                                  ),
                                ),
                              ],
                            ),
                          // else
                          //   Row(
                          //     children: [
                          //       // SizedBox(width: 5.px),
                          //       Container(
                          //         height: 25.px,
                          //         width: 25.px,
                          //         alignment: Alignment.center,
                          //         decoration: BoxDecoration(
                          //           shape: BoxShape.circle,
                          //           border: Border.all(color: AppColors().darkAndWhite.changeOpacity(0.05)),
                          //         ),
                          //         child: Image.asset(((isLight) ? ImagePath.darkLogo : ImagePath.logo), height: 15.px),
                          //       ),
                          //       SizedBox(width: 10.px),
                          //       RichText(
                          //         text: TextSpan(
                          //           children: [
                          //             TextSpan(
                          //               text: Languages.of(Get.context!)!.youAre,
                          //               style: TextStyle(
                          //                 fontSize: 18.px,
                          //                 color: AppColors().darkAndWhite,
                          //                 fontWeight: FontWeight.w700,
                          //               ),
                          //             ),
                          //             TextSpan(
                          //               text: Languages.of(Get.context!)!.pro,
                          //               style: TextStyle(
                          //                 fontSize: 20.px,
                          //                 color: AppColors.primary,
                          //                 fontWeight: FontWeight.w700,
                          //               ),
                          //             ),
                          //             // TextSpan(
                          //             //   text: Languages.of(Get.context!)!.user,
                          //             //   style: TextStyle(
                          //             //     fontSize: 16.px,
                          //             //     color: AppColors().darkAndWhite,
                          //             //     fontWeight: FontWeight.w700,
                          //             //   ),
                          //             // ),
                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),

                          // SizedBox(height: 10.px),
                          if (Global.isSubscription.value != "1")
                            CommonButton(
                              onTap: () {
                                Get.back();
                                Get.put(ChatGptController()).goToPurchasePage();
                              },
                              title: Languages.of(context)!.upgradeToPRO,
                              verticalPadding: 10.px,
                            ).paddingSymmetric(horizontal: 5.w),
                          /*ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(bottom: 10.px),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.selectAiModelList.length,
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
                        ToolsModel data = controller.selectAiModelList[index];
                        return GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            setState(() {
                              selectModelIndex = index;
                              editChatGptModelAPI(modelName: controller.selectAiModelList[selectModelIndex].model ?? "", title: controller.selectAiModelList[selectModelIndex].name ?? "");
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
                          if (Global.isSubscription.value != "1")
                            SizedBox(height: 15.px),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            onPop: () => debugPrint('Popover was popped!'),
            width: 60.w,
            direction: PopoverDirection.bottom,
            barrierColor: const Color(0xff191919).changeOpacity(0.5),
            arrowHeight: 10,
            arrowWidth: 15,
          );
        },
      );
    });
  }
}

// class ListItems extends StatelessWidget {
//   const ListItems({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scrollbar(
//       child: StatefulBuilder(
//         builder: (context, setState) {
//           return;
//         },
//       ),
//     );
//   }
// }
