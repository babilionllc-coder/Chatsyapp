import 'dart:io';

import 'package:chatsy/app/common_widget/comman_text_field.dart';
import 'package:chatsy/app/common_widget/common_button.dart';
import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/helper/image_path.dart';
import 'package:chatsy/app/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:chatsy/extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../Localization/local_language.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/font_family.dart';
import '../../../routes/app_pages.dart';
import '../../chat_gpt/controllers/chat_gpt_controller.dart';
import '../../chat_gpt/views/chat_gpt_view.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
      builder: (controller) {
        return CommonScreen(
          resizeToAvoidBottomInset: false,
          padding: EdgeInsets.zero,
          title: Languages.of(context)!.profile,
          backgroundColor: AppColors().backgroundColor1,
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Obx(() {
                      return GestureDetector(
                        onTap: () {
                          controller.avatarSelected();
                        },
                        child: Center(
                          child:
                              (controller.imagePath != null &&
                                      controller.currentIndex.value ==
                                          (controller.userList.length - 1))
                                  ? ClipOval(
                                    child: Image.file(
                                      File(controller.imagePath!),
                                      fit: BoxFit.cover,
                                      height: 80.px,
                                      width: 80.px,
                                    ),
                                  )
                                  : (!utils.isValidationEmpty(
                                        getStorageData.readString(getStorageData.profile),
                                      ) &&
                                      getStorageData
                                              .readString(getStorageData.profile)
                                              .toString()
                                              .compareTo("https//aichatsy.com") ==
                                          1 &&
                                      controller.currentIndex.value ==
                                          (controller.userList.length - 1))
                                  ? ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          getStorageData
                                              .readString(getStorageData.profile)
                                              .toString(),
                                      fit: BoxFit.cover,
                                      height: 80.px,
                                      width: 80.px,
                                      progressIndicatorBuilder:
                                          (context, url, progress) => progressIndicatorView(),
                                      errorWidget:
                                          (context, url, uri) => errorWidgetView().paddingAll(8.px),
                                    ),
                                  )
                                  : Padding(
                                    padding: EdgeInsets.all(
                                      controller.currentIndex.value ==
                                              (controller.userList.length - 1)
                                          ? 20.px
                                          : 0,
                                    ),
                                    child: Image.asset(
                                      controller.userList[controller.currentIndex.value].image,
                                      fit: BoxFit.cover,
                                      height: 80.px,
                                      width: 80.px,
                                      color:
                                          controller.currentIndex.value ==
                                                  (controller.userList.length - 1)
                                              ? AppColors().darkAndWhite
                                              : null,
                                    ),
                                  ),
                        ),
                      );
                    }),
                    SizedBox(height: 15.px),
                    Center(
                      child: AppText(
                        fontSize: 14.px,
                        textAlign: TextAlign.center,
                        Languages.of(context)!.clickToChangeAvatar,
                      ),
                    ),
                    SizedBox(height: 20.px),
                    Get.put(BottomNavigationController()).commonRedeemView(context: context),
                    AppText(fontSize: 12.px, Languages.of(context)!.name).marginOnly(bottom: 8.px),
                    CommonTextField(
                      color: Colors.transparent,
                      controller: controller.userNameController,
                      paddingShow: false,
                      isBorder: true,

                      textInputAction: TextInputAction.done,
                      padding: EdgeInsets.symmetric(vertical: 12.px, horizontal: 10.px),
                      borderRadius: BorderRadius.circular(15.px),
                      // textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.px, color: AppColors().darkAndWhite),
                    ).marginOnly(bottom: 16.px),
                    if (!utils.isValidationEmpty(controller.loginData.email.toString()))
                      AppText(
                        fontSize: 12.px,
                        Languages.of(context)!.email,
                      ).marginOnly(bottom: 8.px),
                    if (!utils.isValidationEmpty(controller.loginData.email.toString()))
                      CommonTextField(
                        color: Colors.transparent,
                        controller: TextEditingController(
                          text: controller.loginData.email.toString(),
                        ),
                        paddingShow: false,
                        readOnly: true,
                        isBorder: true,

                        suffixIcon: GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            Clipboard.setData(
                              ClipboardData(text: controller.loginData.email.toString()),
                            );
                            utils.showToast(message: "Email copied");
                          },
                          child: SvgPicture.asset(
                            ImagePath.copy,
                            height: 18.px,
                            color: AppColors().grayColorMix,
                          ).paddingOnly(right: 16.px),
                        ),
                        textInputAction: TextInputAction.done,
                        padding: EdgeInsets.symmetric(vertical: 12.px, horizontal: 10.px),
                        borderRadius: BorderRadius.circular(15.px),
                        // textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.px, color: AppColors().darkAndWhite),
                      ).marginOnly(bottom: 16.px),
                    if (controller.userIdentification.isNotEmpty)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            fontSize: 12.px,
                            Languages.of(context)!.userID,
                          ).marginOnly(bottom: 8.px),
                          CommonTextField(
                            color: Colors.transparent,
                            controller: TextEditingController(text: controller.userIdentification),
                            paddingShow: false,
                            isBorder: true,

                            readOnly: true,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                HapticFeedback.mediumImpact();
                                Clipboard.setData(
                                  ClipboardData(
                                    text: controller.userIdentification.logNamed('user-id'),
                                  ),
                                );
                                utils.showToast(message: "User id copied");
                              },
                              child: SvgPicture.asset(
                                ImagePath.copy,
                                height: 18.px,
                                color: AppColors().grayColorMix,
                              ).paddingOnly(right: 16.px),
                            ),
                            textInputAction: TextInputAction.done,
                            padding: EdgeInsets.symmetric(vertical: 12.px, horizontal: 10.px),
                            borderRadius: BorderRadius.circular(15.px),
                            // textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.px, color: AppColors().darkAndWhite),
                          ).marginOnly(bottom: 2.h),
                        ],
                      ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();

                        Get.toNamed(Routes.MORE_SCREEN);
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: AppText(
                          Languages.of(context)!.more,
                          decoration: TextDecoration.underline,
                          fontFamily: FontFamily.helveticaBold,
                          fontSize: 16.px,
                          color: AppColors().darkAndWhite,
                        ),
                      ),
                    ).marginOnly(bottom: 2.h),
                    CommonButton(
                      textSize: 14.px,
                      textColor: Colors.white,
                      textWeight: FontWeight.w700,
                      title: Languages.of(context)!.update,
                      onTap: () {
                        if (controller.isEditProfileValidation()) {
                          for (var item in controller.userList) {
                            if (controller.userList.indexOf(item) ==
                                controller.currentIndex.value) {
                              Get.put(BottomNavigationController()).updateProfile(
                                image:
                                    item.image == controller.userList.last.image
                                        ? null
                                        : item.image,
                                userName: controller.userNameController.text.trim(),
                                filePath:
                                    (item.image == controller.userList.last.image)
                                        ? controller.imagePath
                                        : null,
                              );
                              break;
                            }
                          }
                        }
                      },
                    ),
                    SizedBox(height: 50.px),
                  ],
                ),
              ),
              CommonButton(
                textSize: 14.px,
                textColor: Colors.white,
                textWeight: FontWeight.w700,
                title:
                    ((controller.loginData.isGuestMode ?? "") == "1")
                        ? Languages.of(context)!.signIn.capitalize
                        : Languages.of(context)!.logOut.capitalize,
                onTap: () {
                  if ((controller.loginData.isGuestMode ?? "") == "1") {
                    Get.toNamed(Routes.SOCIAL_SCREEN)?.then((value) {
                      if (value != null) {
                        Get.back();
                        Get.back();
                        if (Get.isRegistered<BottomNavigationBar>()) {
                          Get.put(BottomNavigationController()).getLoginData();
                          Get.put(BottomNavigationController()).update();
                        }
                        if (Get.isRegistered<ChatGptController>()) {
                          Get.put(ChatGptController()).update();
                        }
                      }
                    });
                  } else {
                    controller.logOutShowDialog();
                  }
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom + ((Platform.isAndroid) ? 20.px : 0),
              ),
            ],
          ).marginSymmetric(horizontal: 16.px),
        );
      },
    );
  }
}
