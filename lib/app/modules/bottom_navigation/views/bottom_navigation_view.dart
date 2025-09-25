import 'package:chatsy/app/helper/Global.dart';
import 'package:chatsy/app/modules/AssistantsPage/views/assistants_page_view.dart';
import 'package:chatsy/app/modules/OfferScreen/views/offer_screen_view.dart';
import 'package:chatsy/app/modules/chatHistory/controllers/chat_history_controller.dart';
import 'package:chatsy/app/modules/chat_gpt/controllers/chat_gpt_controller.dart';
import 'package:chatsy/app/modules/chat_gpt/views/chat_gpt_view.dart';
import 'package:chatsy/app/modules/create_ai_assistant/views/create_ai_assistant_view.dart';
import 'package:chatsy/app/modules/purchase/views/purchase_view.dart';
import 'package:chatsy/extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../Localization/local_language.dart';
import '../../../common_widget/rx_common_model.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/image_path.dart';
import '../../../routes/app_pages.dart';
import '../../home/views/home_view.dart';
import '../controllers/bottom_navigation_controller.dart';

class BottomNavigationItem {
  final (String, String, String) icon;
  final String? title;

  final Widget screen;
  final RxBool? isCheck;

  BottomNavigationItem({
    required this.icon,
    required this.title,
    required this.screen,
    this.isCheck,
  });
}

