import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatsy/Customs/buttons.dart';
import 'package:chatsy/app/common_widget/common_container.dart';
import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/common_widget/custom_image_view.dart';
import 'package:chatsy/app/common_widget/rx_common_model.dart';
import 'package:chatsy/app/helper/Global.dart';
import 'package:chatsy/app/helper/image_path.dart';
import 'package:chatsy/app/modules/AssistantsPage/controllers/assistants_page_controller.dart';
import 'package:chatsy/app/modules/AssistantsPage/views/assistants_page_view.dart';
import 'package:chatsy/app/modules/OfferScreen/views/offer_screen_view.dart';
import 'package:chatsy/app/modules/home/views/home_view.dart';
import 'package:chatsy/app/routes/app_pages.dart';
import 'package:chatsy/app_border_radius.dart';
import 'package:chatsy/app_edge_insets.dart';
import 'package:chatsy/extension.dart';
import 'package:chatsy/gen/assets.gen.dart';
import 'package:chatsy/main.dart';
import 'package:flutter/foundation.dart';
import 'package:gap/gap.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:text_scroll/text_scroll.dart';

import '../../../Localization/local_language.dart';
import '../../../api_repository/loading.dart';
import '../../../common_widget/comman_text_field.dart';
import '../../../common_widget/common_button.dart';
import '../../../common_widget/common_show_model_bottom_sheet.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/font_family.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../home/controllers/user_profile_model.dart';
import '../../newChat/controllers/new_chat_controller.dart';
import '../controllers/chat_gpt_controller.dart';

class ChatGptView extends GetView<ChatGptController> {
  const ChatGptView({super.key});

