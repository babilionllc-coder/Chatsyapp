import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/helper/image_path.dart';
import 'package:chatsy/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Localization/local_language.dart';
import '../../../common_widget/common_container.dart';
import '../../../helper/all_imports.dart';
import '../../../routes/app_pages.dart';
import '../../chat_gpt/controllers/chat_gpt_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (controller) {
        return CommonScreen(
          title: Languages.of(context)!.settings,
          // padding: EdgeInsets.zero,
          body: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.px),
            physics: const BouncingScrollPhysics(),
            children: [
              /*CommonListTileView(
                  onTap: () {     
                    Get.back();
                    Get.back();
                    Get.toNamed(Routes.WHATS_NEW)!.then(
                      (value) {
                        if (value != null && value == Constants.youtube) {
                          if (Get.put(BottomNavigationController()).toolsListModel.isNotEmpty) {
                            ToolsModel data = Get.put(BottomNavigationController()).toolsListModel.where((element) => element.modelType == Constants.youtubeSummarizeAPIType).map((e) => e).toList().first;

                            Get.put(ChatGptController()).youtubeOnTap(data);
                          }
                        }
                      },
                    );
                  },
                  title: Languages.of(context)!.whatNew,
                  leading: ImagePath.notification,
                  titleView: Row(
                    children: [
                      Flexible(
                        child: AppText(
                          maxLines: 1,
                          Languages.of(context)!.whatNew,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 16.px,
                        ),
                      ),
                      SizedBox(width: 10.px),
                      CommonContainer(
                        color: const Color(0xFF3BDBD4),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.px),
                          child: AppText(
                            Languages.of(context)!.news,
                            fontSize: 12.px,
                            color: AppColors.white,
                          ).paddingOnly(top: 1),
                        ),
                      ),
                    ],
                  ),
                ),*/
              CommonListTileView(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Get.toNamed(Routes.LANGUAGE_PAGE);
                },
                title: Languages.of(context)!.language,
                leading: ImagePath.darkTranslate,
              ),

              CommonListTileView(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Get.toNamed(Routes.VOICE_PAGE);
                },
                title: Languages.of(context)!.voice,
                leading: ImagePath.icVoice,
              ),
              CommonListTileView(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Get.toNamed(Routes.THEME_PAGE);
                },
                title: Languages.of(context)!.theme,
                leading: ImagePath.icTheme,
              ),

              Obx(() {
                return CommonListTileView(
                  title: Languages.of(context)!.followUpQuestions,
                  leading: ImagePath.icFollowUp,
                  trailingView: Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      value: controller.isFollowUpValues.value,
                      activeTrackColor: AppColors.primary,
                      onChanged: (val) {
                        HapticFeedback.mediumImpact();

                        controller.isFollowUpValues.value = val;
                        if (controller.isFollowUpValues.value) {
                          getStorageData.removeData(getStorageData.suggestionView);
                        } else {
                          getStorageData.saveString(getStorageData.suggestionView, "0");
                        }
                      },
                    ),
                  ),
                );
              }),
              CommonHoriLineView(),
              CommonListTileView(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  doYouBottomSheet2();
                },
                title: Languages.of(context)!.rateUs,
                leading: ImagePath.darkRateUs,
              ),
              CommonListTileView(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Get.put(ChatGptController()).goToPurchasePage(arguments: {"is_call": true});
                },
                title: Languages.of(context)!.restore,
                leading: ImagePath.restore,
              ),
              CommonHoriLineView(),
              ExpansionTile(
                shape: const Border(),
                childrenPadding: EdgeInsets.zero,
                tilePadding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 1),
                visualDensity: const VisualDensity(horizontal: -2, vertical: 0),
                iconColor: AppColors().dialogText3,
                collapsedIconColor: AppColors().dialogText3,
                trailing:
                    controller.isFollowUs
                        ? Transform.rotate(
                          angle: 1.5,
                          child: Image.asset(
                            ImagePath.darkForwardArrow,
                            height: 20.px,
                            width: 20.px,
                            color: AppColors.primary,
                          ),
                        )
                        : Image.asset(
                          ImagePath.darkForwardArrow,
                          height: 20.px,
                          width: 20.px,
                          color: AppColors().dialogText3,
                        ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(6.px),
                  child: Image.asset(
                    ImagePath.darkPrivacy,
                    height: 32.px,
                    width: 32.px,
                    // color: AppColors().dialogText3,
                  ),
                ),
                onExpansionChanged: (bool expanded) {
                  controller.isFollowUs = expanded;
                  controller.update();
                },
                title: AppText(
                  Languages.of(context)!.legal,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16.px,
                ),
                children: <Widget>[
                  Align(
                    child: Column(
                      children: [
                        CommonListTileView(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            Get.toNamed(Routes.PRIVACY_POLICY);
                          },
                          title: Languages.of(context)!.privacyPolicy,
                          leading: ImagePath.darkPrivacy,
                        ),
                        CommonListTileView(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            Get.toNamed(Routes.TERMS_PAGE);
                          },
                          title: Languages.of(context)!.termsOfUse,
                          leading: ImagePath.darkTerms,
                        ),
                        // CommonListTileView(
                        //     onTap: () {
                        //       HapticFeedback.mediumImpact();
                        //       Get.toNamed(Routes.ABOUT_US);
                        //     },
                        //     title: Languages.of(context)!.aboutUs,
                        //     leading: ImagePath.darkAboutUs),
                      ],
                    ),
                  ),
                ],
              ),
              CommonHoriLineView(),
              CommonListTileView(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  Get.toNamed(Routes.CONTACT_US);
                },
                title: Languages.of(context)!.contactUs,
                leading: ImagePath.darkContactUs,
              ),
              ExpansionTile(
                shape: const Border(),
                childrenPadding: EdgeInsets.zero,
                tilePadding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 1),
                visualDensity: const VisualDensity(horizontal: -2, vertical: 0),
                iconColor: AppColors().dialogText3,
                collapsedIconColor: AppColors().dialogText3,
                trailing:
                    controller.isLegal
                        ? Transform.rotate(
                          angle: 1.5,
                          child: Image.asset(
                            ImagePath.darkForwardArrow,
                            height: 20.px,
                            width: 20.px,
                            color: AppColors.primary,
                          ),
                        )
                        : Image.asset(
                          ImagePath.darkForwardArrow,
                          height: 20.px,
                          width: 20.px,
                          color: AppColors().dialogText3,
                        ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(6.px),
                  child: Image.asset(
                    ImagePath.icFollow,
                    height: 32.px,
                    width: 32.px,
                    // color: AppColors().dialogText3,
                  ),
                ),
                onExpansionChanged: (bool expanded) {
                  controller.isLegal = expanded;
                  controller.update();
                },
                title: AppText(
                  Languages.of(context)!.followUs,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16.px,
                ),
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerRight,
                    child: CommonContainer(
                      margin: EdgeInsets.only(right: 14.px),
                      radius: 27.px,
                      color: AppColors().bgColor,
                      padding: EdgeInsets.symmetric(horizontal: 15.px, vertical: 6.px),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              launch("https://www.tiktok.com/@aichatsyapp");
                            },
                            child: Image.asset(ImagePath.tiktok, height: 42.px, width: 42.px),
                          ),
                          SizedBox(width: 16.px),
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              launchUrl(Uri.parse("https://www.instagram.com/aichatsy/"));
                            },
                            child: Image.asset(ImagePath.instagram, height: 42.px, width: 42.px),
                          ),
                          SizedBox(width: 16.px),
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              launchUrl(Uri.parse("https://www.facebook.com/aichatsyapp/"));
                            },
                            child: Image.asset(ImagePath.facebook, height: 42.px, width: 42.px),
                          ),
                          SizedBox(width: 16.px),
                          GestureDetector(
                            onTap: () {
                              HapticFeedback.mediumImpact();
                              launchUrl(Uri.parse("https://twitter.com/aichatsy/"));
                            },
                            child: Image.asset(ImagePath.twitter, height: 42.px, width: 42.px),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // CommonListTileView(
              //     onTap: () {
              //       HapticFeedback.mediumImpact();
              //       Get.back();
              //       Get.toNamed(Routes.REASON);
              //     },
              //     title: Languages.of(context)!.deleteAccount.capitalize ?? "",
              //     leading: ImagePath.deleteAccount),
              SizedBox(height: 10.px),
            ],
          ),
        );
      },
    );
  }
}

