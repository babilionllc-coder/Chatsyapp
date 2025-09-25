import 'package:chatsy/app/helper/Global.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/helper/image_path.dart';
import 'package:chatsy/app/modules/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:chatsy/app/modules/bottom_navigation/widget/popup_menu.dart';
import 'package:chatsy/extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common_widget/comman_text_field.dart';
import '../../../common_widget/common_screen.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../chat_gpt/views/chat_gpt_view.dart';
import '../../newChat/component/edit_helper.dart';
import '../../newChat/controllers/new_chat_controller.dart';
import '../controllers/translate_controller.dart';

class TranslateView extends GetView<TranslateController> {
  const TranslateView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TranslateController>(
      init: TranslateController(),
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            utils.hideKeyboard();
          },
          child: CommonScreen(
            // title: controller.prompts.name,
            titleView: PopUpMenu(data: null),
            actions: [
              Get.put(BottomNavigationController()).commonResponseToneBottomBar(),
              LimitAndHistoryButtonView(),
            ],
            body: Obx(() {
              return Column(
                children: [
                  Expanded(
                    child: NotificationListener<ScrollMetricsNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.extentAfter > 12 &&
                            notification.metrics.axis == Axis.vertical) {
                          controller.scrollController.animateTo(
                            controller.scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.linear,
                          );
                        }
                        return true;
                      },
                      child: SingleChildScrollView(
                        controller: controller.scrollController,
                        child: ListView(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            CachedNetworkImage(
                              height: 80.px,
                              width: 80.px,
                              imageUrl: controller.prompts.img ?? "",
                              progressIndicatorBuilder:
                                  (context, url, progress) =>
                                      progressIndicatorView(borderRadius: 12.px),
                              errorWidget:
                                  (context, url, uri) => errorWidgetView().paddingAll(8.px),
                            ),
                            AppText(
                              controller.prompts.description ?? "",
                              textAlign: TextAlign.center,
                            ).marginOnly(top: 12.px),
                            ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: controller.chatItem.length,
                              itemBuilder: (context, index) {
                                return chatQuestionAnsView(
                                  suggestionList: controller.chatItem[index].suggestionList,
                                  suggestionOnTap: (data) {
                                    String ss =
                                        "Translate the following text from ${controller.fromLanguage.value?.code ?? ""} to ${controller.toLanguage.value?.code ?? ""}.\n\nText:$data";

                                    ChatApi().apiCalling(
                                      textQuestion: ss,
                                      notAddPrompt: true,
                                      // type: controller.type,
                                      chatItem: controller.chatItem,
                                      scrollController: controller.scrollController,
                                      promptId: controller.prompts.promptId,
                                      modelTitle: controller.prompts.name,
                                      // modelName: controller.modelName,
                                      // modelTitle: controller.modelTitle,
                                      // assistantId: (!Utils().isValidationEmpty(controller.assistantsData.assistantId)) ? controller.assistantsData.assistantId : "",
                                    );
                                  },
                                  question: controller.chatItem[index].question,
                                  ans: controller.chatItem[index].answer,
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
                                          if (value != null && value[HttpUtil.data] != null) {
                                            ChatApi().apiCalling(
                                              textQuestion: value[HttpUtil.data],
                                              chatItem: controller.chatItem,
                                              scrollController: controller.scrollController,
                                              isRegenerate: true.obs,
                                              notAddPrompt: true,
                                              promptId: controller.prompts.promptId,
                                              modelTitle: controller.prompts.name,
                                            );
                                          }
                                        });
                                  },
                                  regenerateResponseOnTap: () {
                                    ChatApi().apiCalling(
                                      textQuestion: controller.chatItem[index].question ?? '',
                                      chatItem: controller.chatItem,
                                      scrollController: controller.scrollController,
                                      notAddPrompt: true,
                                      isRegenerate: true.obs,
                                      promptId: controller.prompts.promptId,
                                      modelTitle: controller.prompts.name,
                                    );
                                  },
                                );
                              },
                            ).marginSymmetric(horizontal: 16.px),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // English Button
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.isFromLangSelect.value = true;
                            controller.languageSelect();
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10.px, 10.px, 10.px, 7.px),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors().darkAndWhite.changeOpacity(0.2), // Border color
                                width: 1.px, // Border width
                              ),
                              borderRadius: BorderRadius.circular(30.0), // Rounded corners
                            ),
                            child: AppText(
                              textAlign: TextAlign.center,
                              controller.fromLanguage.value?.name ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 14.px,
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          Language? from = controller.fromLanguage.value;
                          Language? to = controller.toLanguage.value;
                          controller.fromLanguage.value = to;
                          controller.toLanguage.value = from;
                        },
                        child: SvgPicture.asset(
                          ImagePath.icLanguageChange,
                          height: 20.px,
                          width: 20.px,
                          color: AppColors().darkAndWhite,
                        ).marginSymmetric(horizontal: 11.px),
                      ),

                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.isFromLangSelect.value = false;
                            controller.languageSelect();
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10.px, 10.px, 10.px, 7.px),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors().darkAndWhite.changeOpacity(0.2), // Border color
                                width: 1.px, // Border width
                              ),
                              borderRadius: BorderRadius.circular(30.0), // Rounded corners
                            ),
                            child: AppText(
                              textAlign: TextAlign.center,
                              controller.toLanguage.value?.name ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              fontSize: 14.px,
                            ),
                          ),
                        ),
                      ),
                      // Spanish Button
                    ],
                  ).marginOnly(left: 16.px, right: 16.px, bottom: 10.px),

                  //  if (MediaQuery.of(context).viewInsets.bottom == 0)
                  CommonTextField(
                    // color: AppColors().bgColor3,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    focusNode: controller.newChatFocusNode,
                    maxLine: 4,
                    minLine: 1,
                    controller: controller.newChatController,
                    hintText: "Ask anything...",
                    isMic: true,
                    onStop: () async {
                      if (controller.chatItem.length == 1 ||
                          (controller.chatItem.length % 3 == 0)) {
                        Global.showTheReview();
                      }
                      ChatApi.stopStreaming();
                      modelsHistoryAPI(
                        controller.chatItem,
                        null,
                        controller.prompts.name,
                        promptId: controller.prompts.promptId,
                      );
                      // await modelsHistoryAPI(controller.chatItem, "", "Summarize Web", fileName: controller.urlQuestion, fileText: controller.documentText);
                    },
                    onSend: () {
                      String text = controller.newChatController.text.trim();
                      controller.newChatController.clear();
                      String ss =
                          "Translate the following text from ${controller.fromLanguage.value?.code ?? ""} to ${controller.toLanguage.value?.code ?? ""}.\n\nText:$text";

                      ChatApi().apiCalling(
                        textQuestion: ss,
                        notAddPrompt: true,
                        // type: controller.type,
                        chatItem: controller.chatItem,
                        scrollController: controller.scrollController,
                        promptId: controller.prompts.promptId,
                        modelTitle: controller.prompts.name,
                        // modelName: controller.modelName,
                        // modelTitle: controller.modelTitle,
                        // assistantId: (!Utils().isValidationEmpty(controller.assistantsData.assistantId)) ? controller.assistantsData.assistantId : "",
                      );
                    },
                    // suffixIconConstraints: const BoxConstraints(),
                  ).paddingSymmetric(horizontal: 16.px),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}
