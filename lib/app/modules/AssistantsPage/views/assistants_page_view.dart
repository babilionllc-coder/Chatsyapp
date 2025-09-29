import 'package:chatsy/Customs/buttons.dart';
import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/helper/image_path.dart';
import 'package:chatsy/app/modules/home/views/home_view.dart';
import 'package:chatsy/main.dart';
import 'package:chatsy/service/core/exception.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';

// import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../padding.dart';
import '../../../Localization/local_language.dart';
import '../../../helper/Global.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/font_family.dart';
import '../../../routes/app_pages.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../chat_gpt/controllers/chat_gpt_controller.dart';
import '../../chat_gpt/views/chat_gpt_view.dart';
import '../../newChat/controllers/new_chat_controller.dart';
import '../controllers/assistants_page_controller.dart';

class AssistantsPageView extends GetView<AssistantsPageController> {
  const AssistantsPageView({super.key});

  BottomNavigationController get bottomNavigationController => Get.find();

  @override
  Widget build(BuildContext context) {
    const sliverGridDelegateWithMaxCrossAxisExtent = SliverGridDelegateWithMaxCrossAxisExtent(
      childAspectRatio: 128 / 106,
      crossAxisSpacing: 12,
      mainAxisSpacing: 8,
      maxCrossAxisExtent: 96,
      mainAxisExtent: 130,
    );

    return GetBuilder<AssistantsPageController>(
      init: AssistantsPageController(),
      autoRemove: false,
      builder: (controller) {
        return CommonScreen(
          backgroundColor: AppColors().backgroundColor1,
          toolbarHeight: 0,
          padding: EdgeInsets.zero,
          body: BuilderAny(
            builder: (context, any) {
              return Theme(
                data: Theme.of(context).copyWith(primaryColor: AppColors.blackColorIntro),
                child: any,
              );
            },
            any: Refresher(
              controller: controller.easyRefreshController,
              onRefresh: () async {
                try {
                  await controller.getAssistantData(refresh: true);
                } finally {
                  controller.easyRefreshController.finishRefresh();
                }
              },
              child: ObxAny(
                builder: (context, any) {
                  if (controller.assistantList.isEmpty) {
                    if (controller.apiState.isLoading) {
                      return GridView.builder(
                        gridDelegate: sliverGridDelegateWithMaxCrossAxisExtent,
                        itemCount: 40,
                        itemBuilder: (context, index) {
                          return Center(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: progressIndicatorView().marginAll(8),
                            ),
                          );
                        },
                      ).marginSymmetric(horizontal: 16.px);
                    }
                    if (controller.apiState.isFailed) {
                      return PaddingH16(
                        child: FailedWidget(
                          state: controller.apiState.failedState,
                          onRetry: controller.getAssistantData,
                        ),
                      );
                    }
                  }
                  return any;
                },
                any: CustomScrollView(
                  controller: controller.scrollController,
                  slivers: [
                    SliverList.list(
                      children: [
                        SizedBox(height: 15.px),
                        AppText(
                          Languages.of(context)!.aiAssistants,
                          fontSize: 16.px,
                          fontFamily: FontFamily.helveticaBold,
                        ).marginOnly(bottom: 12.px),
                      ],
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(bottom: 16),
                      sliver: Obx(() {
                        return SliverGrid.builder(
                          itemCount:
                              controller.assistantList.isEmpty
                                  ? 10
                                  : controller.assistantList.length,
                          gridDelegate: sliverGridDelegateWithMaxCrossAxisExtent,
                          itemBuilder: (context, index) {
                            var data = controller.assistantList[index];

                            Widget imageWidget = CachedNetworkImage(
                              imageUrl: data.assistantImg ?? "",
                              progressIndicatorBuilder:
                                  (context, url, progress) =>
                                      progressIndicatorView(borderRadius: 12.px),
                              errorWidget:
                                  (context, url, uri) => errorWidgetView().paddingAll(8.px),
                            );

                            if (data.isLock == '1' && Global.isSubscription.value != '1') {
                              imageWidget = Stack(
                                alignment: Alignment.center,
                                children: [imageWidget, DiamondBadge()],
                              );
                            }
                            /* if (data.userId case != null && != '0') {
                              imageWidget = Stack(
                                alignment: Alignment.center,
                                children: [
                                  imageWidget,
                                  RemoveAssistantButton(
                                    onTap:
                                        () => controller.deleteAssistant(
                                          data.assistantId,
                                          index: index,
                                        ),
                                  ),
                                ],
                              );
                            } */

                            return GestureDetector(
                              onLongPress: () {
                                if (data.userId case != null && != '0') {
                                  controller.deleteAssistant(data.assistantId, index: index);
                                  return;
                                }
                              },
                              onTap: () {
                                if (data.isLock == '1' && Global.isSubscription.value != "1") {
                                  Get.find<ChatGptController>().goToPurchasePage();

                                  return;
                                }
                                Get.delete<NewChatController>();

                                Get.toNamed(
                                  Routes.NEW_CHAT,
                                  arguments: {
                                    HttpUtil.isAssistant: true,
                                    HttpUtil.assistantData: data,
                                  },
                                );
                              },
                              child: Column(
                                spacing: 4,
                                children: [
                                  Center(
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Container(
                                        margin: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColors().bgColor,
                                          borderRadius: BorderRadius.circular(12.px),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12.px),
                                          child: imageWidget,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: AppText(
                                      data.assistantTitle ?? "",
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      fontSize: 13.px,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }),
                    ),
                    SliverToBoxAdapter(
                      child: Obx(() {
                        if (controller.end.value ||
                            controller.assistantList.isEmpty ||
                            !controller.apiState.isLoading) {
                          return SizedBox();
                        }
                        return SizedBox.square(dimension: 80, child: Center(child: AppLoader()));
                      }),
                    ),
                  ],
                ).marginSymmetric(horizontal: 16.px),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DiamondBadge extends StatelessWidget {
  const DiamondBadge({super.key, this.top = 4, this.right = 4});

  final double top;
  final double right;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      child: SizedBox.square(
        dimension: 20,
        child: DecoratedBox(
          decoration: BoxDecoration(color: AppColors().whiteAndDark, shape: BoxShape.circle),
          child: Center(
            child: SizedBox.square(
              dimension: 12,
              child: Image.asset(ImagePath.diamond, height: 20.px),
            ),
          ),
        ),
      ),
    );
  }
}

class RemoveAssistantButton extends StatelessWidget {
  const RemoveAssistantButton({super.key, this.top = 4, this.right = 4, this.onTap});

  final double top;
  final double right;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox.square(
          dimension: 20,
          child: DecoratedBox(
            decoration: BoxDecoration(color: AppColors().whiteAndDark, shape: BoxShape.circle),
            child: Center(
              child: SizedBox.square(
                dimension: 12,
                child: Image.asset(ImagePath.delete, height: 20.px, color: Colors.red),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

typedef ObxAnyBuilder<T> = Widget Function(BuildContext context, T any);

class ObxAny<T> extends StatelessWidget {
  const ObxAny({super.key, required this.any, required this.builder});

  final T any;
  final ObxAnyBuilder<T> builder;

  @override
  Widget build(BuildContext context) {
    return Obx(() => builder(context, any));
  }
}

class FailedWidget extends StatelessWidget {
  const FailedWidget({super.key, required this.state, required this.onRetry});

  final FailedState state;

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          state.error.title,
          style: HelveticaStyles.of(context).s20w500,
          textAlign: TextAlign.center,
        ),
        Text(
          state.messageHelper,
          style: HelveticaStyles.of(context).s16w500,
          textAlign: TextAlign.center,
        ),
        if (state.isRetirable) ...[
          const Gap(16),
          AppButton(onPressed: onRetry, child: Text(Languages.of(context)!.retry)),
        ],
      ],
    );
  }
}
