import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/common_widget/modern_card.dart';
import 'package:chatsy/app/helper/get_storage_data.dart';
import 'package:chatsy/app/modules/AssistantsPage/views/assistants_page_view.dart';
import 'package:chatsy/app/modules/bottom_navigation/controllers/bottom_navigation_controller.dart';
import 'package:chatsy/app/modules/chat_gpt/controllers/chat_gpt_controller.dart';
import 'package:chatsy/app/modules/chat_gpt/views/chat_gpt_view.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';

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

class ImprovedHomeView extends GetView<HomeController> {
  const ImprovedHomeView({super.key});

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
                      // Welcome Header
                      SliverToBoxAdapter(
                        child: _buildWelcomeHeader(context),
                      ),
                      
                      // Quick Actions
                      SliverToBoxAdapter(
                        child: _buildQuickActions(context),
                      ),
                      
                      // Templates Section
                      SliverToBoxAdapter(
                        child: _buildTemplatesHeader(context),
                      ),
                      
                      // Templates Content
                      if (bottomNavigationController.tabController != null)
                        SliverToBoxAdapter(
                          child: _buildTemplatesTabs(context),
                        ),
                      
                      // Templates Grid
                      SliverFillRemaining(
                        hasScrollBody: true,
                        child: _buildTemplatesGrid(context),
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

  Widget _buildWelcomeHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to Chatsy!',
            style: TextStyle(
              fontSize: 28.px,
              fontWeight: FontWeight.bold,
              color: AppColors().darkAndWhite,
            ),
          ),
          SizedBox(height: 8.px),
          Text(
            'Your AI-powered assistant is ready to help',
            style: TextStyle(
              fontSize: 16.px,
              color: AppColors.grey1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final quickActions = [
      {
        'title': 'New Chat',
        'subtitle': 'Start a conversation',
        'icon': Icons.chat_bubble_outline,
        'color': AppColors.primary,
        'onTap': () => Get.toNamed(Routes.NEW_CHAT),
      },
      {
        'title': 'Image Scan',
        'subtitle': 'Extract text from images',
        'icon': Icons.camera_alt_outlined,
        'color': AppColors.accent,
        'onTap': () => Get.toNamed(Routes.IMAGE_SCAN),
      },
      {
        'title': 'Generate Image',
        'subtitle': 'Create with AI',
        'icon': Icons.auto_awesome,
        'color': AppColors.info,
        'onTap': () => Get.toNamed(Routes.IMAGE_GENERATION),
      },
      {
        'title': 'Voice Chat',
        'subtitle': 'Speak with AI',
        'icon': Icons.mic_outlined,
        'color': AppColors.success,
        'onTap': () => Get.toNamed(Routes.VOICE_PAGE),
      },
    ];

    return Container(
      height: 120.px,
      margin: EdgeInsets.symmetric(horizontal: 16.px),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: quickActions.length,
        itemBuilder: (context, index) {
          final action = quickActions[index];
          return Container(
            width: 100.px,
            margin: EdgeInsets.only(right: 12.px),
            child: ModernCard(
              onTap: action['onTap'] as VoidCallback?,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.px),
                    decoration: BoxDecoration(
                      color: (action['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.px),
                    ),
                    child: Icon(
                      action['icon'] as IconData,
                      color: action['color'] as Color,
                      size: 24.px,
                    ),
                  ),
                  SizedBox(height: 8.px),
                  Text(
                    action['title'] as String,
                    style: TextStyle(
                      fontSize: 12.px,
                      fontWeight: FontWeight.w600,
                      color: AppColors().darkAndWhite,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTemplatesHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.px, 24.px, 16.px, 16.px),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            Languages.of(context)!.templates,
            style: TextStyle(
              fontSize: 20.px,
              fontWeight: FontWeight.bold,
              color: AppColors().darkAndWhite,
            ),
          ),
          TextButton(
            onPressed: () {
              // Show all templates
            },
            child: Text(
              'See All',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplatesTabs(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.px),
      child: Obx(
        () => TabBar(
          isScrollable: true,
          labelColor: AppColors.white,
          dividerColor: Colors.transparent,
          tabAlignment: TabAlignment.start,
          indicatorColor: Colors.transparent,
          padding: EdgeInsets.zero,
          indicatorSize: TabBarIndicatorSize.tab,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          controller: bottomNavigationController.tabController,
          labelStyle: TextStyle(
            height: 1,
            fontSize: 14.px,
            fontWeight: FontWeight.w700,
            fontFamily: FontFamily.helveticaRegular,
          ),
          indicatorPadding: EdgeInsets.symmetric(vertical: 5.px),
          tabs: bottomNavigationController.promptTitleList
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
    );
  }

  Widget _buildTemplatesGrid(BuildContext context) {
    if (bottomNavigationController.tabController == null) {
      return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 16.px),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          childAspectRatio: 1.5.px,
          crossAxisSpacing: 11.px,
          maxCrossAxisExtent: 250,
          mainAxisExtent: 100,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return _buildLoadingCard();
        },
      );
    }

    return Obx(() {
      return TabBarView(
        controller: bottomNavigationController.tabController,
        children: bottomNavigationController.promptTitleList.map((e) {
          return GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              childAspectRatio: 1.5.px,
              crossAxisSpacing: 11.px,
              maxCrossAxisExtent: 250,
              mainAxisExtent: 100,
            ),
            itemCount: e.prompts!.length,
            itemBuilder: (context, index) {
              Prompts prompts = e.prompts![index];
              return _buildTemplateCard(prompts);
            },
          );
        }).toList(),
      );
    });
  }

  Widget _buildTemplateCard(Prompts prompts) {
    var needToPurchase = (Global.isSubscription.value != "1" && prompts.isPremium == "1") ||
        (Global.isSubscription.value != "1" && Global.chatLimit.value <= 0);

    return ModernCard(
      onTap: () {
        if (needToPurchase) {
          Get.find<ChatGptController>().goToPurchasePage();
          return;
        }

        HapticFeedback.mediumImpact();
        GetStorageData().saveObject(GetStorageData().prompts, prompts);

        if (prompts.stringMatch == "translation") {
          Get.toNamed(Routes.TRANSLATE);
        } else {
          List<Prompts> prompts2 = [];
          prompts2.add(prompts);
          if (prompts.formFields!.isNotEmpty) {
            Get.toNamed(Routes.TEMPLATE_PAGE, arguments: prompts2[0]);
          } else {
            Get.delete<PromptChatController>();
            Get.toNamed(Routes.PROMPT_CHAT, arguments: {
              "promptId": prompts.promptId ?? "0",
              "name": prompts.name ?? "",
              "question": "",
            });
          }
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.px,
                height: 40.px,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.px),
                  color: AppColors.primary.withOpacity(0.1),
                ),
                child: CachedNetworkImage(
                  imageUrl: prompts.img!,
                  progressIndicatorBuilder: (context, url, progress) =>
                      _buildLoadingCard(),
                  errorWidget: (context, url, error) => Icon(
                    Icons.extension,
                    color: AppColors.primary,
                    size: 20.px,
                  ),
                ),
              ),
              if (needToPurchase) ...[
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.px, vertical: 2.px),
                  decoration: BoxDecoration(
                    color: AppColors.warning,
                    borderRadius: BorderRadius.circular(8.px),
                  ),
                  child: Text(
                    'PRO',
                    style: TextStyle(
                      fontSize: 8.px,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ],
          ),
          SizedBox(height: 8.px),
          Expanded(
            child: Text(
              prompts.name ?? '',
              style: TextStyle(
                fontSize: 14.px,
                fontWeight: FontWeight.w600,
                color: AppColors().darkAndWhite,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCard() {
    return ModernCard(
      child: Column(
        children: [
          Container(
            width: 40.px,
            height: 40.px,
            decoration: BoxDecoration(
              color: AppColors.greyLight,
              borderRadius: BorderRadius.circular(8.px),
            ),
          ),
          SizedBox(height: 8.px),
          Container(
            height: 12.px,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.greyLight,
              borderRadius: BorderRadius.circular(6.px),
            ),
          ),
        ],
      ),
    );
  }
}

