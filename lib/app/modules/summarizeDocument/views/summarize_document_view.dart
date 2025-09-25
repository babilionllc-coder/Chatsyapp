import 'dart:ui';

import 'package:chatsy/app/common_widget/comman_text_field.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/modules/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:chatsy/app/modules/home/controllers/user_profile_model.dart';
import 'package:chatsy/app/modules/home/views/home_view.dart';
import 'package:chatsy/app/modules/newChat/controllers/new_chat_controller.dart';
import 'package:chatsy/extension.dart';

import '../../../common_widget/common_prompt_view.dart';
import '../../../common_widget/common_question_view.dart';
import '../../../common_widget/common_screen.dart';
import '../../../helper/Global.dart';
import '../../../helper/image_path.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../chat_gpt/controllers/chat_gpt_controller.dart';
import '../../newChat/component/add_other_prompts_view.dart';
import '../../newChat/component/edit_helper.dart';
import '../../newChat/views/new_chat_view.dart';
import '../controllers/summarize_document_controller.dart';

class SummarizeDocumentView extends GetView<SummarizeDocumentController> {
  const SummarizeDocumentView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SummarizeDocumentController>(
      init: SummarizeDocumentController(),
      builder: (controller) {
        return CommonScreen(
          lineUpScrollBtn: 0.78,
          scrollController: controller.scrollController,
          leadingOnTap: () async {
            Get.back();
          },
          backgroundColor: AppColors().backgroundColor1,
          title: controller.toolModel?.name ?? "",
          titleView: infoView(
            onTap: () {
              Get.put(
                ChatGptController(),
              ).uploadAskFirstBottomSheet(controller.toolModel ?? ToolsModel(), onTap: () {});
            },
          ),
          actions: [
            Get.put(BottomNavigationController()).commonResponseToneBottomBar(),
            LimitAndHistoryButtonView(),
          ],
          body: Obx(() {
            return Column(
              children: [
                Expanded(
                  child: MenuView(
                    visible: controller.menu.value,
                    menuWidget: AddOtherPromptsView(apiCall: controller.apiCall),
                    backGroundWidget: Stack(
                      children: [
                        ListView(
                          controller: controller.scrollController,
                          children: [
                            CommonQuestionView(
                              questionIcon: controller.toolModel?.logo,
                              question:
                                  "Hello! how i can help you with this PDF? I can summarize, rewrite and even translate it for you and if you have any questions about is  content just let me know. So, what do you want me to do next?",
                              answerImageUrl: ImagePath.icDocument,
                              ansTitle: controller.fileName.value,
                              ansSubTitle: controller.sizeInMb.value,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.only(bottom: 42),
                              itemCount: controller.chatItem.length,
                              itemBuilder: (context, index) {
                                return chatQuestionAnsView(
                                  suggestionList: controller.chatItem[index].suggestionList,
                                  suggestionOnTap: (data) {
                                    ChatApi().apiCalling(
                                      textQuestion: data,
                                      chatItem: controller.chatItem,
                                      scrollController: controller.scrollController,
                                      documentText: controller.documentText,
                                      modelTitle: "Summarize Doc",
                                      fileName: controller.fileName.value,
                                      fileSize: controller.sizeInMb.toString(),
                                    );
                                  },
                                  scrollController: controller.scrollController,
                                  isUpgrade: controller.chatItem[index].isUpgraded,
                                  isEdit:
                                      (index == (controller.chatItem.length - 1)) ? true : false,
                                  onTapEdit: (val) {
                                    Navigator.of(Get.context!)
                                        .push(
                                          PageRouteBuilder(
                                            pageBuilder: (context, _, __) => EditHelper(text: val),
                                            opaque: false,
                                          ),
                                        )
                                        .then((value) {
                                          if (value != null) {
                                            ChatApi().apiCalling(
                                              textQuestion: value[HttpUtil.data],
                                              chatItem: controller.chatItem,
                                              scrollController: controller.scrollController,
                                              documentText: controller.documentText,
                                              isRegenerate: true.obs,
                                              modelTitle: "Summarize Doc",
                                              fileName: controller.fileName.value,
                                              fileSize: controller.sizeInMb.toString(),
                                            );
                                          }
                                        });
                                  },
                                  regenerateResponseOnTap: () {
                                    ChatApi().apiCalling(
                                      textQuestion: controller.chatItem[index].question ?? '',
                                      chatItem: controller.chatItem,
                                      scrollController: controller.scrollController,
                                      documentText: controller.documentText,
                                      isRegenerate: true.obs,
                                      modelTitle: "Summarize Doc",
                                      fileName: controller.fileName.value,
                                      fileSize: controller.sizeInMb.toString(),
                                    );
                                  },
                                  ans: controller.chatItem[index].answer?.trim() ?? "",
                                  question: controller.chatItem[index].question ?? '',
                                  ansIcon: controller.toolModel?.logo,
                                  isBorder: false,
                                );
                              },
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 16.px),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: SizedBox(
                            height: 42.px,
                            child: ClipRRect(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: AppColors().backgroundColor1.changeOpacity(.7),
                                  ),
                                  child: ListView.builder(
                                    itemCount: controller.promptList.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () async {
                                          await Get.put(
                                            BottomNavigationController(),
                                          ).speechToText.stop();
                                          getStorageData.saveSend(value: true);
                                          getStorageData.saveListening(value: false);

                                          Future.delayed(const Duration(milliseconds: 100), () {
                                            controller.newChatController.text =
                                                controller.promptList[index];
                                            controller.newChatFocusNode.requestFocus();
                                            controller.update();
                                          });
                                        },
                                        child: CommonPromptView(
                                          bgColor: AppColors().whiteAndDark,
                                          boxShadow: true,
                                          prompt: controller.promptList[index],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // if (MediaQuery.of(context).viewInsets.bottom == 0)
                CommonTextField(
                  // color: AppColors().bgColor3,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLine: 4,
                  minLine: 1,
                  prefixIcon: AddWidget(
                    visible: controller.menu.value,
                    onTap: () async {
                      addOtherPromptsOnTap(menu: controller.menu, context: context);

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

                  focusNode: controller.newChatFocusNode,
                  controller: controller.newChatController,
                  hintText: "Ask anything...",
                  isMic: true,
                  onStop: () async {
                    if (controller.chatItem.length == 1 || (controller.chatItem.length % 3 == 0)) {
                      Global.showTheReview();
                    }
                    ChatApi.stopStreaming();
                    await modelsHistoryAPI(
                      controller.chatItem,
                      "",
                      "Summarize Doc",
                      fileName: controller.fileName.value,
                      fileText: controller.documentText,
                      fileSize: controller.sizeInMb.value,
                    );
                  },
                  onSend: () {
                    String text = controller.newChatController.text.trim();
                    controller.newChatController.clear();

                    ChatApi().apiCalling(
                      textQuestion: text,
                      chatItem: controller.chatItem,
                      scrollController: controller.scrollController,
                      documentText: controller.documentText,
                      modelTitle: "Summarize Doc",
                      fileName: controller.fileName.value,
                      fileSize: controller.sizeInMb.toString(),
                    );
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