class BottomNavigationView extends GetView<BottomNavigationController> {
  const BottomNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatGptController());

    return GetBuilder<BottomNavigationController>(
      init: BottomNavigationController(),
      builder: (controller) {
        controller.addOtherPromptsList = [
          RxCommonModel(
            title: Languages.of(context)!.imageScan,
            image: ImagePath.imageScanIcon,
          ),
          RxCommonModel(
            title: Languages.of(context)!.uploadFile,
            image: ImagePath.file,
          ),
          RxCommonModel(
            title: Languages.of(context)!.summarizeWeb,
            image: ImagePath.link,
          ),
          RxCommonModel(
            title: Languages.of(context)!.generateImage,
            image: ImagePath.generateImagesIcon,
          ),
          RxCommonModel(
            title: Languages.of(context)!.scanText,
            image: ImagePath.scan,
          ),
          RxCommonModel(
            title: Languages.of(context)!.aiAssistants,
            image: ImagePath.assistants,
          ),
          RxCommonModel(
            title: Languages.of(context)!.templates,
            image: ImagePath.templates,
          ),
        ];
        controller.bottomBarItem =
            <BottomNavigationItem>[
              BottomNavigationItem(
                title: Languages.of(context)?.templates,
                icon: (
                  ImagePath.icTemplates,
                  ImagePath.templatesLottie,
                  ImagePath.templatesDarkLottie,
                ),
                screen: const HomeView(),
                isCheck: false.obs,
              ),
              BottomNavigationItem(
                title: Languages.of(context)?.home,
                icon: (
                  ImagePath.icHome,
                  ImagePath.homeLottie,
                  ImagePath.homeDarkLottie,
                ),
                screen: const ChatGptView(),
                isCheck: true.obs,
              ),
              BottomNavigationItem(
                title: Languages.of(context)?.assistants,
                icon: (
                  ImagePath.icAssistants,
                  ImagePath.aiAssistantLottie,
                  ImagePath.aiAssistantDarkLottie,
                ),

                screen: const AssistantsPageView(),
                isCheck: false.obs,
              ),
            ].obs;

        for (var element in controller.bottomBarItem) {
          element.isCheck?.value = false;
        }
        controller
            .bottomBarItem[controller.selectedIndex.value]
            .isCheck
            ?.value = true;
        var pressCount = 0;
        return WillPopScope(
          onWillPop: () async {
            if (controller.selectedIndex.value != 1) {
              controller.selectedIndex.value = 1;
              for (var element in controller.bottomBarItem) {
                element.isCheck?.value = false;
              }
              controller
                  .bottomBarItem[controller.selectedIndex.value]
                  .isCheck
                  ?.value = true;
            } else {
              pressCount++;
              printAction("pressCountpressCount $pressCount");
              if (pressCount == 2) {
                SystemNavigator.pop();
              } else {
                await Future.delayed(const Duration(milliseconds: 500)).then((
                  value,
                ) async {
                  if (pressCount != 2) {
                    Utils().showToast(
                      message:
                          "Tap the back button once more to \nexit the app",
                    );
                  }
                  await Future.delayed(const Duration(milliseconds: 4000)).then(
                    (value) {
                      pressCount = 0;
                    },
                  );
                });
              }
            }
            return false;
          },
          child: VisibilityDetector(
            key: ObjectKey("1"),
            onVisibilityChanged: (visibilityInfo) {
              if (visibilityInfo.visibleFraction > 0.5) {
                controller.isVisible = true;
              } else if (visibilityInfo.visibleFraction < 0.5) {
                controller.isVisible = false;
              }
            },
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                iconTheme: IconThemeData(color: AppColors().darkAndWhite),
                // automaticallyImplyLeading: false,
                backgroundColor: AppColors().backgroundColor1,
                leading: GestureDetector(
                  onTap: () {
                    // Get.toNamed(Routes.SETTING);
                    Get.toNamed(Routes.USER_PROFILE);
                  },
                  child: SvgPicture.asset(
                    ImagePath.profile,
                    height: 20.px,
                    color: AppColors().darkAndWhite,
                  ).paddingOnly(left: 10.px),
                ),
                leadingWidth: 45.px,

                /*leading: PopupMenuButton<int>(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context) => [
                    PopupMenuItem(height: 40.px, value: 1, child: CommonPopView(title: Languages.of(context)!.newChat, icon: ImagePath.icNewChat)),
                    const PopupMenuDivider(height: 1),
                    PopupMenuItem(height: 40.px, value: 2, child: CommonPopView(title: Languages.of(context)!.chatHistory, icon: ImagePath.icHistory)),
                    const PopupMenuDivider(height: 1),
                    PopupMenuItem(height: 40.px, value: 3, child: CommonPopView(title: Languages.of(context)!.settings, icon: ImagePath.icSetting)),
                  ],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.px))),
                  offset: const Offset(15, 50),
                  color: AppColors().whiteAndDark,
                  icon: const Icon(Icons.menu),
                  elevation: 5,
                  onSelected: (value) {
                    if (value == 1) {
                      Get.delete<NewChatController>();
                      Get.toNamed(Routes.NEW_CHAT, arguments: {HttpUtil.isAssistant: false});
                    } else if (value == 2) {
                      Get.toNamed(Routes.CHAT_HISTORY);
                    } else if (value == 3) {
                      if (controller.scaffoldKey.currentState != null) {
                        controller.scaffoldKey.currentState!.openDrawer();
                      }
                    }
                  },
                ),*/
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: AppColors.transparent,
                  statusBarIconBrightness:
                      isLight
                          ? Brightness.dark
                          : Brightness.light, // status bar color
                  statusBarBrightness:
                      isLight ? Brightness.light : Brightness.dark,
                ),
                /*title: GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      isLight = !isLight;
                      Loading.loadingInit();

                      getStorageData.saveString(getStorageData.isLight, isLight);
                      controller.update();
                      Get.put<ChatGptController>(ChatGptController()).update();
                      Get.put<HomeController>(HomeController()).update();
                      Get.put<AssistantsPageController>(
                          AssistantsPageController()).update();
                      controller.update();
                    },
                    child: Image.asset(
                        (isLight) ? ImagePath.dark : ImagePath.brightness2,
                        height: 24.px, color: AppColors().darkAndWhite)),*/
                centerTitle: true,
                actions: [
                  Obx(() {
                    return Visibility(
                      visible:
                          controller.bottomBarItem.last.isCheck?.value ?? false,
                      child: IconButton(
                        onPressed: () {
                          if (!kDebugMode &&
                              Global.isSubscription.value != '1') {
                            PurchaseView.route(arguments: null);
                            return;
                          }

                          CreateAiAssistantView.route();
                        },
                        icon: Icon(Icons.add),
                      ),
                    );
                  }),
                  LimitAndHistoryButtonView(),
                  if (kDebugMode)
                    GestureDetector(
                      onTap: () {
                        OfferScreenView.route()?.then((value) {
                          if (value == "plan_purchase") {
                            controller.getUserProfileAPI(isLoading: true);
                          }
                        });
                        // Get.toNamed(Routes.OFFER_SCREEN);
                      },
                      child: const Icon(Icons.abc),
                    ),
                ],
              ),
              body: Obx(
                () => IndexedStack(
                  index: controller.selectedIndex.value,
                  children:
                      controller.bottomBarItem.map((element) {
                        return element.screen;
                      }).toList(),
                ),
              ),
              bottomNavigationBar: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.px),
                decoration: BoxDecoration(
                  color: isLight ? AppColors.white : AppColors.bottomColor,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                      color: Colors.grey.changeOpacity(0.2),
                    ),
                  ],
                ),
                child: SafeArea(
                  minimum: EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(controller.bottomBarItem.length, (
                      index,
                    ) {
                      return Obx(
                        () => InkWell(
                          onTap: () async {
                            for (var element in controller.bottomBarItem) {
                              element.isCheck?.value = false;
                            }
                            controller.selectedIndex.value = index;
                            controller.bottomBarItem[index].isCheck?.value =
                                true;

                            if ((controller
                                        .bottomBarItem
                                        .first
                                        .isCheck
                                        ?.value ??
                                    false) &&
                                (!controller.isTemplateAPICall)) {
                              controller.getAllPromptAPI();
                            }
                            if ((controller.bottomBarItem[1].isCheck?.value ??
                                    false) &&
                                (!controller.isUserProfileAPICall)) {
                              controller.getUserProfileAPI(isLoading: false);
                            }
                          },
                          child: CustomNavItem(
                            icon: controller.bottomBarItem[index].icon,
                            index: index,
                            label: controller.bottomBarItem[index].title ?? '',
                            isSelected:
                                controller
                                    .bottomBarItem[index]
                                    .isCheck
                                    ?.value ??
                                false,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomNavItem extends StatelessWidget {
  final (String, String, String) icon;
  final String label;
  final bool isSelected;
  final int index;

  const CustomNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var (normalIcon, lottieIcon, lottieDarkIcon) = icon;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 2.px,
          width: 114.px,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
        ).marginOnly(bottom: 10.px),
        SizedBox.square(
          dimension: 26.px,
          child: Center(
            child: CustomLottie(
              isSelected: isSelected,
              path: (isLight ? lottieIcon : lottieDarkIcon),
              nonSelectedWidget: SvgPicture.asset(normalIcon, height: 25.px),
              // isSelected ? (isLight ? lottieIcon : lottieDarkIcon) : lottieIcon,
              // animate: false,
              // height: 25.px,
            ),
          ),
        ),
        AppText(
          label,
          fontSize: 10.px,
          color:
              isLight
                  ? isSelected
                      ? AppColors.black
                      : AppColors.bottomTextColor.changeOpacity(.4)
                  : isSelected
                  ? AppColors.white
                  : AppColors.white.changeOpacity(.4),
        ).marginOnly(bottom: 10.px),
      ],
    );
  }
}

Widget CommonPopView({required String title, required String icon}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10.px),
    color: Colors.transparent,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon.contains(".svg")
            ? SvgPicture.asset(
              icon,
              width: 24.px,
              height: 24.px,
              color: AppColors().darkAndWhite,
            )
            : Image.asset(
              icon,
              width: 24.px,
              height: 24.px,
              color: AppColors().darkAndWhite,
            ),
        const SizedBox(width: 10),
        AppText(
          title,
          fontSize: 16.px,
          // color: AppColors().dialogText3,
          /// TODO: Font change top margin change
        ).marginOnly(top: 2),
      ],
    ),
  );
}

