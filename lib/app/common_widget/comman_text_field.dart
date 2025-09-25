import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:chatsy/app/helper/image_path.dart';
import 'package:chatsy/app/helper/permission_controller.dart';
import 'package:chatsy/app/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:chatsy/app/modules/newChat/models/phm_id_model.dart';
import 'package:chatsy/extension.dart';
import 'package:chatsy/service/core/exception.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../helper/all_imports.dart';
import '../helper/font_family.dart';
import '../modules/home/views/home_view.dart';
import 'common_container.dart';

class CommonTextField extends StatefulWidget {
  void Function()? closeOnTap;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final Color? color;
  final BorderRadius? borderRadius;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final String? hintText;
  final String? prefixIconPath;
  final RxString? pickedImage;
  final String? suffixIconPath;
  final bool? obscureText;
  final bool? paddingShow;
  final RxBool? isAddStopButton;
  final Function()? onStopButton;
  final double? height;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? isMic;
  final RxBool? isClose;
  final void Function()? onSend;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmit;
  final void Function()? onStop;
  final void Function()? onTap;
  final double? width;
  final EdgeInsetsGeometry? paddingIcon;
  final int? maxLine;
  final int? minLine;
  final EdgeInsetsGeometry? padding;
  final TextCapitalization? textCapitalization;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final bool? enabled;
  final bool readOnly;
  bool isBorder = false;
  final TextInputAction? textInputAction;
  final TextAlign? textAlign;
  final Color? borderColor;
  final Color? cursorColor;
  final Color? hintColor;

  CommonTextField({
    super.key,
    required this.controller,
    this.height,
    this.borderColor,
    this.isAddStopButton,
    this.hintColor,
    this.cursorColor,
    this.borderRadius,
    this.color,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.paddingIcon,
    this.focusNode,
    this.hintStyle,
    this.prefixIconPath,
    this.onStopButton,
    this.keyboardType,
    this.paddingShow,
    this.onStop,
    this.padding,
    this.pickedImage,
    this.obscureText,
    this.width,
    this.isBorder = false,
    this.onChanged,
    this.maxLine,
    this.minLine,
    this.suffixIconPath,
    this.style,
    this.textCapitalization,
    this.onSend,
    this.inputFormatters,
    this.enabled,
    this.textInputAction,
    this.textAlign,
    this.isClose,
    this.isMic = false,
    this.onSubmit,
    this.readOnly = false,
    this.onTap,
    this.apiState,
  });

  final Rx<ApiState<PhmIdModel>>? apiState;

  RxBool isSend = (getStorageData.readSend()).obs;
  RxBool isListening = (getStorageData.readListening()).obs;
  ScrollController textFieldScrollController = ScrollController();

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  RxBool prefixIconShow = true.obs;

  @override
  void initState() {
    widget.controller.addListener(() {
      if ((widget.controller.text.length ?? 0) > 50) {
        if (prefixIconShow.value) {
          prefixIconShow.value = false;
        }
      } else {
        if (!prefixIconShow.value) {
          prefixIconShow.value = true;
        }
      }
    });
    super.initState();
  }

  valueUpdate() {
    printAction("valueUpdatevalueUpdatevalueUpdatevalueUpdatevalueUpdatevalueUpdate");
    printAction("-=-=-=-controller?.text ${widget.controller.text}");
    if (!utils.isValidationEmpty(widget.controller.text)) {
      widget.isListening.value = false;
      getStorageData.saveListening(value: false);

      widget.isSend.value = true;
      getStorageData.saveSend(value: true);
    } else {
      widget.isListening.value = false;
      getStorageData.saveListening(value: false);

      widget.isSend.value = false;
      getStorageData.saveSend(value: false);
    }
    Get.put(BottomNavigationController()).speechToText.stop();
  }