  @override
  Widget build(BuildContext context) {
    var bottomNavigationController = Get.put(BottomNavigationController());

    controller.uploadAndAsk = [
      RxCommonModel(
        title: Languages.of(context)!.uploadYourDocument,
        subTitle: Languages.of(context)!.clickTheUploadButtonAndSelectYourFile,
        image: ImagePath.upload,
      ),
      RxCommonModel(
        title: Languages.of(context)!.askQuestion,
        subTitle: Languages.of(context)!.typeInYourQueryBboutTheDocument,
        image: ImagePath.askQuestion,
      ),
      RxCommonModel(
        title: Languages.of(context)!.getAnswer,
        subTitle: Languages.of(context)!.receiveInstantAIGeneratedResponses,
        image: ImagePath.getAnswer,
      ),
    ];
    controller.visionScan = [
      RxCommonModel(
        title: Languages.of(context)!.scanDocument,
        subTitle: Languages.of(context)!.captureYourDocumentOrImage,
        image: ImagePath.scanDocument,
      ),
      RxCommonModel(
        title: Languages.of(context)!.askQuestion,
        subTitle: Languages.of(context)!.enterYourQuestion,
        image: ImagePath.askQuestion,
      ),
      RxCommonModel(
        title: Languages.of(context)!.getInsights,
        subTitle: Languages.of(context)!.receiveInstantAIGeneratedAnswers,
        image: ImagePath.getInsights,
      ),
    ];
    controller.textScan = [
      RxCommonModel(
        title: Languages.of(context)!.uploadOrCapture,
        subTitle: Languages.of(context)!.uploadAnyDocumentOrPicture,
        image: ImagePath.upload,
      ),
      RxCommonModel(
        title: Languages.of(context)!.askAnything,
        subTitle: Languages.of(context)!.askAICHATSYWhatDocument,
        image: ImagePath.askQuestion,
      ),
      RxCommonModel(
        title: Languages.of(context)!.getRespondOnScan,
        subTitle: Languages.of(context)!.getQuickResponsesInSeconds,
        image: ImagePath.getAnswer,
      ),
    ];
    controller.imageGeneration = [
      RxCommonModel(
        title: Languages.of(context)!.describeImage,
        subTitle: Languages.of(context)!.enterBriefDescriptionOfTheImageYouWant,
        image: ImagePath.describeImage,
      ),
      RxCommonModel(
        title: Languages.of(context)!.selectStyle,
        subTitle: Languages.of(context)!.pickStyleOrTemplateThatSuitsYourVision,
        image: ImagePath.selectStyle,
      ),
      RxCommonModel(
        title: Languages.of(context)!.generate,
        subTitle: Languages.of(context)!.clickToCreateYourImage,
        image: ImagePath.generates,
      ),
    ];
    controller.summarizeWeb = [
      RxCommonModel(
        title: Languages.of(context)!.addWebsiteURL,
        subTitle: Languages.of(context)!.pasteTheWebsiteLink,
        image: ImagePath.lightLink,
      ),
      RxCommonModel(
        title: Languages.of(context)!.clickSummarize,
        subTitle: Languages.of(context)!.hitTheSummarizeButtonStart,
        image: ImagePath.askQuestion,
      ),
      RxCommonModel(
        title: Languages.of(context)!.readSummary,
        subTitle: Languages.of(context)!.getConciseSummaryWebpage,
        image: ImagePath.generates,
      ),
    ];
    controller.summarizePDF = [
      RxCommonModel(
        title: Languages.of(context)!.uploadPDF,
        subTitle: Languages.of(context)!.uploadAnyDocumentOrPdf,
        image: ImagePath.pdf,
      ),
      RxCommonModel(
        title: Languages.of(context)!.askAnything,
        subTitle: Languages.of(context)!.askAICHATSYWhatDocument,
        image: ImagePath.selectStyle,
      ),
      RxCommonModel(
        title: Languages.of(context)!.getResponses,
        subTitle: Languages.of(context)!.getQuickResponsesInSeconds,
        image: ImagePath.generates,
      ),
    ];
    controller.chatGPT = [
      RxCommonModel(
        title: Languages.of(context)!.knowledgeBase,
        subTitle: Languages.of(context)!.deliversAccurateInformativeResponses,
        image: ImagePath.knowledge,
      ),
      RxCommonModel(
        title: Languages.of(context)!.creativity,
        subTitle: Languages.of(context)!.helpsGenerateIdeasAndWriteContent,
        image: ImagePath.creativity,
      ),
      RxCommonModel(
        title: Languages.of(context)!.efficiency,
        subTitle: Languages.of(context)!.providesQuickReliableAnswers,
        image: ImagePath.efficiency,
      ),
    ];
    controller.gpt4o = [
      RxCommonModel(
        title: Languages.of(context)!.enhancedUnderstanding,
        subTitle: Languages.of(context)!.deliversMoreAccurateResponses,
        image: ImagePath.enhanced,
      ),
      RxCommonModel(
        title: Languages.of(context)!.creativeAssistance,
        subTitle: Languages.of(context)!.generatesIdeasAndContentEffortlessly,
        image: ImagePath.creative,
      ),
      RxCommonModel(
        title: Languages.of(context)!.realTimeUpdates,
        subTitle: Languages.of(context)!.accessesLiveInfoForRealTimeResponses,
        image: ImagePath.realTime,
      ),
    ];
    controller.palm = [
      RxCommonModel(
        title: Languages.of(context)!.advancedPatternRecognition,
        subTitle: Languages.of(context)!.enhancesPatternRecognitionCapabilities,
        image: ImagePath.advanced,
      ),
      RxCommonModel(
        title: Languages.of(context)!.contextualUnderstanding,
        subTitle: Languages.of(context)!.improvesModelsComprehensionOfContext,
        image: ImagePath.contextual,
      ),
      RxCommonModel(
        title: Languages.of(context)!.enhancedPerformance,
        subTitle:
            Languages.of(context)!.boostOverallModelCapabilitiesEffectively,
        image: ImagePath.enhancedPerformance,
      ),
    ];
    controller.gemini = [
      RxCommonModel(
        title: Languages.of(context)!.smoothInteractions,
        subTitle: Languages.of(context)!.enablesIntuitiveUserEngagement,
        image: ImagePath.smoothInteractions,
      ),
      RxCommonModel(
        title: Languages.of(context)!.efficientTasks,
        subTitle: Languages.of(context)!.enhancesProductivity,
        image: ImagePath.efficientTasks,
      ),
      RxCommonModel(
        title: Languages.of(context)!.advancedIntegration,
        subTitle: Languages.of(context)!.cuttingEdgeAIOptimization,
        image: ImagePath.advancedIntegration,
      ),
    ];

    return GetBuilder<ChatGptController>(
      init: ChatGptController(),
      builder: (controller) {
        var hasLifeTimePlan = controller.purchaseList.any(
          (element) => element.productId == 'com.aichatsy.app.lifetime2',
        );
        return CommonScreen(
          toolbarHeight: 0,
          backgroundColor: AppColors().backgroundColor1,
          body: Column(
            children: [
              Expanded(
                child: Theme(
                  data: ThemeData(primaryColor: AppColors.blackColorIntro),
                  child: Refresher(
                    controller: controller.easyRefreshController,
                    onRefresh: () async {
                      try {
                        await bottomNavigationController.getUserProfileAPI(
                          isLoading: false,
                        );
                      } finally {
                        Loading.dismiss();
                        controller.easyRefreshController.finishRefresh();
                      }
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.px),
                      child: CustomScrollView(
                        // padding: EdgeInsets.symmetric(horizontal: 16.px),
                        // shrinkWrap: true,
                        slivers: [
                          SliverList.list(
                            children: [
                              SizedBox(height: 15.px),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (Global.isSubscription.value != "1") {
                                        if (bottomNavigationController
                                                .isFirstTime !=
                                            null) {
                                          OfferScreenView.route(
                                            arguments: {
                                              "type": Constants.offer15,
                                              "second":
                                                  (const Duration(
                                                        minutes: 4,
                                                      ).inSeconds -
                                                      controller.convertToSeconds(
                                                        bottomNavigationController
                                                            .remainingTimeValue
                                                            .value,
                                                      )),
                                            },
                                          )?.then((value) {
                                            if (value == "plan_purchase") {
                                              bottomNavigationController
                                                  .getUserProfileAPI(
                                                    isLoading: true,
                                                  );
                                            }
                                          });
                                        } else {
                                          if (hasLifeTimePlan) {
                                            controller.goToPurchasePage(
                                              arguments: {
                                                "plan_id":
                                                    'com.aichatsy.app.lifetime2',
                                              },
                                            );
                                            return;
                                          }
                                          controller.goToPurchasePage(
                                            arguments: {
                                              "plan_id":
                                                  controller.purchaseList
                                                      .firstWhereOrNull(
                                                        (element) =>
                                                            element.name ==
                                                            'weekly',
                                                      )
                                                      ?.productId ??
                                                  "",
                                            },
                                          );
                                        }
                                      } else if (kDebugMode) {
                                        controller.goToPurchasePage(
                                          arguments: {
                                            "plan_id":
                                                'com.aichatsy.app.lifetime2',
                                          },
                                        );
                                      }
                                    },
                                    child: CommonContainer(
                                      color: AppColors.primary,
                                      padding: EdgeInsets.all(12.px),
                                      radius: 10.px,
                                      child:
                                          (Global.isSubscription.value != "1" &&
                                                  bottomNavigationController
                                                          .isFirstTime !=
                                                      null)
                                              ? Row(
                                                children: [
                                                  Image.asset(
                                                    ImagePath.icGift,
                                                    height: 36.px,
                                                  ),
                                                  SizedBox(width: 12.px),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      AppText(
                                                        Languages.of(
                                                          context,
                                                        )!.yourGift,
                                                        fontSize: 12,
                                                        color: AppColors.white,
                                                      ),
                                                      AppText(
                                                        Languages.of(
                                                          context,
                                                        )!.activated,
                                                        fontSize: 14,
                                                        color: AppColors.white,
                                                        fontFamily:
                                                            FontFamily
                                                                .helveticaBold,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: 30.px),
                                                  Expanded(
                                                    child: Obx(() {
                                                      return Row(
                                                        children: [
                                                          Expanded(
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding:
                                                                  EdgeInsets.symmetric(
                                                                    vertical:
                                                                        8.px,
                                                                  ),
                                                              decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .white
                                                                    .changeOpacity(
                                                                      0.3,
                                                                    ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      10.px,
                                                                    ),
                                                              ),
                                                              child: AppText(
                                                                bottomNavigationController
                                                                    .remainingTimeValue
                                                                    .value
                                                                    .split(":")
                                                                    .first,
                                                                color:
                                                                    AppColors
                                                                        .white,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 5.px),
                                                          const AppText(
                                                            ":",
                                                            color:
                                                                AppColors.white,
                                                          ),
                                                          SizedBox(width: 5.px),
                                                          Expanded(
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding:
                                                                  EdgeInsets.symmetric(
                                                                    vertical:
                                                                        8.px,
                                                                  ),
                                                              decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .white
                                                                    .changeOpacity(
                                                                      0.3,
                                                                    ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      10.px,
                                                                    ),
                                                              ),
                                                              child: AppText(
                                                                bottomNavigationController
                                                                    .remainingTimeValue
                                                                    .value
                                                                    .split(
                                                                      ":",
                                                                    )[1],
                                                                color:
                                                                    AppColors
                                                                        .white,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 5.px),
                                                          const AppText(
                                                            ":",
                                                            color:
                                                                AppColors.white,
                                                          ),
                                                          SizedBox(width: 5.px),
                                                          Expanded(
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              padding:
                                                                  EdgeInsets.symmetric(
                                                                    vertical:
                                                                        8.px,
                                                                  ),
                                                              decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .white
                                                                    .changeOpacity(
                                                                      0.3,
                                                                    ),
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                      10.px,
                                                                    ),
                                                              ),
                                                              child: AppText(
                                                                bottomNavigationController
                                                                    .remainingTimeValue
                                                                    .value
                                                                    .split(":")
                                                                    .last,
                                                                color:
                                                                    AppColors
                                                                        .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    }),
                                                  ),
                                                ],
                                              )
                                              : Row(
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                      6.px,
                                                    ),
                                                    decoration:
                                                        const BoxDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                    child: Image.asset(
                                                      Global
                                                                  .isSubscription
                                                                  .value ==
                                                              "1"
                                                          ? ImagePath.diamond
                                                          : ImagePath.star,
                                                      height: 20.px,
                                                    ),
                                                  ),
                                                  SizedBox(width: 12.px),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        AppText(
                                                          Global
                                                                      .isSubscription
                                                                      .value ==
                                                                  "1"
                                                              ? Languages.of(
                                                                context,
                                                              )!.proAccount
                                                              : hasLifeTimePlan
                                                              ? Languages.of(
                                                                context,
                                                              )!.specialOffer
                                                              : Languages.of(
                                                                context,
                                                              )!.freeAccount,
                                                          fontSize: 16.px,
                                                          color:
                                                              AppColors.white,
                                                          fontFamily:
                                                              FontFamily
                                                                  .helveticaBold,
                                                        ),
                                                        if (Global
                                                                .isSubscription
                                                                .value !=
                                                            "1")
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                child: AppText(
                                                                  hasLifeTimePlan
                                                                      ? Languages.of(
                                                                        context,
                                                                      )!.purchaseLifetimePlanAtNoCost
                                                                      : Languages.of(
                                                                        context,
                                                                      )!.claimYourFreeTrial,
                                                                  fontSize:
                                                                      14.px,
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                ),

                                                                /* AppRichText(
                                                              textAlign: TextAlign.start,
                                                              firstText: "${Languages.of(context)!.subscribeForJust} ",
                                                              firstFontSize: 16.px,
                                                              firstTextColor: AppColors.white.changeOpacity(0.7),
                                                              secondText: "${controller.purchaseList.firstWhereOrNull((element) => element.name == 'weekly')?.price ?? ""} ${Languages.of(context)!.weekly}",
                                                              secondFontSize: 16.px,
                                                              secondTextFontFamily: FontFamily.helveticaBold,
                                                            ), */
                                                              ),
                                                              // AppText(Languages.of(context)!.offForYearlyPlan, color: AppColors.white),
                                                              const Icon(
                                                                Icons
                                                                    .keyboard_arrow_right_outlined,
                                                                color:
                                                                    AppColors
                                                                        .white,
                                                              ),
                                                            ],
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                    ),
                                  ),
                                  SizedBox(height: 30.px),
                                  AppText(
                                    Languages.of(context)!.aIModules,
                                    fontSize: 16.px,
                                    fontFamily: FontFamily.helveticaBold,
                                  ).marginOnly(bottom: 12.px),
                                ],
                              ),
                            ],
                          ),
                          // if (bottomNavigationController.selectAiModelList.isNotEmpty)
                          SliverGrid.builder(
                            // shrinkWrap: true,
                            // padding: EdgeInsets.zero,
                            // physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                (bottomNavigationController
                                        .selectAiModelList
                                        .isEmpty)
                                    ? 4
                                    : bottomNavigationController
                                        .selectAiModelList
                                        .length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisExtent: 90.px,
                                  mainAxisSpacing: 16.px,
                                  crossAxisSpacing: 20.px,
                                ),
                            itemBuilder: (context, index) {
                              ToolsModel model = ToolsModel();
                              if (bottomNavigationController
                                  .selectAiModelList
                                  .isNotEmpty) {
                                model =
                                    bottomNavigationController
                                        .selectAiModelList[index];
                              }

                              return (bottomNavigationController
                                      .selectAiModelList
                                      .isEmpty)
                                  ? progressIndicatorView(
                                    width: 45.px,
                                    height: 45.px,
                                  ).paddingOnly(
                                    bottom: 25.px,
                                    right: 10.px,
                                    left: 10.px,
                                    top: 10.px,
                                  )
                                  : AiModelWidget(model: model);
                            },
                          ),
                          SliverGap(20),

                          // if (bottomNavigationController.toolsListModel.isNotEmpty)
                          SliverToBoxAdapter(
                            child: AppText(
                              Languages.of(context)!.tools,
                              fontSize: 16.px,
                              fontFamily: FontFamily.helveticaBold,
                            ).marginOnly(bottom: 12.px),
                          ),
                          SliverGrid.builder(
                            // shrinkWrap: true,
                            // padding: EdgeInsets.zero,
                            itemCount:
                                bottomNavigationController
                                        .toolsListModel
                                        .isEmpty
                                    ? 8
                                    : bottomNavigationController
                                        .toolsListModel
                                        .length,
                            // physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisExtent: 90.px,
                                  mainAxisSpacing: 16.px,
                                  crossAxisSpacing: 20.px,
                                ),
                            itemBuilder: (context, index) {
                              ToolsModel model = ToolsModel();
                              if (bottomNavigationController
                                      .toolsListModel
                                      .length >
                                  index) {
                                model =
                                    bottomNavigationController
                                        .toolsListModel[index];
                              }
                              return (bottomNavigationController
                                      .toolsListModel
                                      .isEmpty)
                                  ? progressIndicatorView(
                                    width: 45.px,
                                    height: 45.px,
                                  ).paddingOnly(
                                    bottom: 25.px,
                                    right: 10.px,
                                    left: 10.px,
                                    top: 10.px,
                                  )
                                  : GestureDetector(
                                    onTap:
                                        () =>
                                            controller.onTapTools(model: model),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding:
                                              (ImagePath.logo == model.logo ||
                                                      ImagePath.darkLogo ==
                                                          model.logo)
                                                  ? EdgeInsets.all(8.px)
                                                  : null,
                                          decoration: BoxDecoration(
                                            border:
                                                (ImagePath.logo == model.logo ||
                                                        ImagePath.darkLogo ==
                                                            model.logo)
                                                    ? Border.all(
                                                      color: AppColors()
                                                          .darkAndWhite
                                                          .changeOpacity(0.05),
                                                      width: 2,
                                                      strokeAlign:
                                                          BorderSide
                                                              .strokeAlignInside,
                                                    )
                                                    : null,
                                            borderRadius:
                                                (ImagePath.logo == model.logo ||
                                                        ImagePath.darkLogo ==
                                                            model.logo)
                                                    ? BorderRadius.circular(
                                                      10.px,
                                                    )
                                                    : null,
                                          ),
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                      (ImagePath.logo ==
                                                                  model.logo ||
                                                              ImagePath
                                                                      .darkLogo ==
                                                                  model.logo)
                                                          ? 0
                                                          : 10.px,
                                                    ),
                                                child:
                                                    model.name ==
                                                            Constants.comingSoon
                                                        ? Image.asset(
                                                          (isLight)
                                                              ? ImagePath
                                                                  .darkLogo
                                                              : ImagePath.logo,
                                                          width:
                                                              (ImagePath.logo ==
                                                                          model
                                                                              .logo ||
                                                                      ImagePath
                                                                              .darkLogo ==
                                                                          model
                                                                              .logo)
                                                                  ? 25.px
                                                                  : 45.px,
                                                          height:
                                                              (ImagePath.logo ==
                                                                          model
                                                                              .logo ||
                                                                      ImagePath
                                                                              .darkLogo ==
                                                                          model
                                                                              .logo)
                                                                  ? 25.px
                                                                  : 45.px,
                                                        )
                                                        : CachedNetworkImage(
                                                          imageUrl:
                                                              model.logo ?? "",
                                                          width: 45.px,
                                                          height: 45.px,
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
                                                                    10.px,
                                                                  ),
                                                        ),
                                              ),
                                              if (model.isPremium == '1' &&
                                                  Global.isSubscription.value !=
                                                      '1')
                                                DiamondBadge(
                                                  right: -8,
                                                  top: -8,
                                                ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 5.px),
                                        AppText(
                                          model.name ?? "",
                                          fontSize: 12.px,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5.px),
              CommonTextField(
                onTap: () {
                  if (bottomNavigationController.toolsListModel.isNotEmpty) {
                    Get.delete<NewChatController>();
                    Get.toNamed(
                      Routes.NEW_CHAT,
                      arguments: {HttpUtil.isAssistant: false},
                    );
                  } else {
                    bottomNavigationController.getUserProfileAPI();
                  }
                },
                // color: AppColors().bgColor3,
                readOnly: true,
                textInputAction: TextInputAction.done,

                // borderColor: AppColors.transparent,
                controller: TextEditingController(),
                hintText:
                    "Hi, ${utils.isValidationEmpty(getStorageData.readString(getStorageData.userName)) ? "John" : getStorageData.readString(getStorageData.userName)}! Ask anything...",
                prefixIcon: GestureDetector(
                  onTap: () async {
                    if (bottomNavigationController.toolsListModel.isNotEmpty) {
                      Get.delete<NewChatController>();
                      Get.toNamed(
                        Routes.NEW_CHAT,
                        arguments: {HttpUtil.isAssistant: false},
                      );
                    } else {
                      bottomNavigationController.getUserProfileAPI();
                    }
                  },
                  child: Image.asset(
                    ImagePath.addCircle,
                    height: 20.px,
                    width: 20.px,
                    color: AppColors().grayMix,
                  ).paddingOnly(right: 10.px),
                ),
                // suffixIconConstraints: const BoxConstraints(),
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (bottomNavigationController
                            .toolsListModel
                            .isNotEmpty) {
                          Get.delete<NewChatController>();
                          Get.toNamed(
                            Routes.NEW_CHAT,
                            arguments: {HttpUtil.isAssistant: false},
                          );
                        } else {
                          bottomNavigationController.getUserProfileAPI();
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
                      onTap: () {
                        if (bottomNavigationController
                            .toolsListModel
                            .isNotEmpty) {
                          Get.delete<NewChatController>();
                          Get.toNamed(
                            Routes.NEW_CHAT,
                            arguments: {HttpUtil.isAssistant: false},
                          );
                        } else {
                          bottomNavigationController.getUserProfileAPI();
                        }
                      },
                      child: Image.asset(
                        ImagePath.lightMic,
                        height: 20.px,
                        width: 20.px,
                        color: AppColors().grayMix,
                      ).paddingOnly(right: 10.px),
                    ),
                  ],
                ),
              ).paddingSymmetric(horizontal: 16.px),
            ],
          ),
        );
      },
    );
  }
}

