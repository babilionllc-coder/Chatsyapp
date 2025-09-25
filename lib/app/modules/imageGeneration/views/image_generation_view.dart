import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/modules/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:chatsy/service/core/exception.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '/extension.dart';
import '../../../Localization/local_language.dart';
import '../../../common_widget/comman_text_field.dart';
import '../../../common_widget/common_prompt_view.dart';
import '../../../common_widget/common_screen.dart';
import '../../../helper/font_family.dart';
import '../../../helper/image_path.dart';
import '../../../routes/app_pages.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../chatHistory/controllers/chat_history_controller.dart';
import '../../chat_gpt/controllers/chat_gpt_controller.dart';
import '../../chat_gpt/views/chat_gpt_view.dart';
import '../../home/controllers/user_profile_model.dart';
import '../../home/views/home_view.dart';
import '../../newChat/component/add_other_prompts_view.dart';
import '../../newChat/controllers/new_chat_controller.dart';
import '../../newChat/views/new_chat_view.dart';
import '../controllers/image_generation_controller.dart';

class ImageGenerationView extends GetView<ImageGenerationController> {
  const ImageGenerationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageGenerationController>(
      init: ImageGenerationController(),
      builder: (controller) {
        return CommonScreen(
          lineUpScrollBtn: 0.66,
          scrollController: controller.scrollController,
          leadingOnTap: () async {
            Get.back();
          },
          titleView: infoView(
            onTap: () {
              Get.find<ChatGptController>().imageGenerationFirstBottomSheet(
                controller.toolModel ?? ToolsModel(),
                onTap: () {},
              );
            },
          ),
          actions: [
            Obx(() {
              return GestureDetector(
                onTap: () {
                  controller.imageFilter();
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(5.px, 6.px, 5.px, 3.px),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20.px)),
                    border: Border.all(color: AppColors().grayMix.changeOpacity(0.5), width: 1),
                  ),
                  child: AppText(
                    (controller.selectStyle.value.trim().length > 3)
                        ? "${controller.selectStyle.value.substring(0, 3)} ${controller.selectRatio.value}"
                        : "${controller.selectStyle.value} ${controller.selectRatio.value}",
                    color: AppColors().darkGray,
                    fontSize: 11.px,
                  ),
                ).paddingOnly(right: 10.px),
              );
            }),
            LimitAndHistoryButtonView(),

            //   Get.put(BottomNavigationController()).limitView(),
          ],
          backgroundColor: AppColors().backgroundColor1,
          title: controller.toolModel?.name ?? "",
          body: Obx(() {
            controller.menu.value;

            return Column(
              children: [
                Expanded(
                  child: MenuView(
                    visible: controller.menu.value,
                    menuWidget: AddOtherPromptsView(
                      // onTapForAiAssistants: () {
                      //   Get.put(BottomNavigationController()).backToTemplateOrAssistants(apiCall: 1.obs);
                      // },
                      // onTapForTemplate: () {
                      //   Get.put(BottomNavigationController()).backToTemplateOrAssistants(apiCall: 2.obs);
                      // },
                    ),
                    backGroundWidget: Stack(
                      children: [
                        NotificationListener<ScrollMetricsNotification>(
                          onNotification: (notification) {
                            if (notification.metrics.extentAfter > 12 &&
                                notification.metrics.axis == Axis.vertical) {
                              // controller.scrollController.animateTo(
                              //   controller.scrollController.position.maxScrollExtent,
                              //   duration: const Duration(milliseconds: 100),
                              //   curve: Curves.linear,
                              // );
                            }
                            return true;
                          },
                          child: Builder(
                            builder: (context) {
                              return SingleChildScrollView(
                                controller: controller.scrollController,
                                padding: EdgeInsets.only(bottom: 84),
                                child: ListView(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  children: [
                                    if (controller.askQuestionData.isNotEmpty &&
                                        controller.askQuestionData[0].answer != null)
                                      Row(
                                        children: [
                                          Expanded(
                                            child: AppText(
                                              Languages.of(Get.context!)!.recentImages,
                                              fontSize: 14.px,
                                              fontFamily: FontFamily.helveticaBold,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              controller.clearAllImageDialog();
                                            },
                                            child: AppText(
                                              Languages.of(Get.context!)!.clearAll,
                                              fontSize: 12.px,
                                            ),
                                          ),
                                        ],
                                      ).marginOnly(bottom: 12.px, left: 16.px, right: 16.px),
                                    if (controller.askQuestionData.isNotEmpty &&
                                        controller.askQuestionData[0].answer != null)
                                      SizedBox(
                                        height: 100.px,
                                        child: Obx(
                                          () => ListView.separated(
                                            itemCount: controller.askQuestionData.length,
                                            shrinkWrap: true,
                                            padding: EdgeInsets.symmetric(horizontal: 16.px),
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (BuildContext context, int index) {
                                              return (controller.askQuestionData[index].img ==
                                                          ImagePath.icImageLoading ||
                                                      utils.isValidationEmpty(
                                                        controller.askQuestionData[index].img
                                                            ?.trim(),
                                                      ))
                                                  ? const SizedBox()
                                                  : ClipRRect(
                                                    borderRadius: BorderRadius.circular(10.px),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl:
                                                          controller.askQuestionData[index].img
                                                              ?.trim() ??
                                                          "",
                                                      height: 100.px,
                                                      width: 100.px,
                                                      progressIndicatorBuilder:
                                                          (context, url, progress) =>
                                                              progressIndicatorView(
                                                                borderRadius: 10.px,
                                                              ),
                                                      errorWidget:
                                                          (context, url, uri) =>
                                                              errorWidgetView().paddingAll(8.px),
                                                    ),
                                                  );
                                            },
                                            separatorBuilder: (BuildContext context, int index) {
                                              return SizedBox(width: 10.px);
                                            },
                                          ),
                                        ),
                                      ).marginOnly(bottom: 20.px),
                                    AppText(
                                      (controller.askQuestionData.isNotEmpty &&
                                              (!Utils().isValidationEmpty(
                                                controller
                                                    .askQuestionData[controller
                                                            .askQuestionData
                                                            .length -
                                                        1]
                                                    .createdAt,
                                              )))
                                          ? getDateLabel(
                                            controller
                                                    .askQuestionData[controller
                                                            .askQuestionData
                                                            .length -
                                                        1]
                                                    .createdAt ??
                                                "Today",
                                          )
                                          : "Today",
                                      fontSize: 14.px,
                                      fontFamily: FontFamily.helveticaBold,
                                    ).marginOnly(bottom: 10, left: 16.px, right: 16.px),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 16.px),
                                      child: chatQuestionAnsView(
                                        ansIcon: controller.toolModel?.logo ?? "",
                                        ans:
                                            "Hello! What visual masterpiece would you like to see?",
                                        onTapAns: () {},
                                      ),
                                    ),
                                    Obx(
                                      () => ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: controller.askQuestionData.length,
                                        itemBuilder: (context, index) {
                                          return chatQuestionAnsView(
                                            scrollController: controller.scrollController,
                                            isUpgrade: controller.askQuestionData[index].isUpgraded,
                                            ansImage:
                                                controller.askQuestionData[index].img?.trim() ?? "",
                                            question:
                                                controller.askQuestionData[index].question ?? '',
                                            ansIcon: controller.toolModel?.logo ?? "",
                                            isBorder: false,
                                            onTapAns: () {
                                              Get.toNamed(
                                                Routes.IMAGE_SHOW,
                                                arguments: {
                                                  "imageUrl":
                                                      controller.askQuestionData[index].img?.trim(),
                                                  "question":
                                                      controller.askQuestionData[index].question,
                                                },
                                              )?.then((value) {
                                                if (value == HttpUtil.regenerate) {
                                                  if (!utils.isValidationEmpty(
                                                    controller.askQuestionData[index].question,
                                                  )) {
                                                    if (!controller.apiState.isLoading) {
                                                      controller.convertTextToImageAPI(
                                                        question:
                                                            controller
                                                                .askQuestionData[index]
                                                                .question
                                                                .toString(),
                                                        isRegenerate: true,
                                                      );
                                                    }
                                                  }
                                                } else if (value == HttpUtil.createAnother) {
                                                  if (!utils.isValidationEmpty(
                                                    controller.askQuestionData[index].question,
                                                  )) {
                                                    if (!controller.apiState.isLoading) {
                                                      controller.convertTextToImageAPI(
                                                        question:
                                                            controller
                                                                .askQuestionData[index]
                                                                .question
                                                                .toString(),
                                                        isRegenerate: false,
                                                      );
                                                    }
                                                  }
                                                } else if (value == HttpUtil.deleteImage) {
                                                  controller.deleteSingleChatAPI(
                                                    scmId:
                                                        controller.askQuestionData[index].scmId ??
                                                        "",
                                                  );
                                                }
                                              });
                                            },
                                          );
                                        },
                                      ).marginSymmetric(horizontal: 16.px),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: AppColors().backgroundColor1.changeOpacity(.7),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      height: 42.px,
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: controller.mainList.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              controller.promptListUpdate(index);
                                            },
                                            child: CommonPromptView(
                                              bgColor:
                                                  (controller.mainListIndex.value == index)
                                                      ? AppColors.primary
                                                      : AppColors().ansColor,
                                              prompt: controller.mainList[index].title,
                                              boxShadow: false,
                                              color:
                                                  (controller.mainListIndex.value == index)
                                                      ? AppColors.white
                                                      : AppColors().darkAndWhite,
                                              prefixIcon: SvgPicture.asset(
                                                controller.mainList[index].image ?? "",
                                                height: 16.px,
                                                width: 16.px,
                                                color:
                                                    (controller.mainListIndex.value == index)
                                                        ? AppColors.white
                                                        : null,
                                              ).marginOnly(right: 4.px),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 42.px,
                                      child: ListView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: controller.promptList.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () async {
                                              await Get.put(
                                                BottomNavigationController(),
                                              ).speechToText.stop();
                                              getStorageData.saveListening(value: false);
                                              getStorageData.saveSend(value: true);
                                              Future.delayed(
                                                const Duration(milliseconds: 100),
                                                () async {
                                                  controller.newChatController.text =
                                                      controller.promptList[index].backendName ??
                                                      "";
                                                  controller.newChatFocusNode.requestFocus();

                                                  Future.delayed(
                                                    const Duration(milliseconds: 200),
                                                    () {
                                                      controller.update();
                                                    },
                                                  );
                                                },
                                              );
                                              // if (!utils.isValidationEmpty(controller.promptList
                                              //
                                              // [index].backendName)) {
                                              //   if (!controller.isAPICall.value) {
                                              //     controller.convertTextToImageAPI(question: controller.promptList[index].backendName ?? "", isRegenerate: false);
                                              //   }
                                              // }
                                            },
                                            child: CommonPromptView(
                                              prompt: controller.promptList[index].title ?? "",
                                              bgColor: AppColors().whiteAndDark,
                                              boxShadow: true,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Column(
                    //   children: [
                    //     Expanded(
                    //       child: ,
                    //     ),
                    //     ,
                    //   ],
                    // ),
                  ),
                ),

                //  if (MediaQuery.of(context).viewInsets.bottom == 0)
                // IntrinsicHeight(
                //   child: Row(
                //     children: [
                //       AddWidget(
                //         visible: controller.menu.value,
                //         onTap: () async {
                //           addOtherPromptsOnTap(menu: controller.menu, context: context);
                //         },
                //       ),
                //       TextField(),
                //     ],
                //   ),
                // ),
                CommonTextField(
                  // color: AppColors().bgColor3,
                  prefixIcon: AddWidget(
                    visible: controller.menu.value,
                    onTap: () async {
                      addOtherPromptsOnTap(menu: controller.menu, context: context);
                    },
                  ),
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  focusNode: controller.newChatFocusNode,
                  maxLine: 4,
                  minLine: 1,
                  controller: controller.newChatController,
                  hintText: "Ask anything...",
                  isMic: true,
                  onStop: () {},
                  apiState: controller.apiState,
                  onSend: () {
                    if (!utils.isValidationEmpty(controller.newChatController.text)) {
                      controller.convertTextToImageAPI(
                        question: controller.newChatController.text,
                        isRegenerate: false,
                      );
                    }
                  },
                  // suffixIconConstraints: const BoxConstraints(),
                ).paddingSymmetric(horizontal: 16.px),
              ],
            );
          }),
        );
      },
    );
  }
}
