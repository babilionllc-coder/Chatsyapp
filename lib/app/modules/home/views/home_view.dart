import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/helper/get_storage_data.dart';
import 'package:chatsy/app/modules/AssistantsPage/views/assistants_page_view.dart';
import 'package:chatsy/app/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:chatsy/app/modules/chat_gpt/controllers/chat_gpt_controller.dart';
import 'package:chatsy/app/modules/chat_gpt/views/chat_gpt_view.dart';
import 'package:easy_refresh/easy_refresh.dart';

// import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../Localization/local_language.dart';
import '../../../common_widget/common_container.dart';
import '../../../helper/Global.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/font_family.dart';
import '../../../helper/image_path.dart';
import '../../../routes/app_pages.dart';
import '../../promptChat/controllers/prompt_chat_controller.dart';
import '../controllers/all_prompt_model.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  BottomNavigationController get bottomNavigationController =>
      Get.find<BottomNavigationController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        var pressCount = 0;

        return WillPopScope(
          onWillPop: () async {
            pressCount++;
            if (pressCount == 2) {
              return true;
            } else {
              await Future.delayed(const Duration(milliseconds: 500)).then((
                value,
              ) async {
                if (pressCount != 2) {
                  Utils().showToast(
                    message: Languages.of(context)!.exitAlertMessage,
                  );
                }
                await Future.delayed(const Duration(milliseconds: 2500)).then((
                  value,
                ) {
                  pressCount = 0;
                });
              });
              return false;
            }
          },
          child: CommonScreen(
            toolbarHeight: 0,
            padding: EdgeInsets.zero,
            backgroundColor: AppColors().backgroundColor1,
            body: Theme(
              data: ThemeData(primaryColor: AppColors.blackColorIntro),
              child: EasyRefresh.builder(
                controller: controller.easyRefreshController,
                header: ClassicHeader(
                  textStyle: TextStyle(
                    fontSize: 14.px,
                    fontWeight: FontWeight.w700,
                    color: AppColors().darkAndWhite,
                  ),
                  iconTheme: IconThemeData(color: AppColors().darkAndWhite),
                  messageStyle: TextStyle(
                    fontSize: 12.px,
                    fontWeight: FontWeight.w700,
                    color: AppColors().darkAndWhite,
                  ),
                ),
                onRefresh: () async {
                  try {
                    await bottomNavigationController.getAllPromptAPI();
                  } catch (e) {
                    controller.easyRefreshController.finishRefresh();
                  }
                },
                childBuilder: (context, physics) {
                  return CustomScrollView(
                    scrollBehavior: ERScrollBehavior(),
                    physics: physics,
                    slivers: [
                      SliverList.list(
                        children: [
                          SizedBox(height: 15.px),
                          AppText(
                            Languages.of(context)!.templates,
                            fontSize: 16.px,
                            fontFamily: FontFamily.helveticaBold,
                          ).marginOnly(left: 16.px, bottom: 16.px),
                          if (bottomNavigationController.tabController != null)
                            Obx(
                              () => TabBar(
                                isScrollable: true,
                                labelColor: AppColors.white,
                                dividerColor: Colors.transparent,
                                tabAlignment: TabAlignment.start,
                                indicatorColor: Colors.transparent,
                                padding: EdgeInsets.only(left: 16.px),
                                indicatorSize: TabBarIndicatorSize.tab,
                                overlayColor: MaterialStateProperty.all(
                                  Colors.transparent,
                                ),
                                controller:
                                    bottomNavigationController.tabController,
                                labelStyle: TextStyle(
                                  height: 1,
                                  fontSize: 14.px,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: FontFamily.helveticaRegular,
                                ),
                                indicatorPadding: EdgeInsets.symmetric(
                                  vertical: 5.px,
                                ),
                                tabs:
                                    bottomNavigationController.promptTitleList
                                        .map((e) => Tab(text: e.name))
                                        .toList(),
                                indicator: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(51.px),
                                ),
                                unselectedLabelStyle: TextStyle(
                                  fontSize: 14.px,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.tebBartTextColor,
                                  fontFamily: FontFamily.helveticaRegular,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SliverFillRemaining(
                        hasScrollBody: true,
                        child:
                            (bottomNavigationController.tabController == null)
                                ? GridView.builder(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.px,
                                    vertical: 16.px,
                                  ),

                                  // physics: ClampingScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                        childAspectRatio: 1.5.px,
                                        // mainAxisSpacing: 2.px,
                                        crossAxisSpacing: 11.px,
                                        maxCrossAxisExtent: 250,
                                        mainAxisExtent: 100,
                                      ),
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return progressIndicatorView().paddingAll(
                                      10.px,
                                    );
                                  },
                                )
                                : Obx(() {
                                  return TabBarView(
                                    controller:
                                        bottomNavigationController
                                            .tabController,
                                    children:
                                        bottomNavigationController.promptTitleList.map((
                                          e,
                                        ) {
                                          return GridView.builder(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16.px,
                                              vertical: 8.px,
                                            ),
                                            // physics: ClampingScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithMaxCrossAxisExtent(
                                                  childAspectRatio: 1.5.px,
                                                  // mainAxisSpacing: 2.px,
                                                  crossAxisSpacing: 11.px,
                                                  maxCrossAxisExtent: 250,
                                                  mainAxisExtent: 100,
                                                ),
                                            itemCount: e.prompts!.length,
                                            itemBuilder: (context, index) {
                                              Prompts prompts =
                                                  e.prompts![index];

                                              var needToPurchase =
                                                  (Global
                                                              .isSubscription
                                                              .value !=
                                                          "1" &&
                                                      prompts.isPremium ==
                                                          "1") ||
                                                  (Global
                                                              .isSubscription
                                                              .value !=
                                                          "1" &&
                                                      Global.chatLimit.value <=
                                                          0);

                                              Widget child = Center(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (needToPurchase) {
                                                      // creditBottomSheet();
                                                      Get.find<
                                                            ChatGptController
                                                          >()
                                                          .goToPurchasePage();
                                                      return;
                                                    }

                                                    HapticFeedback.mediumImpact();
                                                    GetStorageData().saveObject(
                                                      GetStorageData().prompts,
                                                      prompts,
                                                    );

                                                    if (prompts.stringMatch ==
                                                        "translation") {
                                                      Get.toNamed(
                                                        Routes.TRANSLATE,
                                                      )!.then((value) {});
                                                    } else {
                                                      List<Prompts> prompts2 =
                                                          [];
                                                      prompts2.add(prompts);
                                                      if (prompts
                                                          .formFields!
                                                          .isNotEmpty) {
                                                        printAction(
                                                          "---------is not empty",
                                                        );
                                                        Get.toNamed(
                                                          Routes.TEMPLATE_PAGE,
                                                          arguments:
                                                              prompts2[0],
                                                        )!.then((value) {});
                                                      } else {
                                                        printAction(
                                                          "---------is empty",
                                                        );
                                                        Get.delete<
                                                          PromptChatController
                                                        >();

                                                        Get.toNamed(
                                                          Routes.PROMPT_CHAT,
                                                          arguments: {
                                                            "promptId":
                                                                prompts
                                                                    .promptId ??
                                                                "0",
                                                            "name":
                                                                prompts.name ??
                                                                "",
                                                            "question": "",
                                                          },
                                                        );
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                      top: 8.px,
                                                      left: 8.px,
                                                      bottom: 12.px,
                                                      right: 16.px,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors().bgColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            10.px,
                                                          ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              Alignment
                                                                  .centerLeft,
                                                          child: CachedNetworkImage(
                                                            width: 40.px,
                                                            height: 40.px,
                                                            imageUrl:
                                                                prompts.img!,
                                                            progressIndicatorBuilder:
                                                                (
                                                                  context,
                                                                  url,
                                                                  progress,
                                                                ) =>
                                                                    progressIndicatorView(),
                                                            errorWidget:
                                                                (
                                                                  context,
                                                                  url,
                                                                  uri,
                                                                ) => errorWidgetView()
                                                                    .paddingAll(
                                                                      8.px,
                                                                    ),
                                                            // placeholder: (context, url) => Container(),
                                                            // errorWidget: (context, url, error) => const Icon(Icons.error),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: commonMarqueeText(
                                                                prompts.name ??
                                                                    '',
                                                                style: TextStyle(
                                                                  fontSize:
                                                                      14.px,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontFamily:
                                                                      FontFamily
                                                                          .helveticaRegular,
                                                                  color:
                                                                      AppColors()
                                                                          .darkAndWhite,
                                                                ),
                                                              ),
                                                            ),
                                                            Image.asset(
                                                              ImagePath
                                                                  .darkForwardArrow,
                                                              color:
                                                                  AppColors()
                                                                      .darkAndWhite,
                                                              height: 20.px,
                                                            ),
                                                          ],
                                                        ).marginOnly(
                                                          top: 10.px,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );

                                              if (!needToPurchase) {
                                                return child;
                                              }

                                              return Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  child,
                                                  DiamondBadge(
                                                    top: 8,
                                                    right: 4,
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }).toList(),
                                  );
                                }),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

//ListView.builder(
//                                     shrinkWrap: true,
//                                     physics: const NeverScrollableScrollPhysics(),
//                                     itemCount: Get.put(BottomNavigationController()).promptTitleList.length,
//                                     itemBuilder: (context, index) {
//                                       AllPromptData allPromptData = Get.put(BottomNavigationController()).promptTitleList[index];
//                                       return Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Padding(
//                                             padding: EdgeInsets.symmetric(vertical: 10.px),
//                                             child: MyTextView(allPromptData.name, textStyleNew: MyTextStyle(textWeight: FontWeight.w400)),
//                                           ),
//
//                                     },
//                                   ),

Widget commonBorderView() {
  return Container(height: 0.5, color: AppColors().borderBottomBar);
}

Widget toolsView({
  required void Function()? onTap,
  required String image,
  required String title,
  required String subTitle,
}) {
  return GestureDetector(
    onTap: onTap,
    child: CommonContainer(
      width: MediaQuery.of(Get.context!).size.width * 0.8,
      isBorder: false,
      isBorderRadiusBottom: false,
      padding: EdgeInsets.all(8.px),
      child: Row(
        children: [
          CommonContainer(
            padding: EdgeInsets.all(15.px),
            // color: AppColors().darkWhiteAndBlack,
            color: AppColors().bgColor,

            radius: 15.px,
            child: Image.asset(
              image,
              height: 30.px,
              width: 30.px,
              color: isLight ? AppColors.blackColorIntro : AppColors.white,

              // color: AppColors.LightImageColor,
              // color:AppColors.imageColor
            ),
          ),
          SizedBox(width: 10.px),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        title,
                        fontFamily: FontFamily.helveticaBold,
                        fontSize: 16.px,
                      ),
                      AppText(
                        subTitle,
                        fontSize: 13.px,
                        color: AppColors().lightTextColor,
                      ),
                    ],
                  ),
                ),
                commonBorderView(),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget sendMessageView({required void Function()? onTap, double? padding}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(padding ?? 10.px),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.lightImageColor,
      ),
      child: Image.asset(
        ImagePath.lightIcSend,
        height: 15.px,
        width: 15.px,
        // color: AppColors().bottomSelectionColor,
      ),
    ),
  );
}

Widget infoView({required void Function() onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Image.asset(ImagePath.info, height: 16.px, color: AppColors.primary),
  );
}

class Refresher extends EasyRefresh {
  const Refresher({
    super.key,
    required super.child,
    super.controller,
    super.onRefresh,
    super.triggerAxis,
    super.header,
    this.headerPosition = IndicatorPosition.above,
  });

  final IndicatorPosition headerPosition;

  @override
  Header? get header => ClassicHeader(
    position: headerPosition,
    textStyle: TextStyle(
      fontSize: 14.px,
      fontWeight: FontWeight.w700,
      color: AppColors().darkAndWhite,
    ),
    iconTheme: IconThemeData(color: AppColors().darkAndWhite),
    messageStyle: TextStyle(
      fontSize: 12.px,
      fontWeight: FontWeight.w700,
      color: AppColors().darkAndWhite,
    ),
  );
}