class AiModelWidget extends GetView<ChatGptController> {
  const AiModelWidget({super.key, required this.model});

  final ToolsModel model;

  Future<void> onTap() async {
    var key = switch (model.modelType) {
      ModelType.gpt5Turbo => getStorageData.gpt5Turbo,
      ModelType.gpt5Pro => getStorageData.gpt5Pro,
      ModelType.gpt5Max => getStorageData.gpt5Max,
      ModelType.gemini => getStorageData.gemini,
      ModelType.deepSeek => getStorageData.deepseek,
      _ => '',
    };
    if (getStorageData.readBool(key) != null) {
      controller.goToNewChatPage(model: model);
    } else {
      return Get.bottomSheet(
        UsingFirstTimeSheet(
          onPressed: () {
            Get.back();
            getStorageData.saveBool(key, true);
            controller.goToNewChatPage(model: model);
          },
          icon: model.logo ?? '',
          title: switch (model.modelType) {
            ModelType.gpt5Turbo => 'GPT-5 Turbo',
            ModelType.gpt5Pro => 'GPT-5 Pro',
            ModelType.gpt5Max => 'GPT-5 Max',
            ModelType.gemini => AppStrings.T.gemini,
            ModelType.deepSeek => AppStrings.T.deepseek,
            _ => '',
          },
          description: switch (model.modelType) {
            ModelType.chatGPTMini => AppStrings.T.chatGPTIsYourAIAssistant,
            ModelType.chatGPT4o =>
              AppStrings.T.chatGPT4IsYourAdvancedAIAssistant,
            ModelType.gemini => AppStrings.T.geminiIsAnInnovativeAITechnology,
            ModelType.deepSeek =>
              AppStrings.T.deepseekIsAnInnovativeAITechnology,
            _ => '',
            /* null => throw UnimplementedError(),
          ModelType.summarizeDoc => throw UnimplementedError(),
          ModelType.summarizeWeb => AppStrings.T.websiteInsightsWithAIChatSY,
          ModelType.imageScan => AppStrings.T.scanDocumentsImages,
          ModelType.textScan => AppStrings.T.scanAnyText,
          ModelType.imageGeneration => AppStrings.T.transformYourVisionIntoArt,
          ModelType.youtubeSummarize =>
            AppStrings.T.searchAndAskAboutYouTubeVideoContent,
          ModelType.realTimeWeb => throw UnimplementedError(), */
          },
          type: model.type ?? '',
          benefits: switch (model.modelType) {
            ModelType.chatGPTMini => [
              (
                title: AppStrings.T.knowledgeBase,
                desc: AppStrings.T.deliversAccurateInformativeResponses,
                icon: Assets.images.knowledge.path,
              ),
              (
                title: AppStrings.T.creativity,
                desc: AppStrings.T.helpsGenerateIdeasAndWriteContent,
                icon: Assets.images.creativity.path,
              ),
              (
                title: AppStrings.T.efficiency,
                desc: AppStrings.T.providesQuickReliableAnswers,
                icon: Assets.images.efficiency.path,
              ),
            ],
            ModelType.chatGPT4o => [
              (
                title: AppStrings.T.enhancedUnderstanding,
                desc: AppStrings.T.deliversMoreAccurateResponses,
                icon: Assets.images.enhanced.path,
              ),
              (
                title: AppStrings.T.creativeAssistance,
                desc: AppStrings.T.generatesIdeasAndContentEffortlessly,
                icon: Assets.images.creative.path,
              ),
              (
                title: AppStrings.T.realTimeUpdates,
                desc: AppStrings.T.accessesLiveInfoForRealTimeResponses,
                icon: Assets.images.realTime.path,
              ),
            ],
            ModelType.gemini => [
              (
                title: AppStrings.T.smoothInteractions,
                desc: AppStrings.T.enablesIntuitiveUserEngagement,
                icon: Assets.images.smoothInteractions.path,
              ),
              (
                title: AppStrings.T.efficientTasks,
                desc: AppStrings.T.enhancesProductivity,
                icon: Assets.images.efficientTasks.path,
              ),
              (
                title: AppStrings.T.advancedIntegration,
                desc: AppStrings.T.cuttingEdgeAIOptimization,
                icon: Assets.images.advancedIntegration.path,
              ),
            ],
            ModelType.deepSeek => [
              (
                title: AppStrings.T.smoothInteractions,
                desc: AppStrings.T.enablesIntuitiveUserEngagement,
                icon: Assets.images.smoothInteractions.path,
              ),
              (
                title: AppStrings.T.efficientTasks,
                desc: AppStrings.T.enhancesProductivity,
                icon: Assets.images.efficientTasks.path,
              ),
              (
                title: AppStrings.T.advancedIntegration,
                desc: AppStrings.T.cuttingEdgeAIOptimization,
                icon: Assets.images.advancedIntegration.path,
              ),
            ],
            _ => [],
          },
        ),
        isScrollControlled: true,
      );
    }

    /* if (model.modelType == ModelType.chatGPTMini) {
      if (getStorageData.readBool(getStorageData.chatGPT) == null) {
        controller.chatGptFirstTimeBottomSheet(
          image: model.logo ?? "",
          onTap: () {
            controller.goToNewChatPage(model: model);
          },
        );
      } else {
        controller.goToNewChatPage(model: model);
      }
    } else if (model.modelType == ModelType.chatGPT4o) {
      if (getStorageData.readBool(getStorageData.gpt4o) == null) {
        controller.gpt4oFirstTimeBottomSheet(
          image: model.logo ?? "${Constants.imageBaseUrl}ai_model/chat_gpt.png",
          onTap: () {
            controller.goToNewChatPage(model: model);
          },
        );
      } else {
        controller.goToNewChatPage(model: model);
      }
    } else if (model.modelType == ModelType.gemini) {
      if (getStorageData.readBool(getStorageData.gemini) == null) {
        controller.geminiFirstTimeBottomSheet(
          image: model.logo ?? "${Constants.imageBaseUrl}ai_model/chat_gpt.png",
          onTap: () {
            controller.goToNewChatPage(model: model);
          },
        );
      } else {
        controller.goToNewChatPage(model: model);
      }
    } else if (model.modelType == ModelType.deepSeek) {
      if (getStorageData.readBool(getStorageData.deepseek) == null) {
        controller.deepseekFirstTimeBottomSheet(
          image: model.logo ?? "${Constants.imageBaseUrl}ai_model/chat_gpt.png",
          onTap: () {
            controller.goToNewChatPage(model: model);
          },
        );
      } else {
        controller.goToNewChatPage(model: model);
      }
    } */
  }