class CustomLottie extends ImplicitlyAnimatedWidget {
  const CustomLottie({
    required this.nonSelectedWidget,
    super.key,
    super.duration = Durations.extralong4,
    required this.isSelected,
    required this.path,
  });

  final Widget nonSelectedWidget;

  final String path;

  final bool isSelected;

  @override
  AnimatedWidgetBaseState<CustomLottie> createState() => _CustomLottieState();
}

class _CustomLottieState extends AnimatedWidgetBaseState<CustomLottie> {
  @override
  Widget build(BuildContext context) {
    if (!widget.isSelected) {
      return widget.nonSelectedWidget;
    }

    return Lottie.asset(
      widget.path,
      animate: false,
      controller: _anim?.animate(animation),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _anim =
        visitor(
              _anim,
              widget.isSelected ? 1.0 : 0.0,
              (targetValue) => Tween<double>(begin: targetValue),
            )
            as Tween<double>?;
  }

  Tween<double>? _anim;
}

class BuilderAny<T> extends StatelessWidget {
  const BuilderAny({super.key, required this.builder, required this.any});
  final T any;

  final Widget Function(BuildContext context, T any) builder;

  @override
  Widget build(BuildContext context) {
    return builder(context, any);
  }
}

class LimitAndHistoryButtonView extends StatelessWidget {
  const LimitAndHistoryButtonView({super.key, this.padding});