Widget CommonListTileView({
  required String title,
  Widget? titleView,
  required String leading,
  Widget? subtitle,
  String? trailing,
  void Function()? onTap,
  Widget? trailingView,
}) {
  return GestureDetector(
    onTap: onTap,
    child: ListTile(
      dense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 3.px),
      visualDensity: const VisualDensity(horizontal: -2, vertical: 0),
      title:
          titleView ??
          AppText(title, maxLines: 1, overflow: TextOverflow.ellipsis, fontSize: 16.px),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(6.px),
        child:
            (leading.contains(".svg"))
                ? SvgPicture.asset(
                  leading,
                  height: 32.px,
                  width: 32.px,
                  // color: AppColors().dialogText3,
                )
                : Image.asset(
                  leading,
                  height: 32.px,
                  width: 32.px,
                  // color: AppColors().dialogTex t3,
                ),
      ),
      subtitle: subtitle,
      trailing:
          trailingView ??
          Image.asset(
            trailing ?? ImagePath.darkForwardArrow,
            height: 20.px,
            width: 20.px,
            color: AppColors().dialogText3,
          ),
    ),
  );
}

Widget CommonHoriLineView() {
  return Container(
    height: 1,
    color: AppColors().darkAndWhite.changeOpacity(0.1),
  ).paddingSymmetric(vertical: 4);
}

// Widget CommonGeryContainer({required Widget child}) {
//   return Container(
//     decoration: BoxDecoration(
//       shape: BoxShape.circle,
//       border: Border.all(color: AppColors().darkAndWhite.changeOpacity(0.4)),
//     ),
//     child: Container(
//       height: 18.px,
//       width: 18.px,
//       padding: EdgeInsets.all(4.px),
//       decoration: BoxDecoration(color: AppColors().darkAndWhite.changeOpacity(0.1), shape: BoxShape.circle),
//       child: child,
//     ),
//   );
// }
