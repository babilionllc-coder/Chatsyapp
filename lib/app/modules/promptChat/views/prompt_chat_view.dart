import 'package:chatsy/app/common_widget/comman_text_field.dart';
import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/modules/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:chatsy/app/modules/bottom_navigation/widget/popup_menu.dart';

import '../../../helper/Global.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../newChat/component/add_other_prompts_view.dart';
import '../../newChat/component/edit_helper.dart';
import '../../newChat/controllers/new_chat_controller.dart';
import '../../newChat/views/new_chat_view.dart';
import '../controllers/prompt_chat_controller.dart';

class PromptChatView extends GetView<PromptChatController> {
  const PromptChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PromptChatController>(
      init: PromptChatController(),
      builder: (controller) {
        return Obx(() {
          return CommonScreen(
            lineUpScrollBtn: 0.9,
            scrollController: controller.scrollController,
            // title: Languages.of(context)!.promptChat,
            titleView: PopUpMenu(data: controller.modelTypeForDropDown),
            actions: [
              Get.put(
                BottomNavigationController(),
              ).commonResponseToneBottomBar(),
              LimitAndHistoryButtonView(),
            ],
            body: Column(
              children: [
                Expanded(
                  child: MenuView(
                    visible: controller.menu.value,
                    menuWidget: AddOtherPromptsView(
                      apiCall: controller.apiCall,
                      // onTapForTemplate: () {
                      //   Get.back();
                      // },
                      // onTapForAiAssistants: () {
                      //   Get.back();
                      // },
                    ),
                    backGroundWidget: SingleChildScrollView(
                      controller: controller.scrollController,
                      physics: const BouncingScrollPhysics(),
                      child: ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.chatItem.length,
                        itemBuilder: (context, index) {
                          return chatQuestionAnsView(
                            suggestionList:
                                controller.chatItem[index].suggestionList,
                            suggestionOnTap: (data) {
                              ChatApi().apiCalling(
                                textQuestion: data,
                                chatItem: controller.chatItem,
                                scrollController: controller.scrollController,
                                promptId: controller.promptId,
                                modelTitle: controller.promptName,
                                modelName:
                                    controller
                                        .modelTypeForDropDown
                                        ?.value
                                        ?.model,
                                modelType:
                                    controller
                                        .modelTypeForDropDown
                                        ?.value
                                        ?.modelType,
                              );
                            },
                            scrollController: controller.scrollController,
                            isUpgrade: controller.chatItem[index].isUpgraded,
                            isEdit:
                                (index == (controller.chatItem.length - 1))
                                    ? true
                                    : false,
                            onTapEdit: (val) {
                              Navigator.of(Get.context!)
                                  .push(
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, _, __) =>
                                              EditHelper(text: val),
                                      opaque: false,
                                    ),
                                  )
                                  .then((value) {
                                    if (value != null &&
                                        value[HttpUtil.data] != null) {
                                      ChatApi().apiCalling(
                                        textQuestion: value[HttpUtil.data],
                                        chatItem: controller.chatItem,
                                        scrollController:
                                            controller.scrollController,
                                        isRegenerate: true.obs,
                                        promptId: controller.promptId,
                                        modelTitle: controller.promptName,
                                        modelName:
                                            controller
                                                .modelTypeForDropDown
                                                ?.value
                                                ?.model,
                                        modelType:
                                            controller
                                                .modelTypeForDropDown
                                                ?.value
                                                ?.modelType,
                                      );
                                    }
                                  });
                            },
                            regenerateResponseOnTap: () {
                              ChatApi().apiCalling(
                                textQuestion:
                                    controller.chatItem[index].question ?? '',
                                chatItem: controller.chatItem,
                                scrollController: controller.scrollController,
                                isRegenerate: true.obs,
                                promptId: controller.promptId,
                                modelTitle: controller.promptName,
                                modelName:
                                    controller
                                        .modelTypeForDropDown
                                        ?.value
                                        ?.model,
                                modelType:
                                    controller
                                        .modelTypeForDropDown
                                        ?.value
                                        ?.modelType,
                              );
                            },
                            ans:
                                controller.chatItem[index].answer?.trim() ?? "",
                            question: controller.chatItem[index].question ?? '',
                          );
                        },
                      ),
                    ),
                  ),
                ),
                CommonTextField(
                  // color: AppColors().bgColor3,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLine: 4,
                  minLine: 1,
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
                      //   }
                      // }
                    },
                  ),
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
                      null,
                      controller.promptName,
                    );
                  },
                  isMic: true,
                  onSend: () {
                    String text = controller.newChatController.text.trim();
                    controller.newChatController.clear();

                    ChatApi().apiCalling(
                      textQuestion: text,
                      chatItem: controller.chatItem,
                      scrollController: controller.scrollController,
                      promptId: controller.promptId,
                      modelTitle: controller.promptName,
                      modelName: controller.modelTypeForDropDown?.value?.model,
                      modelType:
                          controller.modelTypeForDropDown?.value?.modelType,
                    );
                  },
                  // suffixIconConstraints: const Box Constraints(),
                ),
              ],
            ).paddingSymmetric(horizontal: 16.px),
          );
        });
      },
    );
  }
}