  @override
  Widget build(BuildContext context) {
    Widget logoWidget;
    if (utils.isValidationEmpty(model.logo)) {
      logoWidget = Image.asset(
        (isLight) ? ImagePath.darkLogo : ImagePath.logo,
        width: 22.px,
        height: 22.px,
      );
    } else {
      logoWidget = ClipRRect(
        borderRadius: BorderRadius.circular(10.px),
        child: CachedNetworkImage(
          imageUrl: model.logo ?? "",
          width: 45.px,
          height: 45.px,
          progressIndicatorBuilder:
              (context, url, progress) => progressIndicatorView(),
          errorWidget:
              (context, url, uri) => errorWidgetView().paddingAll(8.px),
        ),
      );
    }

    if (model.isPremium == "1" && Global.isSubscription.value != "1") {
      logoWidget = Stack(
        clipBehavior: Clip.none,
        children: [logoWidget, DiamondBadge(right: -8, top: -8)],
      );
    }

    Widget mainWidget = GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Column(
            children: [
              logoWidget,
              // (utils.isValidationEmpty(model.logo))
              //     ? Container(
              //       decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10.px),
              //         border: Border.all(
              //           color: AppColors().darkAndWhite.changeOpacity(0.05),
              //           width: 1.px,
              //           strokeAlign: BorderSide.strokeAlignInside,
              //         ),
              //       ),
              //       padding: EdgeInsets.all(1.px),
              //       child: Container(
              //         width: 44.px,
              //         height: 44.px,
              //         padding:
              //             utils.isValidationEmpty(model.logo)
              //                 ? EdgeInsets.all(10.px)
              //                 : EdgeInsets.all(1.px),
              //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.px)),
              //         child:
              //             utils.isValidationEmpty(model.logo)
              //                 ? Image.asset(
              //                   (isLight) ? ImagePath.darkLogo : ImagePath.logo,
              //                   width: 22.px,
              //                   height: 22.px,
              //                 )
              //                 : ClipRRect(
              //                   borderRadius: BorderRadius.circular(10.px),
              //                   child: CachedNetworkImage(
              //                     imageUrl: model.logo ?? "",
              //                     width: 45.px,
              //                     height: 45.px,
              //                     progressIndicatorBuilder:
              //                         (context, url, progress) => progressIndicatorView(),
              //                     errorWidget:
              //                         (context, url, uri) => errorWidgetView().paddingAll(8.px),
              //                   ),
              //                 ),
              //       ),
              //     )
              //     : SizedBox(height: 5.px),
              SizedBox(height: 5.px),
              AppText(
                model.name ?? Constants.comingSoon,
                fontSize: 12.px,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              /*commonMarqueeText(
              model.name ?? Constants.comingSoon,
              style: MyTextStyle(textSize: 12.px, textWeight: FontWeight.w400),
            ),*/
            ],
          ),
          // if (model.isPremium == "1" || utils.isValidationEmpty(model.name)) ...[
          //   if (Global.isSubscription.value != "1") proView().marginOnly(top: 5.px),
          // ]
        ],
      ),
    );

    return mainWidget;
  }
}

