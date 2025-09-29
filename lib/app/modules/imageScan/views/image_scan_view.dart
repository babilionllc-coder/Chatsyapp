import 'dart:io';
import 'dart:ui';

import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/modules/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:chatsy/app/modules/bottom_navigation/widget/popup_menu.dart';
import 'package:chatsy/app/modules/home/controllers/user_profile_model.dart';
import 'package:chatsy/app/modules/newChat/models/phm_id_model.dart';
import 'package:chatsy/app/routes/app_pages.dart';
import 'package:chatsy/extension.dart';

import '../../../Localization/local_language.dart';
import '../../../common_widget/comman_text_field.dart';
import '../../../common_widget/common_prompt_view.dart';
import '../../../common_widget/common_screen.dart';
import '../../../helper/image_path.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../chat_gpt/controllers/chat_gpt_controller.dart';
import '../../home/views/home_view.dart';
import '../../newChat/component/edit_helper.dart';
import '../../newChat/controllers/new_chat_controller.dart';
import '../controllers/image_scan_controller.dart';

class ImageScanView extends GetView<ImageScanController> {
  const ImageScanView({super.key});

  static Future<T?>? toNamed<T>({
    List<PhmIdModelData>? askQuestionData,
    ToolsModel? model,
    String? promptId,
    String? imagePath,
    String? promptQuestion,
  }) {
    return Get.toNamed(
      Routes.IMAGE_SCAN,
      arguments: (
        askQuestionData: askQuestionData,
        toolModel: model,
        promptId: promptId,
        imagePath: imagePath,
        promptQuestion: promptQuestion,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageScanController>(
      init: ImageScanController(),
      builder: (controller) {
        return CommonScreen(
          lineUpScrollBtn: 0.78,
          scrollController: controller.scrollController,
          leadingOnTap: () async {
            Get.back();
          },
          backgroundColor: AppColors().backgroundColor1,
          title:
              controller.toolModel?.name ??
              (utils.isValidationEmpty(controller.promptId.value) ? "" : null),
          titleView:
              (controller.toolModel != null)
                  ? infoView(
                    onTap: () {
                      Get.put(ChatGptController()).imageScanFirstBottomSheet(
                        controller.toolModel ?? ToolsModel(),
                        onTap: () {},
                      );
                    },
                  )
                  : PopUpMenu(data: null),
          actions: [
            Get.put(BottomNavigationController()).commonResponseToneBottomBar(),
            LimitAndHistoryButtonView(),
          ],
          body: Obx(() {
            return Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      NotificationListener<ScrollMetricsNotification>(
                        onNotification: (notification) {
                          if (notification.metrics.extentAfter > 12) {
                            controller.scrollController.animateTo(
                              controller
                                  .scrollController
                                  .position
                                  .maxScrollExtent,
                              duration: const Duration(milliseconds: 100),
                              curve: Curves.linear,
                            );
                          }
                          return true;
                        },
                        child: SingleChildScrollView(
                          controller: controller.scrollController,
                          padding: EdgeInsets.only(bottom: 42),
                          child: ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: [
                              if (utils.isValidationEmpty(
                                controller.promptId.value,
                              ))
                                chatQuestionAnsView(
                                  ansIcon: controller.toolModel?.logo ?? "",
                                  ans:
                                      "Hello! how i can help you with this Image?",
                                  onTapAns: () {},
                                ),
                              ListView.builder(
                                shrinkWrap: true,
                                primary: false,
                                padding: EdgeInsets.only(bottom: 10.px),
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.askQuestionData.length,
                                itemBuilder: (context, index) {
                                  return chatQuestionAnsView(
                                    scrollController:
                                        controller.scrollController,
                                    isUpgrade:
                                        controller
                                            .askQuestionData[index]
                                            .isUpgraded,
                                    isEdit:
                                        (index ==
                                                (controller
                                                        .askQuestionData
                                                        .length -
                                                    1))
                                            ? true
                                            : false,
                                    suggestionList: controller.newQuestionList,
                                    onFinished: () {
                                      printAction("onFinished");
                                      controller.newQuestionList = RxList(
                                        controller
                                                .askQuestionData[index]
                                                .newQuestionList ??
                                            [],
                                      );
                                      printAction(
                                        "controller.newQuestionList ${controller.newQuestionList.length}",
                                      );
                                      controller.update();
                                    },
                                    suggestionOnTap: (data) async {
                                      if (controller.askQuestionData.isEmpty &&
                                          utils.isValidationEmpty(
                                            controller.imagePath.value,
                                          )) {
                                        utils.showToast(
                                          message:
                                              Languages.of(
                                                context,
                                              )!.pleaseEnterImage,
                                        );
                                      } else {
                                        if (!controller.isAPICall.value) {
                                          controller.photoIdentificationAPI(
                                            data,
                                            false,
                                            controller.imagePath.value,
                                          );
                                        }
                                      }
                                    },
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
                                              if (!controller.isAPICall.value) {
                                                controller
                                                    .photoIdentificationAPI(
                                                      value[HttpUtil.data],
                                                      true,
                                                      controller
                                                          .imagePath
                                                          .value,
                                                    );
                                              }
                                            }
                                          });
                                    },
                                    regenerateResponseOnTap: () {
                                      if (!controller.isAPICall.value) {
                                        controller.photoIdentificationAPI(
                                          controller
                                              .askQuestionData[index]
                                              .question
                                              .toString(),
                                          true,
                                          controller.imagePath.value,
                                        );
                                      }
                                    },
                                    ans:
                                        controller.askQuestionData[index].answer
                                            ?.trim() ??
                                        ((controller.isAPICall.value)
                                            ? "Analysing image..."
                                            : ""),
                                    question:
                                        controller
                                            .askQuestionData[index]
                                            .question ??
                                        '',
                                    questionImage:
                                        controller.askQuestionData[index].img ??
                                        '',
                                    ansIcon: controller.toolModel?.logo,
                                    isBorder:
                                        (!utils.isValidationEmpty(
                                          controller.promptId.value,
                                        )),
                                    isImageScan:
                                        (utils.isValidationEmpty(
                                              controller
                                                  .askQuestionData[index]
                                                  .answer
                                                  ?.trim(),
                                            ) &&
                                            ((controller
                                                        .askQuestionData
                                                        .length -
                                                    1) ==
                                                index)),
                                    //  isAnimatedText: (controller.askQuestionData.length - 1 == index) && (controller.askQuestionData[index].answer != null) ? controller.endAnimFinish : null,
                                    isAnimatedText:
                                        ((controller.askQuestionData.length -
                                                        1 ==
                                                    index) &&
                                                (controller
                                                        .askQuestionData[index]
                                                        .answer !=
                                                    null) &&
                                                controller.isAnimation.value)
                                            ? true
                                            : false,
                                  );
                                },
                              ),
                            ],
                          ).paddingSymmetric(horizontal: 16.px),
                        ),
                      ),
                      if ( /*MediaQuery.of(context).viewInsets.bottom == 0 && */ (utils
                          .isValidationEmpty(controller.promptId.value)))
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  color: AppColors().backgroundColor1
                                      .changeOpacity(.7),
                                ),
                                child: SizedBox(
                                  height: 42.px,
                                  child: ListView.builder(
                                    itemCount: controller.promptList.length,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      return GestureDetector(
                                        onTap: () async {
                                          // if (controller.newChatFocusNode.hasFocus) {
                                          //   controller.newChatFocusNode.unfocus();
                                          // }

                                          await Get.put(
                                            BottomNavigationController(),
                                          ).speechToText.stop();
                                          getStorageData.saveListening(
                                            value: false,
                                          );
                                          getStorageData.saveSend(value: true);
                                          Future.delayed(
                                            const Duration(milliseconds: 100),
                                            () {
                                              controller
                                                      .newChatController
                                                      .text =
                                                  controller.promptList[index];
                                              controller.newChatFocusNode
                                                  .requestFocus();
                                              controller.update();
                                            },
                                          );
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

                CommonTextField(
                  // color: AppColors().bgColor3,
                  pickedImage: controller.imagePath,
                  isClose: true.obs,
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  maxLine: 4,
                  minLine: 1,
                  focusNode: controller.newChatFocusNode,

                  // borderColor: AppColors.transparent,
                  controller: controller.newChatController,
                  hintText: "Ask anything...",
                  isMic: true,
                  prefixIcon: GestureDetector(
                    onTap: () async {
                      File? imagePath = await imagePickerBottomSheet(
                        isSub: true,
                      );
                      if (imagePath?.path != null) {
                        controller.imagePath.value = imagePath?.path ?? "";
                        printAction(
                          "-=-=- imagePath.value ${controller.imagePath.value}",
                        );
                      }
                    },
                    child: Image.asset(
                      ImagePath.addCircle,
                      height: 20.px,
                      width: 20.px,
                      color: AppColors().grayMix,
                    ).paddingOnly(right: 10.px, bottom: 10.px, top: 10.px),
                  ),
                  onSend: () {
                    if (controller.askQuestionData.isEmpty &&
                        utils.isValidationEmpty(controller.imagePath.value)) {
                      utils.showToast(
                        message: Languages.of(context)!.pleaseEnterImage,
                      );
                    } else {
                      controller.newChatController.text.trim();
                      if (!controller.isAPICall.value) {
                        controller.photoIdentificationAPI(
                          controller.newChatController.text.trim(),
                          false,
                          controller.imagePath.value,
                        );
                      }
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