  final double? padding;

  @override
  Widget build(BuildContext context) {
    Widget icon;

    if ((Global.isSubscription.value == "1")) {
      icon = SvgPicture.asset(
        ImagePath.historyIcon,
        color: AppColors().darkAndWhite,
      );
    } else {
      icon = Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    _logo(
                      Global.isSubscription.value == "1"
                          ? const Color(0xff3BDBD4)
                          : Global.chatLimit.value > 0
                          ? AppColors().darkAndWhite
                          : AppColors().darkAndWhite.changeOpacity(0.5),
                    ),
                    SizedBox(width: 2.px),
                    _logo(
                      Global.isSubscription.value == "1"
                          ? const Color(0xff3BDBD4)
                          : Global.chatLimit.value > 1
                          ? AppColors().darkAndWhite
                          : AppColors().darkAndWhite.changeOpacity(0.5),
                    ),
                  ],
                ),
                SizedBox(height: 2.px),
                Row(
                  children: [
                    _logo(
                      Global.isSubscription.value == "1"
                          ? const Color(0xff3BDBD4)
                          : Global.chatLimit.value > 2
                          ? AppColors().darkAndWhite
                          : AppColors().darkAndWhite.changeOpacity(0.5),
                    ),
                    SizedBox(width: 2.px),
                    _logo(
                      Global.isSubscription.value == "1"
                          ? const Color(0xff3BDBD4)
                          : Global.chatLimit.value > 3
                          ? AppColors().darkAndWhite
                          : AppColors().darkAndWhite.changeOpacity(0.5),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // if (Global.isSubscription.value == "0") SizedBox(width: 5.px),
          // Obx(() => (Global.isSubscription.value == "0")
          //     ? AppText(
          //         Languages.of(Get.context!)!.pro,
          //         fontSize: 15.px,
          //         fontFamily: FontFamily.helveticaBold,
          //         color: const Color(0xff3BDBD4),
          //       )
          //     : const SizedBox()),
          // SizedBox(width: padding ?? 16.px),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.only(right: 8),
      child: IconButton(
        onPressed: () {
          if (Global.isSubscription.value == "1") {
            // Get.delete<PurchaseController>();
            // Get.toNamed(Routes.PURCHASE)!.then((value) {
            //   if (value != null && value == "plan_purchase") {}
            // });
            Get.delete<ChatHistoryController>();
            Get.toNamed(Routes.CHAT_HISTORY);
          } else {
            Get.find<ChatGptController>().creditBottomSheet();
          }
        },
        // color: Colors.transparent,
        // padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 10.px),
        icon: icon,
      ),
    );
  }

  Widget _logo(Color? color) {
    return Container(
      padding: EdgeInsets.all(2.px),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2.5.px),
      ),
      child: Container(
        height: 3.px,
        width: 3.px,
        decoration: BoxDecoration(
          color: AppColors().backgroundColor1,
          borderRadius: BorderRadius.circular(1.px),
        ),
      ),
    );
  }
}