commonToolsBottomSheet({
  required final String title,
  required final Widget child,
  required final String sunTitle,
  required final String btnText,
  required void Function() onTap,
  required final String placeholder,
}) {
  CommonShowModelBottomSheet(
    child: Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title,
          fontSize: 20.px,
          fontFamily: FontFamily.helveticaBold,
          color: AppColors().darkAndWhite,
        ).marginOnly(bottom: 8.px, top: 24.px),
        AppText(
          sunTitle,
          fontSize: 14.px,
          color: AppColors().darkAndWhite.changeOpacity(.70),
        ).marginOnly(bottom: 24.px),
        placeholder != ""
            ? AppText(
              placeholder,
              fontSize: 12.px,
              color: AppColors().darkAndWhite,
            ).marginOnly(bottom: 8.px)
            : const SizedBox(),
        child.marginOnly(bottom: 24.px),
        CommonButton(onTap: onTap, title: btnText, textColor: AppColors.white),
      ],
    ).marginSymmetric(horizontal: 16.px),
  );
}

class commonMarqueeText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Velocity velocity;
  final Duration pauseBetween;

  const commonMarqueeText(
    this.text, {
    super.key,
    this.style,
    this.pauseBetween = const Duration(seconds: 2),
    this.velocity = const Velocity(pixelsPerSecond: Offset(30, 0)),
  });

  @override
  Widget build(BuildContext context) {
    return TextScroll(
      text,
      key: GlobalKey(),
      velocity: velocity,
      pauseBetween: pauseBetween,
      style: style,
    );
  }
}

