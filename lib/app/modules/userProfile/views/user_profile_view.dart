import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/helper/font_family.dart';
import 'package:chatsy/app/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../Localization/local_language.dart';
import '../../../helper/image_path.dart';
import '../../../helper/permission_controller.dart';
import '../../../routes/app_pages.dart';
import '../../bottom_navigation/views/bottom_navigation_view.dart';
import '../../chat_gpt/views/chat_gpt_view.dart';
import '../../newChat/controllers/new_chat_controller.dart';
import '../controllers/user_profile_controller.dart';

class UserProfileView extends GetView<UserProfileController> {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserProfileController>(
      init: UserProfileController(),
      builder: (controller) {
        return CommonScreen(
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.EDIT_PROFILE)!.then((value) {
                          if (value != null) {
                            controller.update();
                          }
                        });
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 10.px),
                          (!utils.isValidationEmpty(
                                    getStorageData.readString(getStorageData.profile),
                                  ) &&
                                  getStorageData
                                          .readString(getStorageData.profile)
                                          .toString()
                                          .compareTo("https//aichatsy.com") ==
                                      1)
                              ? ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      getStorageData.readString(getStorageData.profile).toString(),
                                  height: 40.px,
                                  width: 40.px,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, progress) => progressIndicatorView(),
                                  errorWidget:
                                      (context, url, uri) => errorWidgetView().paddingAll(8.px),
                                ),
                              ).marginOnly(right: 12.69.px)
                              : Image.asset(
                                !utils.isValidationEmpty(
                                      getStorageData.readString(getStorageData.profile),
                                    )
                                    ? getStorageData.readString(getStorageData.profile) ?? ""
                                    : ImagePath.user4,
                                height: 40.px,
                              ).marginOnly(right: 12.69.px),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: AppText(
                                    getStorageData.readString(getStorageData.isGuestMode) != "1"
                                        ? getStorageData.readString(getStorageData.userName) ?? ""
                                        : Languages.of(context)!.tapToSignIn,
                                    fontSize: 16.px,
                                    maxLines: 2,
                                    fontFamily: FontFamily.helveticaBold,
                                  ),
                                ),
                                SizedBox(width: 12.px),
                                SvgPicture.asset(
                                  ImagePath.forward,
                                  color: AppColors().darkAndWhite,
                                ),
                              ],
                            ),
                          ),
                          // GestureDetector(
                          //     onTap: () {
                          //       Get.back();
                          //       Get.toNamed(Routes.EDIT_PROFILE);
                          //     },
                          //     child: Image.asset(
                          //       ImagePath.edit,
                          //       height: 19.px,
                          //       color: AppColors().dialogText3,
                          //     )),
                        ],
                      ).marginOnly(bottom: 20.px),
                    ),
                    Get.put(BottomNavigationController()).commonTrialView(),
                    SizedBox(height: 25.px),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();

                        Get.back();
                        Get.delete<NewChatController>();
                        Get.toNamed(Routes.NEW_CHAT, arguments: {HttpUtil.isAssistant: false});
                      },
                      child: CommonPopView(
                        title: Languages.of(context)!.newChat,
                        icon: ImagePath.icNewChat,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();

                        Get.toNamed(Routes.CHAT_HISTORY);
                      },
                      child: CommonPopView(
                        title: Languages.of(context)!.chatHistory,
                        icon: ImagePath.historyIcon,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();

                        Get.toNamed(Routes.SETTING);
                      },
                      child: CommonPopView(
                        title: Languages.of(context)!.settings,
                        icon: ImagePath.icSetting,
                      ),
                    ),
                    if (controller.statusNotification != null &&
                        (!controller.statusNotification!.isGranted))
                      GestureDetector(
                        onTap: () async {
                          HapticFeedback.mediumImpact();
                          if (await PermissionHandle().notificationPermission()) {
                            controller.permissionNotification();
                          }
                        },
                        child: CommonPopView(
                          title: Languages.of(context)!.notifications,
                          icon: ImagePath.icNotification,
                        ),
                      ),
                  ],
                ),
              ),
              Get.put(BottomNavigationController()).commonRedeemView(context: context),
            ],
          ).paddingSymmetric(horizontal: 16.px),
        );
      },
    );
  }
}