  Future<void> listen() async {
    if (!widget.isListening.value) {
      widget.focusNode?.requestFocus();
      bool available = await Get.put(BottomNavigationController()).speechToText.initialize(
        onStatus: (status) {
          printAction("statusstatusstatus $status");
          if (status == "done") {
            valueUpdate();
            printAction("isListening.value ${widget.isListening.value}");
            printAction("isSend.value ${widget.isSend.value}");
          }
        },
        onError: (val) {
          valueUpdate();
        },
      );
      if (available) {
        printAction("available $available");
        widget.isListening.value = true;
        getStorageData.saveListening(value: true);

        widget.isSend.value = false;
        getStorageData.saveSend(value: false);

        Get.put(BottomNavigationController()).speechToText.listen(
          onResult: (val) {
            printAction("controller?.textcontroller?.text ${widget.controller.text}");
            widget.controller.text = val.recognizedWords;
          },
        );
      }
    } else {
      valueUpdate();
    }
  }

  @override
  Widget build(BuildContext context) {
    ScrollController textFieldScrollController = ScrollController();

    if (utils.isValidationEmpty(widget.controller.text.trim())) {
      getStorageData.saveSend(value: false);
      widget.isSend.value = false;
    } else {
      getStorageData.saveSend(value: true);
      widget.isSend.value = true;
    }
    return Obx(() {
      widget.isSend.value;
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          (widget.prefixIconPath != null)
              ? Padding(
                padding: widget.paddingIcon ?? EdgeInsets.symmetric(vertical: 10.px),
                child: SvgPicture.asset(widget.prefixIconPath!),
              )
              : widget.prefixIcon ?? const SizedBox(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: widget.color ?? AppColors().darkWhiteAndBlack2.changeOpacity(0.05),
                borderRadius: widget.borderRadius ?? BorderRadius.circular(20.px),
                border:
                    (widget.isBorder || widget.color == Colors.transparent)
                        ? Border.all(
                          width: 1,
                          color: widget.borderColor ?? AppColors().grayMix.changeOpacity(0.5),
                        )
                        : null,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!utils.isValidationEmpty(widget.pickedImage?.value))
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          alignment: const Alignment(1.3, -1.3),
                          children: [
                            SizedBox(
                              height: 70.px,
                              width: 70.px,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.px),
                                child: Image.file(
                                  File(widget.pickedImage?.value ?? ""),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            if (widget.isClose?.value ?? false)
                              GestureDetector(
                                onTap: () {
                                  widget.pickedImage?.value = "";
                                },
                                child: CommonContainer(
                                  radius: 100.px,
                                  color: AppColors.red,
                                  padding: EdgeInsets.all(4.px),
                                  child: Image.asset(
                                    ImagePath.lightClose,
                                    color: AppColors().whiteAndDark,
                                    height: 15.px,
                                    width: 15.px,
                                  ),
                                ),
                              ),
                          ],
                        ).paddingOnly(top: 10.px, bottom: 10.px, left: 10.px),
                        Container(height: 1, color: AppColors().grayMix),
                      ],
                    ),
                  TextFormField(
                    textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
                    maxLines: widget.maxLine ?? 1,
                    minLines: widget.minLine ?? 1,
                    scrollController: widget.textFieldScrollController,
                    enabled: widget.enabled ?? true,
                    textInputAction: widget.textInputAction ?? TextInputAction.next,
                    obscureText: widget.obscureText ?? false,
                    controller: widget.controller,
                    focusNode: widget.focusNode,
                    inputFormatters: widget.inputFormatters,
                    textAlign: widget.textAlign ?? TextAlign.start,
                    keyboardType: widget.keyboardType ?? TextInputType.text,
                    onTapOutside: (val) {
                      if (widget.isMic ?? false) {
                        widget.isListening.value = false;
                        getStorageData.saveListening(value: false);
                        getStorageData.saveSend(value: false);

                        Get.put(BottomNavigationController()).speechToText.stop();

                        if (!utils.isValidationEmpty(widget.controller.text)) {
                          widget.isSend.value = true;
                        }
                      }
                      Future.delayed(const Duration(milliseconds: 300), () {
                        widget.textFieldScrollController.jumpTo(
                          widget.textFieldScrollController.position.maxScrollExtent,
                        );
                      });
                    },
                    textAlignVertical: TextAlignVertical.center,
                    style:
                        widget.style ??
                        TextStyle(
                          fontSize: 14.px,
                          fontFamily: FontFamily.helveticaRegular,
                          fontWeight: FontWeight.w400,
                          color: AppColors().darkAndWhite,
                        ),
                    // onSubmitted: onSubmit,
                    readOnly: widget.readOnly,
                    cursorColor: widget.cursorColor ?? AppColors.primary,
                    onTap: () {
                      if (widget.onTap != null) {
                        widget.onTap!();
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,

                      /// TODO: Font change padding change
                      contentPadding:
                          widget.padding ?? EdgeInsets.fromLTRB(15.px, 8.px, 10.px, 4.px),
                      suffixIconConstraints: BoxConstraints(maxHeight: 30.px),
                      suffixIcon:
                          widget.isMic ?? false
                              ? Obx(() {
                                return (ChatApi.isStreamingData.value || widget.isSend.value)
                                    ? (widget.controller.text.length > 50)
                                        ? GestureDetector(
                                          onTap: () {
                                            widget.controller.clear();
                                            if (widget.focusNode?.hasFocus ?? false) {
                                              widget.focusNode?.unfocus();
                                            }
                                            setState(() {});
                                          },
                                          child: Icon(
                                            Icons.highlight_remove,
                                            size: 20.px,
                                            color: AppColors().grayMix,
                                          ),
                                        ).marginAll(5.px)
                                        : SizedBox()
                                    : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            if (await PermissionHandle().cameraPermission()) {
                                              File? image = await imagePickerBottomSheet(
                                                isSub: true,
                                              );

                                              if (image != null) {
                                                widget.controller.text = await imageToText(
                                                  file: image,
                                                );

                                                if (!utils.isValidationEmpty(
                                                  widget.controller.text,
                                                )) {
                                                  setState(() {});
                                                  getStorageData.saveSend(value: true);
                                                  widget.isSend.value = true;
                                                } else {
                                                  utils.showToast(
                                                    message: "No text found in image!",
                                                  );
                                                }
                                              }
                                            }
                                          },
                                          child: Image.asset(
                                            ImagePath.scanDocument,
                                            height: 20.px,
                                            width: 20.px,
                                            color: AppColors().grayMix,
                                          ),
                                        ),
                                        SizedBox(width: 10.px),
                                        GestureDetector(
                                          onTap: () async {
                                            HapticFeedback.mediumImpact();

                                            if (await PermissionHandle().micPermission()) {
                                              listen();
                                            }
                                          },
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              if (widget.isListening.value)
                                                AvatarGlow(
                                                  animate: widget.isListening.value,
                                                  glowColor: Colors.cyan,
                                                  duration: const Duration(milliseconds: 2000),
                                                  repeat: true,
                                                  child: Center(
                                                    child: SizedBox(height: 18.px, width: 18.px),
                                                  ),
                                                ),
                                              SizedBox.square(
                                                dimension: 20,
                                                child: Image.asset(
                                                  ImagePath.lightMic,
                                                  height: 18.px,
                                                  width: 18.px,
                                                  color: AppColors().grayMix,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 10.px),
                                      ],
                                    );
                              })
                              : (widget.suffixIconPath != null)
                              ? Padding(
                                padding: EdgeInsets.only(right: 20.px),
                                child: SvgPicture.asset(widget.suffixIconPath!),
                              )
                              : widget.suffixIcon,
                      hintText: widget.hintText ?? "",
                      hintMaxLines: 1,
                      hintStyle:
                          widget.hintStyle ??
                          TextStyle(
                            fontSize: 14.px,
                            height: 2,
                            fontFamily: FontFamily.helveticaRegular,
                            color: widget.hintColor ?? AppColors().darkGray,
                          ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    onChanged: (val) {
                      if (widget.isMic ?? false) {
                        if (!widget.isSend.value) {
                          widget.isSend.value = true;
                          getStorageData.saveSend(value: true);

                          if (widget.isListening.value) {
                            widget.isListening.value = false;
                            getStorageData.saveListening(value: false);

                            Get.put(BottomNavigationController()).speechToText.stop();
                          }
                        } else {
                          if (val.isEmpty) {
                            widget.isListening.value = false;
                            getStorageData.saveListening(value: false);

                            widget.isSend.value = false;
                            getStorageData.saveSend(value: false);
                          }
                        }
                      }
                      if (widget.onChanged != null) {
                        widget.onChanged!(val);
                      }
                      if (textFieldScrollController.hasClients) {
                        textFieldScrollController.jumpTo(
                          textFieldScrollController.position.maxScrollExtent,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          (widget.isAddStopButton != null && widget.isAddStopButton!.value)
              ? GestureDetector(
                onTap: widget.onStopButton,
                child: Container(
                  width: 30.px,
                  height: 30.px,
                  padding: EdgeInsets.all(10.px),
                  decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                  child: Container(color: AppColors().whiteAndDark),
                ),
              ).paddingOnly(left: 5.px)
              : (widget.isMic ?? false)
              ? widget.apiState != null
                  ? _getSuffixButton(
                    isLoading: widget.apiState!.value.isLoading,
                    hideItWhileLoading: true,
                  )
                  : _getSuffixButton(
                    isLoading: ChatApi.isStreamingData.value,
                    hideItWhileLoading: false,
                  )
              /* (ChatApi.isStreamingData.value)
                  ? GestureDetector(
                    onTap: () {
                      updateChatLimit();
                      ChatApi.stopStreaming();
                      if (widget.onStop != null) {
                        widget.onStop!();
                      }
                    },
                    child: Container(
                      width: 30.px,
                      height: 30.px,
                      padding: EdgeInsets.all(10.px),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Container(color: AppColors().whiteAndDark),
                    ),
                  ).paddingOnly(left: 5.px)
                  : (widget.isSend.value)
                  ? sendMessageView(
                    padding: 8.px,
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      if (widget.controller.text.trim().isNotEmpty) {
                        if (!prefixIconShow.value) {
                          prefixIconShow.value = true;
                        }
                        getStorageData.saveSend(value: false);

                        getStorageData.saveListening(value: false);
                        if (widget.onSend != null) {
                          widget.onSend!();
                        }
                      }
                    },
                  ).paddingOnly(left: 5.px)
                  : const SizedBox() */
              : const SizedBox(),
        ],
      ).paddingOnly(
        bottom:
            (widget.paddingShow ?? true)
                ? MediaQuery.of(context).viewInsets.bottom == 0
                    ? MediaQuery.of(context).padding.bottom == 0
                        ? 10
                        : MediaQuery.of(context).padding.bottom
                    : 10.px
                : 5,
      );
    });
  }

  Widget _getSuffixButton({required bool isLoading, required bool hideItWhileLoading}) {
    if (isLoading) {
      return Visibility(
        visible: !hideItWhileLoading,
        child: GestureDetector(
          onTap: () {
            updateChatLimit();
            ChatApi.stopStreaming();
            if (widget.onStop != null) {
              widget.onStop!();
            }
          },
          child: Container(
            width: 30.px,
            height: 30.px,
            padding: EdgeInsets.all(10.px),
            decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
            child: Container(color: AppColors().whiteAndDark),
          ),
        ).paddingOnly(left: 5.px),
      );
    }

    return (widget.isSend.value)
        ? sendMessageView(
          padding: 8.px,
          onTap: () {
            HapticFeedback.mediumImpact();
            if (widget.controller.text.trim().isNotEmpty) {
              if (!prefixIconShow.value) {
                prefixIconShow.value = true;
              }
              getStorageData.saveSend(value: false);

              getStorageData.saveListening(value: false);
              if (widget.onSend != null) {
                widget.onSend!();
              }
            }
          },
        ).paddingOnly(left: 5.px)
        : const SizedBox();
  }
}
