import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/modules/imageScan/views/image_scan_view.dart';
import 'package:chatsy/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../Localization/local_language.dart';
import '../../../common_widget/comman_text_field.dart';
import '../../../common_widget/common_button.dart';
import '../../../common_widget/common_container.dart';
import '../../../common_widget/common_drop_down.dart';
import '../../../common_widget/common_screen.dart';
import '../../../helper/font_family.dart';
import '../../../helper/image_path.dart';
import '../../../routes/app_pages.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../chat_gpt/views/chat_gpt_view.dart';
import '../../home/controllers/all_prompt_model.dart';
import '../../promptChat/controllers/prompt_chat_controller.dart';
import '../controllers/template_page_controller.dart';

class TemplatePageView extends GetView<TemplatePageController> {
  const TemplatePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TemplatePageController>(
      init: TemplatePageController(),
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            utils.hideKeyboard();
          },
          child: CommonScreen(
            title: controller.prompts.name,
            body: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16.px),
              children: [
                ListView.separated(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.prompts.formFields!.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10.px);
                  },
                  itemBuilder: (context, index) {
                    FormFields formFields =
                        controller.prompts.formFields![index];
                    printAction("formFields.value ${formFields.value}");
                    printAction(
                      "formFields.value ${index == (controller.prompts.formFields!.length - 1)}",
                    );
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(
                          formFields.name ?? "",
                          fontSize: 16.px,
                          fontFamily: FontFamily.helveticaBold,
                        ),
                        SizedBox(height: 5.px),
                        (formFields.fieldType == "text")
                            ? CommonTextField(
                              maxLine: 3,
                              minLine: 1,
                              isBorder: true,
                              borderRadius: BorderRadius.circular(10.px),
                              padding: EdgeInsets.symmetric(
                                vertical: 12.px,
                                horizontal: 10.px,
                              ),
                              color: AppColors().conColor2,
                              hintText: formFields.placeholder,

                              controller: TextEditingController(
                                text: formFields.value,
                              ),
                              onChanged: (val) {
                                if (val.isNotEmpty) {
                                  formFields.value = val;
                                } else {
                                  formFields.value = "";
                                }
                              },
                              textInputAction:
                                  index ==
                                          (controller
                                                  .prompts
                                                  .formFields!
                                                  .length -
                                              1)
                                      ? TextInputAction.done
                                      : TextInputAction.next,
                              // hintText: formFields.name,
                              // color: isLight ? AppColors.transparent : AppColors.lightBlack,
                              borderColor: AppColors().darkAndWhite
                                  .changeOpacity(0.1),
                              cursorColor: AppColors().darkAndWhite,
                              hintColor: AppColors.gray,
                            )
                            : (formFields.fieldType == "dropdown")
                            ? CommonDropDownButton(
                              itemValue: formFields.value.toString().obs,
                              itemList:
                                  formFields.dropdownValue
                                      ?.map((e) => e.name ?? "")
                                      .toList() ??
                                  [],
                              onChanged: (val) {
                                formFields.value = val;
                              },
                            )
                            : (formFields.fieldType == "img")
                            ? CachedNetworkImage(
                              height: 80.px,
                              width: 80.px,
                              imageUrl: formFields.placeholder ?? "",
                              progressIndicatorBuilder:
                                  (context, url, progress) =>
                                      progressIndicatorView(
                                        borderRadius: 12.px,
                                      ),
                              errorWidget:
                                  (context, url, uri) =>
                                      errorWidgetView().paddingAll(8.px),
                            )
                            : (formFields.fieldType == "img_pick")
                            ? GestureDetector(
                              onTap: () async {
                                File? imagePath = await imagePickerBottomSheet(
                                  isSub: false,
                                );
                                if (imagePath != null) {
                                  formFields.value = imagePath.path;
                                  controller.imagePathData = imagePath.path;
                                  controller.update();
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical:
                                      (!utils.isValidationEmpty(
                                            formFields.value,
                                          ))
                                          ? 5.px
                                          : 15.px,
                                  horizontal: 10.px,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: AppColors().darkAndWhite
                                        .changeOpacity(0.1),
                                    width: 1.0,
                                  ),
                                ),
                                child:
                                    (!utils.isValidationEmpty(formFields.value))
                                        ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10.px,
                                          ),
                                          child: Stack(
                                            alignment: const Alignment(
                                              0.9,
                                              -0.9,
                                            ),
                                            children: [
                                              Image.file(
                                                File(formFields.value),
                                                height: 150.px,
                                                width: 100.w,
                                                fit: BoxFit.cover,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  formFields.value = "";
                                                  controller.imagePathData = "";
                                                  controller.update();
                                                },
                                                child: CommonContainer(
                                                  radius: 100.px,
                                                  color: AppColors.red,
                                                  padding: EdgeInsets.all(4.px),
                                                  child: Image.asset(
                                                    ImagePath.lightClose,
                                                    color:
                                                        AppColors()
                                                            .whiteAndDark,
                                                    height: 15.px,
                                                    width: 15.px,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        : Row(
                                          children: [
                                            SvgPicture.asset(
                                              ImagePath.icMathImage,
                                              height: 20.px,
                                              color: AppColors().darkAndWhite,
                                            ),
                                            const SizedBox(
                                              width: 12,
                                            ), // Spacing between icon and text
                                            AppText(
                                              color: AppColors().darkGray,
                                              formFields.placeholder ?? "",
                                            ),
                                          ],
                                        ),
                              ),
                            )
                            : const SizedBox(),
                      ],
                    );
                  },
                ),
                SizedBox(height: 30.px),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.prompts.tagTypeList?.length ?? 0,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10.px);
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          controller.prompts.tagTypeList![index].tagType ?? "",
                          fontWeight: FontWeight.w700,
                        ),
                        SizedBox(height: 10.px),
                        (controller.prompts.tagTypeList![index].tagField ==
                                "switch")
                            ? Column(
                              children:
                                  controller
                                      .prompts
                                      .tagTypeList![index]
                                      .tagList!
                                      .map((e) {
                                        return Row(
                                          children: [
                                            Expanded(
                                              child: AppText(
                                                e.tag ?? "",
                                                fontWeight: FontWeight.w500,
                                                color: AppColors().darkAndWhite,
                                              ),
                                            ),
                                            Transform.scale(
                                              scale: 0.8,
                                              child: CupertinoSwitch(
                                                value:
                                                    e.isDefaultSelect == "1"
                                                        ? true
                                                        : false,
                                                activeTrackColor:
                                                    AppColors.primary,
                                                onChanged: (val) {
                                                  if (val) {
                                                    printAction(
                                                      "val)val)val) $val",
                                                    );

                                                    e.isDefaultSelect = "1";
                                                  } else {
                                                    e.isDefaultSelect = "0";
                                                  }
                                                  controller.update();
                                                },
                                              ),
                                            ),
                                          ],
                                        );
                                      })
                                      .toList(),
                            )
                            : Wrap(
                              spacing: 10.px,
                              runSpacing: 10.px,
                              children:
                                  controller
                                      .prompts
                                      .tagTypeList![index]
                                      .tagList!
                                      .map((e) {
                                        return GestureDetector(
                                          onTap: () {
                                            for (var element
                                                in controller
                                                    .prompts
                                                    .tagTypeList![index]
                                                    .tagList!) {
                                              element.isDefaultSelect = "0";
                                            }

                                            e.isDefaultSelect = "1";
                                            controller.update();
                                          },
                                          child: CommonContainer(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 10.px,
                                              horizontal: 16.px,
                                            ),
                                            isBorder: true,
                                            color:
                                                e.isDefaultSelect == "1"
                                                    ? AppColors.primary
                                                    : Colors.transparent,
                                            radius: 44.px,
                                            border: Border.all(
                                              color:
                                                  e.isDefaultSelect == "1"
                                                      ? Colors.transparent
                                                      : AppColors().darkAndWhite
                                                          .changeOpacity(0.04),
                                              width: 2,
                                            ),
                                            child: AppText(
                                              e.tag ?? "",
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  e.isDefaultSelect == "1"
                                                      ? AppColors.white
                                                      : AppColors()
                                                          .darkAndWhite,
                                            ),
                                          ),
                                        );
                                      })
                                      .toList(),
                            ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.px),
                  child: CommonButton(
                    borderRadius: 18.px,
                    title: Languages.of(context)!.generate,
                    textSize: 20.px,
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      utils.hideKeyboard();
                      var test = controller.prompts.question;

                      if (controller.prompts.stringMatch == "math") {
                        for (
                          int i = 0;
                          i < controller.prompts.formFields!.length;
                          i++
                        ) {
                          printAction(
                            "controller.prompts.formFields![i].valuecontroller.prompts.formFields![i].valuecontroller.prompts.formFields![i].value ${controller.prompts.formFields![i].fieldType}",
                          );
                          if (controller.prompts.formFields![i].isOptional ==
                                  "1" ||
                              (!utils.isValidationEmpty(
                                controller.prompts.formFields![i].value,
                              ))) {
                            test = test!.replaceAll(
                              "[${controller.prompts.formFields![i].promptFormId!.toLowerCase()}]",
                              controller.prompts.formFields![i].value!
                                  .trim()
                                  .toString(),
                            );
                          } else {
                            if (controller.prompts.formFields?[i].fieldType !=
                                "img") {
                              Utils().showSnackBar(
                                context: context,
                                message:
                                    "${Languages.of(context)!.pleaseFillThe} ${controller.prompts.formFields![i].name!.toLowerCase().toString()} ${Languages.of(context)!.inTheFormForBetterResults.capitalizeFirst}",
                              );
                              break;
                            }
                          }
                        }

                        ///prompt id
                        ///prompt question
                        if (!Utils().isValidationEmpty(
                          controller.imagePathData,
                        )) {
                          ImageScanView.toNamed(
                            imagePath: controller.imagePathData,
                            promptId: controller.prompts.promptId,
                            promptQuestion: test,
                          );
                          // Get.toNamed(
                          //   Routes.IMAGE_SCAN,
                          //   arguments: {
                          //     "imagePath": controller.imagePathData,
                          //     "promptId": controller.prompts.promptId,
                          //     "promptQuestion": test,
                          //   },
                          // );
                        } else {}
                      } else {
                        if (test!.contains(
                          "include uppercase letters: #{{136}}#.",
                        )) {
                          test = test.replaceAll(
                            "#{{136}}#",
                            (controller
                                        .prompts
                                        .tagTypeList![1]
                                        .tagList![0]
                                        .isDefaultSelect ==
                                    '1')
                                ? "Yes"
                                : "No",
                          );
                          test = test.replaceAll(
                            "#{{137}}#",
                            (controller
                                        .prompts
                                        .tagTypeList![1]
                                        .tagList![1]
                                        .isDefaultSelect ==
                                    '1')
                                ? "Yes"
                                : "No",
                          );
                          test = test.replaceAll(
                            "#{{138}}#",
                            (controller
                                        .prompts
                                        .tagTypeList![1]
                                        .tagList![2]
                                        .isDefaultSelect ==
                                    '1')
                                ? "Yes"
                                : "No",
                          );
                          test = test.replaceAll(
                            "#{{139}}#",
                            (controller
                                        .prompts
                                        .tagTypeList![1]
                                        .tagList![3]
                                        .isDefaultSelect ==
                                    '1')
                                ? "Yes"
                                : "No",
                          );
                        }
                        for (var item in controller.prompts.tagTypeList!) {
                          for (var item2 in item.tagList!) {
                            if (item2.isDefaultSelect == "1") {
                              test = test!.replaceAll(
                                "#[${item.tagTypeId!.toLowerCase()}]#",
                                item2.tag ?? "",
                              );
                            }
                          }
                        }

                        bool isDone = true;
                        for (
                          int i = 0;
                          i < controller.prompts.formFields!.length;
                          i++
                        ) {
                          if (controller.prompts.formFields![i].isOptional ==
                                  "1" ||
                              controller
                                  .prompts
                                  .formFields![i]
                                  .value!
                                  .isNotEmpty) {
                            test = test!.replaceAll(
                              "[${controller.prompts.formFields![i].promptFormId!.toLowerCase()}]",
                              controller.prompts.formFields![i].value!
                                  .trim()
                                  .toString(),
                            );
                          } else {
                            isDone = false;

                            Utils().showSnackBar(
                              context: context,
                              message:
                                  "${Languages.of(context)!.pleaseFillThe} ${controller.prompts.formFields![i].name!.toLowerCase().toString()} ${Languages.of(context)!.inTheFormForBetterResults.capitalizeFirst}",
                            );
                            break;
                          }
                        }
                        printAction("text final $test");
                        if (isDone) {
                          Get.delete<PromptChatController>();

                          Get.toNamed(
                            Routes.PROMPT_CHAT,
                            arguments: {
                              "promptId": controller.prompts.promptId,
                              "question": test,
                              "name": controller.prompts.name ?? "",
                            },
                          )!.then((value) {});
                        }
                      }
                    },
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