Widget progressIndicatorView({
  double? borderRadius,
  bool circle = false,
  double? height,
  double? width,
  Color? color,
}) {
  return Shimmer.fromColors(
    baseColor: Colors.grey.changeOpacity(0.3),
    highlightColor: AppColors().darkAndWhite.changeOpacity(0.2),
    enabled: true,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius:
            circle ? null : BorderRadius.circular(borderRadius ?? 10.px),
        shape: circle ? BoxShape.circle : BoxShape.rectangle,
        color: color ?? Colors.grey,
      ),
    ),
  );
}

Widget errorWidgetView({double? height, wight}) {
  return Image.asset(
    (isLight) ? ImagePath.darkLogo : ImagePath.logo,
    height: height,
    width: wight,
  );
}

class Section extends StatelessWidget {
  const Section({super.key, required this.description, required this.child});

  final Widget description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(padding: const EdgeInsets.all(16.0), child: child),
          Padding(
            padding: const EdgeInsets.all(16.0).copyWith(top: 0),
            child: description,
          ),
        ],
      ),
    );
  }
}

//
// class _BaseContextMenu extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ContextMenuWidget(
//       mobileMenuWidgetBuilder: DefaultMobileMenuWidgetBuilder(brightness: Brightness.dark),
//       child: const Item(
//         child: Text(
//             'Base Context Menu Ba  Basee Context Menu Base Context Menu Base Context Menu Base Context MenuBase Context Menu Base Context Menu Base Context Menu Base Context Menu Base Context MenuContext Menu Base Context Menu Base Context Menu BasMenu Base Context Menu Base Context Menu Base Context MenuBase Context Menu Base Context Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Mext Menu Base Context Menu Base Context Menu Base Context MenuContext Menu Base Context Menu Base Context Menu Base Context Menu Base Context Menu B Basee Context Menu Base Context Menu Base Context Menu Base Context MenuBase Context Menu Base Context Menu Base Context Menu Base Context Menu Base Context MenuContext Menu Base Context Menu Base Context Menu Base Context Menu Base Context Menu Base Context MenuContext Menu Base Context Menu Base Context Menu Base Context Menu Base ConContext MenuContext Menu Base Context Menu Base Context Menu Base Context Menu Base Context Menu Base Context MenuContext Menu Base Context Menu Base Context Menu Base Context Menu Base Context Menu Base Context MenuContext Menu Base Context Menu Base Context Menu Base Context Menu Base Context Menu Base Context MenuContext Menu Base Context Menu Base Context Menu Base Context Menu Base Context Menu Base Context MenuContext Menu Base Context Menu Base Context Menu Base Context Menu Base Context Menu Base Context MenuContext Menu Base Context Menu Context MenuContext Menu Base Context Menu Base Context Menu Base Context Menu Base Context Menu Base Context MenuContext Menu Base Context Menu Base Context Menu Base Context Menu Base Context Menu Base Context MenuContext Menu Base Context Menu Base Context Menu Base Context Menu Base Context Menu Base Context MenuContext Menu Base Context Menu Base Context Menu Base Context Menu Base Context Menu Base Context Menu '),
//       ),
//       menuProvider: (_) {
//         return Menu(
//           children: [
//             MenuAction(
//               title: 'Menu Item 1',
//               callback: () {},
//             ),
//             MenuAction(
//               title: 'Destructive Menu Item',
//               image: MenuImage.icon(Icons.delete),
//               attributes: const MenuActionAttributes(destructive: true),
//               callback: () {},
//             ),
//             MenuAction(
//               title: 'Menu Item 2',
//               callback: () {},
//             ),
//             MenuAction(title: 'Menu Item 3', callback: () {}),
//             MenuSeparator(title: ""),
//             MenuAction(title: 'Menu Item 3', callback: () {}),
//             MenuSeparator(),
//             MenuAction(title: 'Menu Item 3', callback: () {}),
//             // MenuAction(title: 'Menu Item 3', callback: () {}),
//             // MenuAction(title: 'Menu Item 3', callback: () {}),
//           ],
//         );
//       },
//     );
//   }
// }
//
// class Item extends StatelessWidget {
//   const Item({
//     super.key,
//     this.color = Colors.blue,
//     required this.child,
//     this.padding = const EdgeInsets.all(14),
//   });
//
//   final EdgeInsets padding;
//   final Color color;
//   final Widget child;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: padding,
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: DefaultTextStyle(
//         style: const TextStyle(color: Colors.white),
//         child: child,
//       ),
//     );
//   }
// }

class UsingFirstTimeSheet extends StatelessWidget {
  const UsingFirstTimeSheet({
    super.key,
    this.divider = true,
    required this.icon,
    required this.title,
    required this.description,
    required this.benefits,
    this.isPremium = false,
    required this.type,
    required this.onPressed,
  });

  final String type;

  final bool isPremium;

  final bool divider;

  final String icon;
  final String title;
  final String description;

  final List<({String icon, String title, String desc})>? benefits;

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var colors = TColors.of(context);

    final paddingOf = MediaQuery.paddingOf(context);

    var helveticaStyles = HelveticaStyles.of(context);

    return ClipRRect(
      borderRadius: AppBorderRadius.top30(),
      child: ColoredBox(
        color: colors.bg,
        child: Padding(
          padding: paddingOf
              .copyWith(top: 12)
              .min(left: 16, right: 16, bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (divider)
                Center(
                  child: Container(
                    width: 64.px,
                    height: 4.px,
                    decoration: ShapeDecoration(
                      color: AppColors.primary,
                      shape: StadiumBorder(),
                    ),
                  ),
                ),
              Center(
                child: Padding(
                  padding: AppEdgeInsets.all18(),
                  child: ImageView(
                    icon,
                    inner: ImageSize(dimension: 45),
                    borderRadius: AppBorderRadius.all10(),
                  ),
                ),
              ),
              CenterText(title, style: helveticaStyles.s20w500),
              Gap(16),
              CenterText(
                description,
                style: helveticaStyles.s14w400.copyWith(
                  color: helveticaStyles.s14w400.color?.changeOpacity(.6),
                ),
              ),
              if (benefits != null && benefits!.isNotEmpty) ...[
                Gap(20),
                Container(
                  padding: EdgeInsets.all(12.px),
                  margin: EdgeInsets.only(bottom: 24.px),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.px),
                    color: AppColors.primary.changeOpacity(.05),
                  ),
                  child: Column(
                    spacing: 32,
                    children: [
                      ...benefits!.map((e) {
                        return Row(
                          spacing: 12,
                          children: [
                            ImageView(e.icon, inner: ImageSize(dimension: 24)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(e.title, style: helveticaStyles.s14w700),
                                  Text(
                                    e.desc,
                                    style: helveticaStyles.s14w400.copyWith(
                                      color: helveticaStyles.s14w400.color
                                          ?.changeOpacity(.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ],
              AppButton(onPressed: onPressed, child: Text(AppStrings.T.letsGo)),
            ],
          ),
        ),
      ),
    );
  }
}
