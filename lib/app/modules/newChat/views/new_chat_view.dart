import 'dart:ui';

import 'package:chatsy/app/common_widget/comman_text_field.dart';
import 'package:chatsy/app/common_widget/common_prompt_view.dart';
import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/modules/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:chatsy/app/modules/bottom_navigation/widget/popup_menu.dart';
import 'package:chatsy/app/modules/home/controllers/ai_assistants_model.dart';
import 'package:chatsy/app/modules/home/views/home_view.dart';
import 'package:chatsy/app/modules/newChat/component/edit_helper.dart';
import 'package:flutter_svg/svg.dart';

import '/extension.dart';
import '../../../helper/Global.dart';
import '../../../helper/image_path.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../chat_gpt/controllers/chat_gpt_controller.dart';
import '../../home/controllers/user_profile_model.dart';
import '../component/add_other_prompts_view.dart';
import '../controllers/new_chat_controller.dart';

class NewChatView extends GetView<NewChatController> {
  const NewChatView({super.key});

  double get _padding {
    double bottom = 42;
    if (controller.mainList.isNotEmpty) {
      bottom += 42;
    }
    return bottom;
  }

  @override
  Widget build(BuildContext context) {
    controller.modelTitle =
        controller.isRealTime != false
            ? Constants.realTimeWebType
            : controller.isTextScan
            ? "Text Scan"
            : (controller.modelType.name ??
                (Get.put(BottomNavigationController()).selectAiModelList.isEmpty
                    ? "Chat GPT"
                    : Get.put(
                          BottomNavigationController(),
                        ).selectAiModelList[ChatApi.selectModelIndex].name ??
                        "Chat GPT"));
    controller.type =
        controller.isRealTime != false
            ? "real_time_web"
            : controller.isTextScan
            ? "text_scan"
            : utils.isValidationEmpty(controller.modelType.name)
            ? "normal_chat"
            : "model_chat";

    return RepaintBoundary(
      child: GetBuilder<NewChatController>(
        init: NewChatController(),
        builder: (controller) {
          return Obx(() {
            controller.chatItem;
            return CommonScreen(
              scrollController: controller.scrollController,
              lineUpScrollBtn: controller.mainList.isNotEmpty ? 0.66 : 0.78,
              leadingOnTap: () async {
                Get.back();
              },
              titleView: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // if (controller.assistantsData.userId != null)
                  if (controller.isTextScan ||
                      (utils.isValidationEmpty(controller.modelType.model) &&
                          !controller.isRealTime &&
                          !controller.isTextScan))
                    PopUpMenu(data: controller.modelTypeForDropDown),
                  // if (utils.isValidationEmpty(controller.modelType.model) && !controller.isTextScan) const ChatViewType(),
                  if (controller.isTextScan || controller.isRealTime)
                    infoView(
                      onTap: () {
                        if (controller.isTextScan) {
                          Get.find<ChatGptController>()
                              .textScanFirstBottomSheet(
                                controller.toolModel ?? ToolsModel(),
                                onTap: () {},
                              );
                        }
                      },
                    )
                  else if ( /* !utils.isValidationEmpty(controller.modelType.modelId) && */ controller
                          .modelType
                          .modelId !=
                      '12')
                    infoView(
                      onTap: () {
                        if (controller.isTextScan) {
                          Get.find<ChatGptController>()
                              .textScanFirstBottomSheet(
                                controller.toolModel ?? ToolsModel(),
                                onTap: () {},
                              );
                        } else {
                          var modelId =
                              controller.modelTypeForDropDown?.value?.modelId ??
                              controller.modelType.modelId;
                          var logo =
                              controller.modelTypeForDropDown?.value?.logo ??
                              controller.modelType.logo;

                          modelId.log;
                          if (logo == null) return;

                          switch (modelId) {
                            case '1':
                              Get.find<ChatGptController>()
                                  .chatGptFirstTimeBottomSheet(
                                    image: logo,
                                    onTap: () {},
                                  );
                            case '3':
                              Get.find<ChatGptController>()
                                  .gpt4oFirstTimeBottomSheet(
                                    image: logo,
                                    onTap: () {},
                                  );
                            case '4':
                              Get.find<ChatGptController>()
                                  .geminiFirstTimeBottomSheet(
                                    image: logo,
                                    onTap: () {},
                                  );
                            case '5':
                              Get.find<ChatGptController>()
                                  .palmFirstTimeBottomSheet(
                                    image: logo,
                                    onTap: () {},
                                  );
                          }
                        }
                      },
                    ),
                ],
              ),
              title:
                  /* (controller.isAssistant &&
                          (controller.assistantsData.userId != '0') &&
                          controller.assistantsData.model != null)
                      ? switch (controller.assistantsData.model!) {
                        AIModel.gpt4o => Languages.of(context)!.gpt4o,
                        AIModel.gemini => Languages.of(context)!.gemini,
                      }
                      : */
                  controller.isTextScan
                      ? null
                      : (!utils.isValidationEmpty(controller.modelType.model))
                      ? controller.modelType.name
                      : controller.toolModel?.name,
              backgroundColor: AppColors().backgroundColor1,
              actions: [
                Get.put(
                  BottomNavigationController(),
                ).commonResponseToneBottomBar(),
                LimitAndHistoryButtonView(),
              ],
              body: Column(
                children: [
                  // Get.put(BottomNavigationController()).refilledView(context: context),
                  Expanded(
                    child: Obx(() {
                      String? ans;
                      if (controller.isTextScan) {
                        ans =
                            "The text has been successfully recognized! Tell me what you want me to do with it, or type in any other request.";
                      } else {
                        if ((!utils.isValidationEmpty(
                          controller.modelType.model,
                        ))) {
                          ans =
                              "Hi ${utils.isValidationEmpty(getStorageData.readString(getStorageData.userName)) ? "John" : getStorageData.readString(getStorageData.userName).toString().substring(0, getStorageData.readString(getStorageData.userName).toString().length > 10 ? 10 : getStorageData.readString(getStorageData.userName).toString().length)}, I’m ${controller.modelType.name}, Ask me anything!";
                        } else {
                          if ((controller.isAssistant) &&
                              controller.assistantsData.assistantDesc != null &&
                              controller.assistantsData.assistantDesc!
                                  .trim()
                                  .isNotEmpty) {
                            ans = (controller.assistantsData.assistantDesc)
                                ?.replaceFirst(
                                  RegExp('{.*}'),
                                  utils.isValidationEmpty(
                                        getStorageData.readString(
                                          getStorageData.userName,
                                        ),
                                      )
                                      ? "John"
                                      : getStorageData
                                          .readString(getStorageData.userName)
                                          .toString()
                                          .substring(
                                            0,
                                            getStorageData
                                                        .readString(
                                                          getStorageData
                                                              .userName,
                                                        )
                                                        .toString()
                                                        .length >
                                                    10
                                                ? 10
                                                : getStorageData
                                                    .readString(
                                                      getStorageData.userName,
                                                    )
                                                    .toString()
                                                    .length,
                                          ),
                                );
                          } else {
                            ans =
                                "Hi ${utils.isValidationEmpty(getStorageData.readString(getStorageData.userName)) ? "John" : getStorageData.readString(getStorageData.userName).toString().substring(0, getStorageData.readString(getStorageData.userName).toString().length > 10 ? 10 : getStorageData.readString(getStorageData.userName).toString().length)}! How I can help you?";
                          }
                        }
                      }
                      return MenuView(
                        visible: controller.menu.value,
                        menuWidget: AddOtherPromptsView(
                          apiCall: controller.apiCall,
                        ),
                        backGroundWidget: NotificationListener<
                          ScrollMetricsNotification
                        >(
                          onNotification: (notification) {
                            if (notification.metrics.extentAfter > 12) {
                              // controller.scrollController.animateTo(controller.scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.linear);
                            }
                            return true;
                          },
                          child: Stack(
                            children: [
                              SingleChildScrollView(
                                controller: controller.scrollController,
                                child: Column(
                                  children: [
                                    chatQuestionAnsView(
                                      isRealTime: controller.isRealTime,
                                      scrollController:
                                          controller.scrollController,
                                      ans: ans,
                                      ansIcon:
                                          (controller.isAssistant ||
                                                  !utils.isValidationEmpty(
                                                    controller.modelType.model,
                                                  ))
                                              ? (!utils.isValidationEmpty(
                                                    controller.modelType.model,
                                                  ))
                                                  ? controller.modelType.logo
                                                  : controller
                                                      .assistantsData
                                                      .assistantImg
                                              : (controller.isTextScan ||
                                                  controller.isRealTime !=
                                                      false)
                                              ? controller.toolModel?.logo ?? ""
                                              : Get.put(
                                                BottomNavigationController(),
                                              ).selectAiModelList.isEmpty
                                              ? null
                                              : Get.put(
                                                    BottomNavigationController(),
                                                  )
                                                  .selectAiModelList[(getStorageData
                                                          .containKey(
                                                            getStorageData
                                                                .selectModelIndex,
                                                          ))
                                                      ? int.parse(
                                                        getStorageData.readString(
                                                              getStorageData
                                                                  .selectModelIndex,
                                                            ) ??
                                                            "0",
                                                      )
                                                      : 0]
                                                  .logo,
                                      onTapAns: () {},
                                    ),
                                    BuilderAny(
                                      builder: (context, any) {
                                        double bottom = 42;
                                        if (controller.mainList.isNotEmpty) {
                                          bottom += 42;
                                        }
                                        return any;
                                        return SliverPadding(
                                          padding: MediaQuery.paddingOf(
                                            context,
                                          ).min(bottom: bottom),
                                          sliver: any,
                                        );
                                      },
                                      any: ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.only(
                                          bottom: _padding,
                                        ),
                                        itemCount: controller.chatItem.length,
                                        itemBuilder: (context, index) {
                                          return chatQuestionAnsView(
                                            scrollController:
                                                controller.scrollController,
                                            // audioFile: controller.chatItem[index].audioFile,
                                            isRealTime: controller.isRealTime,
                                            isUpgrade:
                                                controller
                                                    .chatItem[index]
                                                    .isUpgraded,
                                            isEdit:
                                                (index ==
                                                        (controller
                                                                .chatItem
                                                                .length -
                                                            1))
                                                    ? true
                                                    : false,
                                            onTapEdit: (val) {
                                              Navigator.of(Get.context!)
                                                  .push(
                                                    PageRouteBuilder(
                                                      pageBuilder:
                                                          (context, _, __) =>
                                                              EditHelper(
                                                                text: val,
                                                              ),
                                                      opaque: false,
                                                    ),
                                                  )
                                                  .then((value) {
                                                    controller
                                                        .chatItem[index]
                                                        .audioFile = Rx(null);
                                                    if (value != null &&
                                                        value[HttpUtil.data] !=
                                                            null) {
                                                      controller
                                                              .chatItem[index]
                                                              .suggestionList =
                                                          null;

                                                      ChatApi().apiCalling(
                                                        modelPrompt:
                                                            controller
                                                                .assistantsData
                                                                .backendPrompt,
                                                        isRealTime:
                                                            controller
                                                                .assistantsData
                                                                .assistantId ==
                                                            null,
                                                        type: controller.type,
                                                        textQuestion:
                                                            value[HttpUtil
                                                                .data],
                                                        chatItem:
                                                            controller.chatItem,
                                                        scrollController:
                                                            controller
                                                                .scrollController,
                                                        isRegenerate: true.obs,
                                                        modelName:
                                                            controller
                                                                .aiModelName,
                                                        modelType:
                                                            controller
                                                                .aiModelType,
                                                        modelTitle:
                                                            controller
                                                                .modelTitle,
                                                        assistantId:
                                                            (!Utils().isValidationEmpty(
                                                                  controller
                                                                      .assistantsData
                                                                      .assistantId,
                                                                ))
                                                                ? controller
                                                                    .assistantsData
                                                                    .assistantId
                                                                : "",
                                                      );
                                                    }
                                                  });
                                            },
                                            regenerateResponseOnTap: () {
                                              controller
                                                  .chatItem[index]
                                                  .audioFile = Rx(null);

                                              printAction(
                                                "controller.isRealTimecontroller.isRealTimecontroller.isRealTime ${controller.isRealTime}",
                                              );
                                              controller
                                                  .chatItem[index]
                                                  .suggestionList = null;

                                              ChatApi().apiCalling(
                                                modelPrompt:
                                                    controller
                                                        .assistantsData
                                                        .backendPrompt,
                                                isRealTime:
                                                    controller
                                                        .assistantsData
                                                        .assistantId ==
                                                    null,
                                                textQuestion:
                                                    controller
                                                        .chatItem[index]
                                                        .question ??
                                                    '',
                                                chatItem: controller.chatItem,
                                                scrollController:
                                                    controller.scrollController,
                                                isRegenerate: true.obs,
                                                type: controller.type,
                                                modelName:
                                                    controller.aiModelName,
                                                modelTitle:
                                                    controller.modelTitle,
                                                modelType:
                                                    controller.aiModelType,
                                                assistantId:
                                                    (!Utils().isValidationEmpty(
                                                          controller
                                                              .assistantsData
                                                              .assistantId,
                                                        ))
                                                        ? controller
                                                            .assistantsData
                                                            .assistantId
                                                        : "",
                                              );
                                            },
                                            suggestionList:
                                                controller
                                                    .chatItem[index]
                                                    .suggestionList,
                                            suggestionOnTap: (data) {
                                              ChatApi().apiCalling(
                                                modelPrompt:
                                                    controller
                                                        .assistantsData
                                                        .backendPrompt,
                                                isRealTime:
                                                    controller
                                                        .assistantsData
                                                        .assistantId ==
                                                    null,
                                                textQuestion: data,
                                                type: controller.type,
                                                chatItem: controller.chatItem,
                                                scrollController:
                                                    controller.scrollController,
                                                modelName:
                                                    controller.aiModelName,
                                                modelType:
                                                    controller.aiModelType,
                                                modelTitle:
                                                    controller.modelTitle,
                                                assistantId:
                                                    (!Utils().isValidationEmpty(
                                                          controller
                                                              .assistantsData
                                                              .assistantId,
                                                        ))
                                                        ? controller
                                                            .assistantsData
                                                            .assistantId
                                                        : "",
                                              );
                                            },
                                            ans:
                                                controller
                                                    .chatItem[index]
                                                    .answer
                                                    ?.trim() ??
                                                "",
                                            question:
                                                controller
                                                    .chatItem[index]
                                                    .question ??
                                                '',
                                            ansIcon:
                                                (controller.isAssistant ||
                                                        !utils
                                                            .isValidationEmpty(
                                                              controller
                                                                  .modelType
                                                                  .model,
                                                            ))
                                                    ? (!utils.isValidationEmpty(
                                                          controller
                                                              .modelType
                                                              .model,
                                                        ))
                                                        ? controller
                                                            .modelType
                                                            .logo
                                                        : controller
                                                            .assistantsData
                                                            .assistantImg
                                                    : (controller.isTextScan ||
                                                        controller.isRealTime !=
                                                            false)
                                                    ? controller.toolModel?.logo
                                                    : controller
                                                        .chatItem[index]
                                                        .modelLogo,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ).paddingSymmetric(horizontal: 16.px),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: ClipRRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 10,
                                      sigmaY: 10,
                                    ),

                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        color: AppColors().backgroundColor1
                                            .changeOpacity(.7),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          if ( /*MediaQuery.of(context).viewInsets.bottom == 0 && */ controller
                                              .mainList
                                              .isNotEmpty)
                                            SizedBox(
                                              height: 42.px,
                                              child: ListView.separated(
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    controller.mainList.length,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 16,
                                                ),
                                                separatorBuilder: (
                                                  context,
                                                  index,
                                                ) {
                                                  return SizedBox(width: 5.px);
                                                },
                                                itemBuilder: (context, index) {
                                                  return GestureDetector(
                                                    onTap:
                                                        () => controller
                                                            .textListUpdate(
                                                              index,
                                                            ),
                                                    child: CommonPromptView(
                                                      bgColor:
                                                          (controller
                                                                      .mainListIndex
                                                                      .value ==
                                                                  index)
                                                              ? AppColors
                                                                  .primary
                                                              : AppColors()
                                                                  .ansColor,
                                                      prompt:
                                                          controller
                                                              .mainList[index]
                                                              .title,
                                                      boxShadow: false,
                                                      color:
                                                          (controller
                                                                      .mainListIndex
                                                                      .value ==
                                                                  index)
                                                              ? AppColors.white
                                                              : AppColors()
                                                                  .darkAndWhite,
                                                      prefixIcon: SvgPicture.asset(
                                                        controller
                                                                .mainList[index]
                                                                .image ??
                                                            "",
                                                        height: 16.px,
                                                        width: 16.px,
                                                        color:
                                                            (controller
                                                                        .mainListIndex
                                                                        .value ==
                                                                    index)
                                                                ? AppColors
                                                                    .white
                                                                : null,
                                                      ).marginOnly(right: 4.px),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          // if (MediaQuery.of(context).viewInsets.bottom == 0)
                                          SizedBox(
                                            height: 42.px,
                                            child: ListView.separated(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  controller.textList.length,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 16,
                                              ),
                                              separatorBuilder: (
                                                context,
                                                index,
                                              ) {
                                                return SizedBox(width: 5.px);
                                              },
                                              itemBuilder: (context, index) {
                                                AssistantQuestion data =
                                                    controller.textList[index];
                                                return GestureDetector(
                                                  onTap: () async {
                                                    if (controller.isTextScan &&
                                                        controller
                                                            .newChatController
                                                            .text
                                                            .isNotEmpty) {
                                                      String ss =
                                                          controller
                                                              .newChatController
                                                              .text;
                                                      for (var item
                                                          in controller
                                                              .textList) {
                                                        String s =
                                                            controller
                                                                .newChatController
                                                                .text;
                                                        if (s.contains(
                                                          "\n\n${item.question}",
                                                        )) {
                                                          ss = s.replaceAll(
                                                            "\n\n${item.question}",
                                                            "",
                                                          );
                                                          break;
                                                        } else if (s.contains(
                                                          "${item.question}",
                                                        )) {
                                                          ss = s.replaceAll(
                                                            "${item.question}",
                                                            "",
                                                          );
                                                          break;
                                                        }
                                                      }
                                                      String sss =
                                                          ss.isNotEmpty
                                                              ? "$ss\n\n${data.question}"
                                                              : "${data.question}";
                                                      controller
                                                          .newChatController
                                                          .text = sss;

                                                      // controller.newChatController.selection = TextSelection.collapsed(offset: controller.newChatController.text.length);
                                                      controller
                                                              .newChatController
                                                              .selection =
                                                          TextSelection.fromPosition(
                                                            TextPosition(
                                                              offset:
                                                                  controller
                                                                      .newChatController
                                                                      .text
                                                                      .length,
                                                            ),
                                                          );
                                                      controller
                                                          .newChatFocusNode
                                                          .requestFocus();
                                                    } else {
                                                      // if (controller.newChatFocusNode.hasFocus) {
                                                      //   controller.newChatFocusNode.unfocus();
                                                      // }
                                                      getStorageData
                                                          .saveListening(
                                                            value: false,
                                                          );
                                                      getStorageData.saveSend(
                                                        value: true,
                                                      );

                                                      await Get.put(
                                                        BottomNavigationController(),
                                                      ).speechToText.stop();

                                                      // Future.delayed(const Duration(milliseconds: 100), () {
                                                      printAction(
                                                        "Duration(milliseconds: 100Duration(milliseconds: 100Duration(milliseconds: 100Duration(milliseconds: 100",
                                                      );
                                                      controller
                                                              .newChatController
                                                              .text =
                                                          ((!Utils().isValidationEmpty(
                                                                    controller
                                                                        .assistantsData
                                                                        .assistantId,
                                                                  )) ||
                                                                  controller
                                                                      .isTextScan)
                                                              ? data.question ??
                                                                  ""
                                                              : data.assistantQuestionId ??
                                                                  "";
                                                      controller
                                                          .newChatFocusNode
                                                          .requestFocus();
                                                      Future.delayed(
                                                        const Duration(
                                                          milliseconds: 100,
                                                        ),
                                                        () {
                                                          controller.update();
                                                        },
                                                      );
                                                      // });
                                                    }
                                                  },
                                                  child: CommonPromptView(
                                                    prompt:
                                                        data.shortQuestion ??
                                                        data.question ??
                                                        "",
                                                    bgColor:
                                                        AppColors()
                                                            .whiteAndDark,
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
                        ),
                      );
                    }),
                  ),

                  // if (controller.chatItem.isEmpty && MediaQuery.of(context).viewInsets.bottom == 0)
                  //   AppText(
                  //     "AIChatSY: Your personal AI genius.",
                  //     textAlign: TextAlign.center,
                  //   ).paddingSymmetric(horizontal: 10.w),
                  CommonTextField(
                    // color: AppColors().bgColor3,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    maxLine: 4,
                    minLine: 1,
                    focusNode: controller.newChatFocusNode,
                    // borderColor: AppColors.transparent,
                    controller: controller.newChatController,
                    hintText: "Ask anything...",
                    onStop: () async {
                      if (controller.chatItem.length == 1 ||
                          (controller.chatItem.length % 3 == 0)) {
                        Global.showTheReview();
                      }
                      ChatApi.stopStreaming();
                      await modelsHistoryAPI(
                        controller.chatItem,
                        controller.modelType.model.toString(),
                        controller.modelTitle,
                        assistantId:
                            (!Utils().isValidationEmpty(
                                  controller.assistantsData.assistantId,
                                ))
                                ? controller.assistantsData.assistantId
                                : "",
                        type: controller.type,
                      );
                    },
                    prefixIcon: AddWidget(
                      visible: controller.menu.value,
                      onTap: () async {
                        addOtherPromptsOnTap(
                          menu: controller.menu,
                          context: context,
                        );

                        // Map data = await addOtherPronts();
                        // if (data != {}) {
                        //   if (data.containsKey(HttpUtil.imageText)) {
                        //     controller.newChatController.text = data[HttpUtil.imageText];
                        //     getStorageData.saveSend(value: true);
                        //     printAction("readSendreadSendreadSendreadSend ${getStorageData.readSend()}");
                        //     if (controller.newChatFocusNode.hasFocus) {
                        //       controller.newChatFocusNode.unfocus();
                        //     }
                        //
                        //     await Get.put(BottomNavigationController()).speechToText.stop();
                        //
                        //     Future.delayed(const Duration(milliseconds: 100), () {
                        //       controller.newChatFocusNode.requestFocus();
                        //     });
                        //     controller.update();
                        //   } else if (data[HttpUtil.type] == Languages.of(context)!.aiAssistants || data[HttpUtil.type] == Languages.of(context)!.templates) {
                        //     controller.apiCall.value = data[HttpUtil.type] == Languages.of(context)!.aiAssistants ? 1 : 2;
                        //     Get.back();
                        //   }
                        // }
                      },
                    ),
                    isMic: true,
                    onSend: () {
                      String text = controller.newChatController.text.trim();
                      controller.newChatController.clear();

                      ChatApi().apiCalling(
                        modelPrompt: controller.assistantsData.backendPrompt,
                        isRealTime:
                            controller.assistantsData.assistantId == null,
                        textQuestion: text,
                        type: controller.type,
                        chatItem: controller.chatItem,
                        scrollController: controller.scrollController,
                        modelName: controller.aiModelName,
                        modelType: controller.aiModelType,
                        modelTitle: controller.modelTitle,
                        assistantId:
                            (!Utils().isValidationEmpty(
                                  controller.assistantsData.assistantId,
                                ))
                                ? controller.assistantsData.assistantId
                                : "",
                      );
                    },
                    // suffixIconConstraints: const Box Constraints(),
                  ).paddingSymmetric(horizontal: 16.px),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}

class MenuView extends ImplicitlyAnimatedWidget {
  const MenuView({
    super.key,
    required this.backGroundWidget,
    required this.menuWidget,
    super.duration = Durations.medium2,
    required this.visible,
  });

  final Widget menuWidget;

  final Widget backGroundWidget;

  final bool visible;

  @override
  AnimatedWidgetBaseState<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends AnimatedWidgetBaseState<MenuView> {
  @override
  Widget build(BuildContext context) {
    var animSize = _anim!.animate(animation);
    return Stack(
      fit: StackFit.expand,
      children: [
        GestureDetector(
          onTap: () {
            if (!widget.visible) return;
            Get.back();
          },
          child: AbsorbPointer(
            absorbing: animSize.value > 0,
            child: IgnorePointer(
              ignoring: animSize.value > 0,
              child: widget.backGroundWidget,
            ),
          ),
        ),
        Visibility(
          visible: animSize.value > 0,
          child: Center(
            child: ClipRRect(
              clipBehavior: Clip.none,
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: (10.0 * animSize.value),
                  sigmaY: (10.0 * animSize.value),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: FadeTransition(
                    opacity: animSize,
                    child: Transform.scale(
                      origin: _slide!.evaluate(animation),
                      scale: _scale!.evaluate(
                        CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOutBack,
                        ),
                      ),
                      alignment: const Alignment(-.8, 1),
                      child: widget.menuWidget,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _anim =
        visitor(
              _anim,
              widget.visible ? 1.0 : 0.0,
              (targetValue) => Tween<double>(begin: targetValue),
            )
            as Tween<double>?;
    _scale =
        visitor(
              _scale,
              widget.visible ? 1.0 : 0.2,
              (targetValue) => Tween<double>(begin: targetValue),
            )
            as Tween<double>?;
    _slide =
        visitor(
              _slide,
              widget.visible ? Offset.zero : const Offset(20, 50),
              (targetValue) => Tween<Offset>(begin: targetValue),
            )
            as Tween<Offset>?;
  }

  Tween<double>? _anim;
  Tween<double>? _scale;
  Tween<Offset>? _slide;
}

class AddWidget extends ImplicitlyAnimatedWidget {
  const AddWidget({
    super.key,
    required this.visible,
    super.duration = Durations.short4,
    required this.onTap,
  });

  final Future<Null> Function() onTap;

  final bool visible;

  @override
  AnimatedWidgetBaseState<AddWidget> createState() => _AddWidgetState();
}

class _AddWidgetState extends AnimatedWidgetBaseState<AddWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ClipOval(
        child: ColoredBox(
          color: Colors.transparent,
          child: Center(
            child: Transform.rotate(
              alignment: Alignment.center,
              angle: (45 * (3.14159265359 / 180)) * _anim!.evaluate(animation),
              child: Image.asset(
                ImagePath.addCircle,
                height: 20.px,
                width: 20.px,
                color: AppColors().grayMix,
              ),
            ).paddingOnly(right: 10.px),
          ),
        ),
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _color =
        visitor(
              _color,
              widget.visible ? Colors.black : Colors.white,
              (targetValue) => ColorTween(begin: targetValue),
            )
            as ColorTween?;
    _anim =
        visitor(
              _anim,
              widget.visible ? 1.0 : 0.0,
              (targetValue) => Tween<double>(begin: targetValue),
            )
            as Tween<double>?;
  }

  Tween<double>? _anim;

  ColorTween? _color;
}

class BuilderAny<T> extends StatelessWidget {
  const BuilderAny({super.key, required this.any, required this.builder});

  final T any;

  final Widget Function(BuildContext context, T any) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, any);
  }
}
