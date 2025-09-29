import 'dart:io';

import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/modules/bottom_navigation/views/bottom_navigation_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '/extension.dart';
import '../../../Localization/local_language.dart';
import '../../../common_widget/common_button.dart';
import '../../../common_widget/common_container.dart';
import '../../../helper/Global.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/font_family.dart';
import '../../../helper/image_path.dart';
import '../../../routes/app_pages.dart';
import '../../chat_gpt/views/chat_gpt_view.dart';
import '../controllers/purchase_controller.dart';
import '../models/get_plan_details_model.dart';

class LightSystemUiOverlayStyle extends AnnotatedRegion<SystemUiOverlayStyle> {
  const LightSystemUiOverlayStyle({super.key, required super.child, super.value = style});

  static const SystemUiOverlayStyle style = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.light,
    systemNavigationBarDividerColor: Colors.transparent,
  );
}

class PurchaseView extends GetView<PurchaseController> {
  const PurchaseView({super.key});

  static Future<T?>? offAllRoute<T>() async {
    if (Global.isSubscription.value == '1') {
      return Future.value();
    }
    return Get.offAllNamed(Routes.PURCHASE);
  }

  static Future<T?>? route<T>({required dynamic arguments}) {
    if (!kDebugMode && Global.isSubscription.value == '1') {
      return Future.value();
    }
    return Get.toNamed(Routes.PURCHASE, arguments: arguments);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseController>(
      init: PurchaseController(),
      builder: (controller) {
        return Obx(() {
          controller.getPlanDetails;
          return WillPopScope(
            onWillPop: () async {
              controller.backToHomeScreen();
              return false;
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors().backgroundColor1,
                image: DecorationImage(
                  image: AssetImage(
                    (isLight) ? ImagePath.socialImageLight : ImagePath.socialImageDark,
                  ),
                  alignment: Alignment.bottomCenter,
                ),
              ),
              child: CommonScreen(
                backgroundColor: AppColors.transparent,
                toolbarHeight: 0,
                body: Column(
                  children: [
                    BuilderAny(
                      builder: (context, any) {
                        return Padding(
                          padding: MediaQuery.paddingOf(
                            context,
                          ).min(top: 16, left: 16, right: 16).copyWith(bottom: 0),
                          child: any,
                        );
                      },
                      any: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IgnorePointer(
                            ignoring: controller.isLoadingView.value,
                            child: CloseButton(
                              controller.closeButton.value,
                              child: GestureDetector(
                                onTap: () {
                                  // if (controller.firstTimeSubscription == "0") {
                                  //   controller.waitingDialog();
                                  // } else {
                                  controller.backToHomeScreen();
                                  // }
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  padding: EdgeInsets.only(right: 40.px, bottom: 8.px),
                                  child: Icon(Icons.close, color: AppColors().darkAndWhite),
                                ),
                              ),
                            ),
                          ),
                          Obx(
                            () => IgnorePointer(
                              ignoring: controller.isLoadingView.value,
                              child: GestureDetector(
                                onTap: () async {
                                  // await FirebaseAnalytics.instance.logEvent(name: 'test_event');
                                  // debugger();
                                  // return;
                                  HapticFeedback.mediumImpact();
                                  if (Platform.isIOS) {
                                    controller.restorePurchasePlan();
                                  } else {
                                    controller.isRestore = false;
                                    controller.restoreButtonClick = true;
                                    await InAppPurchase.instance.restorePurchases(
                                      applicationUserName: controller.userId,
                                    );
                                  }
                                },
                                child: AppText(
                                  Languages.of(context)!.restore,
                                  color: AppColors().darkAndWhite,
                                  fontFamily: FontFamily.helveticaBold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (controller.getPlanDetails.value)
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView(
                                padding: EdgeInsets.only(top: 25),
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: commonLeadingWith),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            (isLight) ? ImagePath.darkLogo : ImagePath.logo,
                                            height: 32.px,
                                          ),
                                          SizedBox(width: 20.px),
                                          AppText(
                                            "CHATSY",
                                            fontSize: 20.px,
                                            fontFamily: Constants.neuePowerTrialText,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 40.px),
                                  Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: commonLeadingWith),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                              children: [
                                                TextSpan(
                                                  text: Languages.of(context)!.joinHappyPROUsers,
                                                  style: TextStyle(
                                                    fontSize: 24.px,
                                                    fontFamily: FontFamily.helveticaBold,
                                                    color: AppColors().darkAndWhite,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: Languages.of(context)!.pro.toUpperCase(),
                                                  style: TextStyle(
                                                    fontSize: 24.px,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: FontFamily.helveticaBold,
                                                    color: AppColors.lightImageColor,
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: Languages.of(context)!.users.capitalize,
                                                  style: TextStyle(
                                                    fontSize: 24.px,
                                                    fontFamily: FontFamily.helveticaBold,
                                                    color: AppColors().darkAndWhite,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 30.px),
                                          if (controller.getPlanDetailData.feature?.isNotEmpty ??
                                              false)
                                            ListView.separated(
                                              shrinkWrap: true,
                                              padding: EdgeInsets.zero,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  controller.getPlanDetailData.feature?.length ?? 0,
                                              separatorBuilder: (context, index) {
                                                return SizedBox(height: 20.px);
                                              },
                                              itemBuilder: (context, index) {
                                                Feature data =
                                                    controller.getPlanDetailData.feature?[index] ??
                                                    Feature();
                                                return Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    // SvgPicture.asset(ImagePath.done, height: 20.px),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Align(
                                                        alignment: Alignment.centerRight,
                                                        child: CachedNetworkImage(
                                                          imageUrl: data.img ?? "",
                                                          width: 20.px,
                                                          height: 20.px,

                                                          progressIndicatorBuilder:
                                                              (context, url, progress) =>
                                                                  progressIndicatorView(
                                                                    circle: true,
                                                                  ),
                                                          errorWidget:
                                                              (context, url, uri) =>
                                                                  errorWidgetView(
                                                                    height: 20.px,
                                                                    wight: 20.px,
                                                                  ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 5.px),
                                                    Expanded(
                                                      flex: 4,
                                                      child: AppText(
                                                        data.title ?? "",
                                                        fontSize: 16.px,
                                                        fontFamily: FontFamily.helveticaBold,
                                                        color: AppColors().darkAndWhite,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            ),
                                          SizedBox(height: 20.px),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      ListView.separated(
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        physics: ScrollPhysics(),
                                        itemCount: controller.getPlanDetailData.plans?.length ?? 0,
                                        separatorBuilder: (context, index) {
                                          Plans data =
                                              controller.getPlanDetailData.plans?[index] ?? Plans();
                                          return SizedBox(
                                            height: (data.isActive == "1") ? 10.px : 0,
                                          );
                                        },
                                        itemBuilder: (context, index) {
                                          Plans data =
                                              controller.getPlanDetailData.plans?[index] ?? Plans();

                                          if (data.isActive != "1") {
                                            return SizedBox();
                                          }

                                          return GestureDetector(
                                            onTap: () {
                                              HapticFeedback.mediumImpact();
                                              controller.selectedPlan.value = index;
                                              if (utils.isValidationEmpty(
                                                    data.freeTrialProductId,
                                                  ) &&
                                                  controller.isFreeTrial) {
                                                // controller.isFreeTrial = false;
                                                // controller.update();
                                              }
                                            },
                                            child: Obx(() {
                                              var lifeTimePlan =
                                                  data.productId == "com.aichatsy.app.lifetime2";

                                              Widget planNameAndTitleWidget = AppText(
                                                data.planName ?? "",
                                                fontSize: 18.px,
                                                color: AppColors().darkAndWhite,
                                                fontFamily: FontFamily.helveticaBold,
                                              );

                                              if (data.isBestOffer == "1" && !lifeTimePlan) {
                                                planNameAndTitleWidget = OverflowBar(
                                                  overflowAlignment: OverflowBarAlignment.start,
                                                  spacing: 8,
                                                  overflowSpacing: 2,
                                                  children: [
                                                    planNameAndTitleWidget,
                                                    CommonContainer(
                                                      padding: EdgeInsets.symmetric(
                                                        vertical: 2.px,
                                                        horizontal: 8.px,
                                                      ),
                                                      color: AppColors.primary,
                                                      child: AppText(
                                                        data.planDesc?.capitalize ?? "",
                                                        color: AppColors.white,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }

                                              return Container(
                                                padding: EdgeInsets.all(10.px),
                                                margin:
                                                    data.isBestOffer == "1"
                                                        ? EdgeInsets.only(top: 14)
                                                        : null,
                                                decoration: BoxDecoration(
                                                  // color: (controller.selectedPlan.value == index) ? AppColors.lightImageColor.changeOpacity(0.1) : AppColors.transparent,
                                                  color: AppColors().containerBlack,
                                                  borderRadius: BorderRadius.circular(10.px),
                                                  border: Border.all(
                                                    color:
                                                        (controller.selectedPlan.value == index)
                                                            ? AppColors.lightImageColor
                                                            : AppColors().darkAndWhite
                                                                .changeOpacity(0.4),
                                                    width: 1.px,
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child:
                                                      /* (lifeTimePlan)
                                                                  ? Row(
                                                                    children: [
                                                                      AppText(
                                                                        data.planName ?? "",
                                                                        fontSize: 20.px,
                                                                        color:
                                                                            AppColors
                                                                                .greyLight3,
                                                                        fontFamily:
                                                                            FontFamily
                                                                                .helveticaBold,
                                                                      ),
                                                                      AppText(
                                                                        ' ${data.price}',
                                                                        fontSize: 20.px,
                                                                        color:
                                                                            AppColors()
                                                                                .darkAndWhite,
                                                                        fontFamily:
                                                                            FontFamily
                                                                                .helveticaBold,
                                                                      ),
                                                                    ],
                                                                  )
                                                                  : */
                                                      Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          planNameAndTitleWidget,
                                                          ((!utils.isValidationEmpty(
                                                                    data.freeTrialProductId,
                                                                  )) &&
                                                                  (!controller.isFreeTrial))
                                                              ? const SizedBox()
                                                              : AppText(
                                                                data.subTitle ??
                                                                    ((data.isBestOffer == "1")
                                                                        ? "${controller.calculatePrice(data.price ?? "", 52, rawPrice: data.rawPrice?.toString())} / Week"
                                                                        : data
                                                                                .planDesc
                                                                                ?.capitalizeFirst ??
                                                                            ""),
                                                                fontSize: 12.px,
                                                                color: AppColors().darkAndWhite,
                                                              ),
                                                          // Row(
                                                          //   children: [
                                                          //     if (data.isBestOffer == "1")
                                                          //       AppText(
                                                          //         Languages.of(context)!.just,
                                                          //         fontSize: 20.px,
                                                          //         color: AppColors.greyLight3,
                                                          //         fontFamily:
                                                          //             FontFamily.helveticaBold,
                                                          //       ),
                                                          //     SizedBox(width: 5.px),

                                                          //   ],
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Builder(
                                                          builder: (context) {
                                                            var text = data.price ?? "";
                                                            if (data.rawPrice == 0) {
                                                              text = Languages.of(context)!.free;
                                                            }

                                                            return AppText(
                                                              text,
                                                              fontSize: 18.px,
                                                              color: AppColors().darkAndWhite,
                                                              fontFamily: FontFamily.helveticaBold,
                                                            );
                                                          },
                                                        ),
                                                        if (data.productId !=
                                                            "com.aichatsy.app.lifetime2")
                                                          AppText(
                                                            "${controller.calculatePrice(data.price ?? "", 52, rawPrice: data.rawPrice?.toString())} / Week",
                                                            fontSize: 12.px,
                                                            color: AppColors().darkAndWhite,
                                                          ),
                                                      ],
                                                    ),
                                                    // if (!lifeTimePlan)

                                                    // else
                                                    //   Builder(
                                                    //     builder: (context) {
                                                    //       return AppText(
                                                    //         data.planDesc ?? '',
                                                    //         fontSize: 20.px,
                                                    //         color: AppColors().darkAndWhite,
                                                    //         fontFamily:
                                                    //             FontFamily.helveticaBold,
                                                    //       );
                                                    //     },
                                                    //   ),
                                                  ],
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      ),

                                      // SizedBox(height: (IphoneHasNotch.hasNotch) ? 30.px : 20.px),
                                    ],
                                  ),
                                  if (controller.getPlanDetailData.uses != null)
                                    Wrap(
                                      alignment: WrapAlignment.center,
                                      children:
                                          controller.getPlanDetailData.uses!.map((e) {
                                            return Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.asset(ImagePath.done2, height: 15.px),
                                                SizedBox(width: 10.px),
                                                AppText(
                                                  e.title ?? "",
                                                  fontSize: 14.px,
                                                  color: AppColors().darkAndWhite,
                                                ),
                                              ],
                                            ).paddingOnly(right: 10.px, top: 10.px);
                                          }).toList(),
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(height: 8.px),
                            OverflowBar(
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,

                                  children: [
                                    Image.asset(ImagePath.ratingImage, width: 80.px),
                                    SizedBox(width: 10.px),
                                    AppText(
                                      "${Languages.of(context)!.rating} ",
                                      fontSize: 18.px,
                                      color: AppColors().darkAndWhite,
                                      fontFamily: FontFamily.helveticaBold,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    AppText(
                                      "${Languages.of(context)!.by} ",
                                      fontSize: 18.px,
                                      color: AppColors().darkAndWhite.withValues(alpha: 0.5),
                                    ),
                                    Image.asset(ImagePath.mataIcon, width: 16.px),
                                    AppText(
                                      " & ",
                                      fontSize: 18.px,
                                      color: AppColors().darkAndWhite.withValues(alpha: 0.5),
                                    ),
                                    Image.asset(ImagePath.tikTokIcon, width: 16.px),
                                    AppText(
                                      " ${Languages.of(context)!.users.capitalizeFirst}",
                                      fontSize: 18.px,
                                      color: AppColors().darkAndWhite.withValues(alpha: 0.5),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            CommonButton(
                              onTap: () async {
                                if (controller.isLoadingView.value) return;
                                HapticFeedback.mediumImpact();
                                controller.isPurchased = false;
                                controller.restoreButtonClick = true;
                                controller.purchaseBottomSheet(
                                  planId:
                                      ((!utils.isValidationEmpty(
                                                controller
                                                    .getPlanDetailData
                                                    .plans?[controller.selectedPlan.value]
                                                    .freeTrialProductId,
                                              )) &&
                                              (!controller.isFreeTrial))
                                          ? controller
                                              .getPlanDetailData
                                              .plans![controller.selectedPlan.value]
                                              .freeTrialProductId
                                          : controller
                                              .getPlanDetailData
                                              .plans?[controller.selectedPlan.value]
                                              .productId,
                                );
                              },
                              title:
                                  ((!utils.isValidationEmpty(
                                            controller
                                                .getPlanDetailData
                                                .plans?[controller.selectedPlan.value]
                                                .freeTrialProductId,
                                          )) &&
                                          controller.isFreeTrial)
                                      ? Languages.of(context)!.startFreeTrial
                                      : Languages.of(context)!.continues,
                              buttonColor: AppColors.primary,
                              child: controller.isLoadingView.value ? Global.isLoadingView() : null,
                            ),
                            SizedBox(height: 20.px),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      ImagePath.recycle,
                                      height: 15.px,
                                      color: AppColors().darkAndWhite,
                                    ),
                                    SizedBox(width: 5.px),
                                    AppText(
                                      Languages.of(context)!.autoRenewable,
                                      fontSize: 12.px,
                                      color: AppColors().darkAndWhite,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.TERMS_PAGE);
                                      },
                                      child: AppText(
                                        Languages.of(context)!.termsOfUse,
                                        fontSize: 12.px,
                                        color: AppColors().darkAndWhite,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    SizedBox(width: 5.px),
                                    AppText("|", fontSize: 12.px, color: AppColors().darkAndWhite),
                                    SizedBox(width: 5.px),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.PRIVACY_POLICY);
                                      },
                                      child: AppText(
                                        Languages.of(context)!.privacyPolicy,
                                        fontSize: 12.px,
                                        color: AppColors().darkAndWhite,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Builder(
                              builder:
                                  (context) => SizedBox(
                                    height: MediaQuery.paddingOf(context).min(bottom: 16).bottom,
                                  ),
                            ),
                          ],
                        ).paddingSymmetric(horizontal: commonLeadingWith),
                      ),
                  ],
                ),
              ),
            ),
            /*child: CommonScreen(
                padding: EdgeInsets.zero,
                toolbarHeight: 0,
                body: (controller.getPlanDetails.value)
                    ? SafeArea(
                        child: Column(
                          children: [
                            SizedBox(height: 20.px),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() {
                                  return IgnorePointer(
                                    ignoring: controller.isLoadingView.value,
                                    child: CloseButton(
                                      controller.closeButton.value,
                                      child: GestureDetector(
                                        onTap: () {
                                          // if (controller.firstTimeSubscription == "0") {
                                          //   controller.waitingDialog();
                                          // } else {
                                          controller.backToHomeScreen();
                                          // }
                                        },
                                        child: Container(
                                          color: Colors.transparent,
                                          padding: EdgeInsets.only(right: 40.px),
                                          child: Icon(Icons.close, color: AppColors().darkAndWhite),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                                if (utf8.encode(LottieCacheInApp.instance.getLottie('diamond') ?? "").isNotEmpty)
                                  LottieBuilder.memory(
                                    utf8.encode(LottieCacheInApp.instance.getLottie('diamond') ?? ""),
                                    height: 40.px,
                                    backgroundLoading: true,
                                    repeat: true,
                                    reverse: true,

                                    renderCache: RenderCache.raster,
                                    // frameBuilder: (context, child, composition) {
                                    //   return child;
                                    // },
                                  ),
                                IgnorePointer(
                                  ignoring: controller.isLoadingView.value,
                                  child: GestureDetector(
                                      onTap: () async {
                                        HapticFeedback.mediumImpact();
                                        if (Platform.isIOS) {
                                          controller.restorePurchasePlan();
                                        } else {
                                          controller.isRestore = false;
                                          controller.restoreButtonClick = true;
                                          await InAppPurchase.instance.restorePurchases(applicationUserName: controller.userId);
                                        }
                                      },
                                      child: AppText(
                                        Languages.of(context)!.restore,
                                        color: AppColors().darkAndWhite,
                                        fontFamily: FontFamily.helveticaBold,
                                        decoration: TextDecoration.underline,
                                      )),
                                ),
                              ],
                            ),
                            Expanded(
                                child: IgnorePointer(
                              ignoring: controller.isLoadingView.value,
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  SizedBox(height: 30.px),
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: Languages.of(context)!.upgradeTo,
                                          style: TextStyle(fontSize: 24.px, fontFamily: FontFamily.helveticaBold, color: AppColors().darkAndWhite),
                                        ),
                                        TextSpan(
                                            text: Languages.of(context)!.pro.toUpperCase(),
                                            style: TextStyle(fontSize: 24.px, fontWeight: FontWeight.w700, fontFamily: FontFamily.helveticaBold, color: AppColors.lightImageColor)),
                                        TextSpan(text: Languages.of(context)!.forFullAccess, style: TextStyle(fontSize: 24.px, fontFamily: FontFamily.helveticaBold, color: AppColors().darkAndWhite)),
                                      ],
                                    ),
                                  ).paddingSymmetric(horizontal: 14.w),
                                  SizedBox(height: 8.px),
                                  Center(child: AppText(Languages.of(context)!.powerfulAIModelsGPTGemini, color: AppColors().lightGray, fontSize: 14.px)),
                                  SizedBox(height: 30.px),
                                  */
            /*SizedBox(
                                    height: 40.px,
                                    child: ListView.separated(
                                      padding: EdgeInsets.zero,
                                      itemCount: controller.getPlanDetailData.model?.length ?? 0,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      separatorBuilder: (context, index) {
                                        return SizedBox(width: 10.px);
                                      },
                                      itemBuilder: (context, index) {
                                        Model data = controller.getPlanDetailData.model?[index] ?? Model();
                                        return CommonContainer(
                                          border: Border.all(color: AppColors.grayLight, width: 2),
                                          radius: 40.px,
                                          isBorder: true,
                                          padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 8.px),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              CachedNetworkImage(
                                                // width: 30.px,
                                                // height: 30.px,
                                                imageUrl: data.img!,
                                                progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(circle: true),
                                                errorWidget: (context, url, uri) => errorWidgetView().paddingAll(8.px),
                                              ),
                                              SizedBox(width: 5.px),
                                              AppText(
                                                data.title ?? "",
                                                fontSize: 14.px,
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 20.px),*/
            /*
                                  if (controller.getPlanDetailData.feature?.isNotEmpty ?? false)
                                    GridView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics: const NeverScrollableScrollPhysics(),
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4),
                                      itemCount: controller.getPlanDetailData.feature?.length,
                                      itemBuilder: (context, index) {
                                        Feature data = controller.getPlanDetailData.feature?[index] ?? Feature();
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // SvgPicture.asset(ImagePath.done, height: 20.px),
                                            Icon(
                                              Icons.done,
                                              color: AppColors.primary,
                                              size: 20.px,
                                            ),
                                            SizedBox(width: 5.px),
                                            Expanded(
                                              child: AppText(
                                                data.title ?? "",
                                                fontSize: 14.px,
                                                fontFamily: FontFamily.helveticaBold,
                                                color: AppColors().darkAndWhite,
                                              ),
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                  if (controller.getPlanDetailData.feature?.isNotEmpty ?? false) SizedBox(height: 20.px),
                                  Center(
                                    child: CommonContainer(
                                        padding: EdgeInsets.symmetric(vertical: 3.px),
                                        // color: AppColors().bgColor,
                                        color: Colors.transparent,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 10.px),
                                            AppText(
                                              Languages.of(context)!.freeTrial.capitalize ?? "",
                                              fontSize: 16.px,
                                              color: AppColors().darkAndWhite,
                                            ),
                                            Transform.scale(
                                              scale: 0.8,
                                              child: CupertinoSwitch(
                                                  value: controller.isFreeTrial,
                                                  onChanged: (val) {
                                                    HapticFeedback.mediumImpact();
                                                    controller.isFreeTrial = val;
                                                    controller.update();

                                                    if (!controller.isFreeTrial) {
                                                      return;
                                                    }
                                                    for (Plans item in controller.getPlanDetailData.plans ?? []) {
                                                      if (!utils.isValidationEmpty(item.freeTrialProductId)) {
                                                        controller.selectedPlan.value = controller.getPlanDetailData.plans?.indexOf(item) ?? 0;
                                                        break;
                                                      }
                                                    }
                                                  }),
                                            ),
                                          ],
                                        )),
                                  ),
                                  SizedBox(height: 35.px),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: controller.getPlanDetailData.plans?.length ?? 0,
                                    separatorBuilder: (context, index) {
                                      Plans data = controller.getPlanDetailData.plans?[index] ?? Plans();
                                      return SizedBox(height: (data.isActive == "1") ? 10.px : 0);
                                    },
                                    itemBuilder: (context, index) {
                                      Plans data = controller.getPlanDetailData.plans?[index] ?? Plans();
                                      return (data.isActive == "1")
                                          ? GestureDetector(
                                              onTap: () {
                                                HapticFeedback.mediumImpact();
                                                controller.selectedPlan.value = index;
                                                if (utils.isValidationEmpty(data.freeTrialProductId) && controller.isFreeTrial) {
                                                  controller.isFreeTrial = false;
                                                  controller.update();
                                                }
                                              },
                                              child: Obx(() {
                                                return Stack(
                                                  alignment: const Alignment(0, -2),
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.all(10.px),
                                                      decoration: BoxDecoration(
                                                        color: (controller.selectedPlan.value == index) ? AppColors.lightImageColor.changeOpacity(0.1) : AppColors.transparent,
                                                        borderRadius: BorderRadius.circular(10.px),
                                                        border: Border.all(color: (controller.selectedPlan.value == index) ? AppColors.lightImageColor : AppColors().darkAndWhite.changeOpacity(0.4), width: 0.5),
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                              child: Column(
                                                            mainAxisSize: MainAxisSize.min,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              AppText(
                                                                data.planName ?? "",
                                                                fontSize: 12.px,
                                                                color: AppColors().darkAndWhite.changeOpacity(0.6),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  if (data.isBestOffer == "1")
                                                                    AppText(
                                                                      Languages.of(context)!.just,
                                                                      fontSize: 20.px,
                                                                      color: AppColors.greyLight3,
                                                                      fontFamily: FontFamily.helveticaBold,
                                                                    ),
                                                                  SizedBox(width: 5.px),
                                                                  AppText(
                                                                    data.price ?? "",
                                                                    fontSize: 20.px,
                                                                    color: AppColors().darkAndWhite,
                                                                    fontFamily: FontFamily.helveticaBold,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          )),
                                                          ((!utils.isValidationEmpty(data.freeTrialProductId)) && (!controller.isFreeTrial))
                                                              ? const SizedBox()
                                                              : CommonContainer(
                                                                  padding: EdgeInsets.symmetric(vertical: 5.px, horizontal: 12.px),
                                                                  alignment: Alignment.center,
                                                                  color: AppColors().bgColor,
                                                                  child: AppText(
                                                                    (data.isBestOffer == "1") ? "${controller.calculatePrice(data.price ?? "", 52)} / Week" : data.planDesc ?? "",
                                                                    fontSize: 12.px,
                                                                    color: AppColors().darkAndWhite,
                                                                  ),
                                                                )
                                                        ],
                                                      ),
                                                    ),
                                                    if (data.isBestOffer == "1")
                                                      CommonContainer(
                                                        padding: EdgeInsets.symmetric(vertical: 5.px, horizontal: 12.px),
                                                        color: AppColors.primary,
                                                        child: AppText(
                                                          data.planDesc ?? "",
                                                          color: AppColors.white,
                                                        ),
                                                      )
                                                  ],
                                                );
                                              }),
                                            )
                                          : const SizedBox();
                                    },
                                  ),
                                  SizedBox(height: 35.px),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CachedNetworkImage(
                                          imageUrl: (isLight ? controller.getPlanDetailData.planImgLight2 : controller.getPlanDetailData.planImgDark2) ?? "",
                                          progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(),
                                          errorWidget: (context, url, uri) => errorWidgetView().paddingAll(8.px),
                                        ),
                                      ),
                                      SizedBox(width: 15.px),
                                      Expanded(
                                        child: CachedNetworkImage(
                                          imageUrl: (isLight ? controller.getPlanDetailData.planImgLight1 : controller.getPlanDetailData.planImgDark1) ?? "",
                                          progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(),
                                          errorWidget: (context, url, uri) => errorWidgetView().paddingAll(8.px),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30.px),
                                  if (controller.getPlanDetailData.planDesc != null)
                                    Container(
                                      padding: EdgeInsets.all(12.px),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.px),
                                        border: Border.all(color: AppColors().darkAndWhite.changeOpacity(0.4), width: 0.5),
                                      ),
                                      child: Column(
                                        children: controller.getPlanDetailData.planDesc!
                                            .map(
                                              (e) => Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Flexible(
                                                    flex: 4,
                                                    fit: FlexFit.tight,
                                                    child: AppText(
                                                      e.title ?? "",
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  Flexible(
                                                    flex: 2,
                                                    fit: FlexFit.tight,
                                                    child: e.basic == "0"
                                                        ? Icon(
                                                            Icons.close,
                                                            color: AppColors().darkAndWhite,
                                                          )
                                                        : AppText(
                                                            e.basic ?? '',
                                                            textAlign: TextAlign.center,
                                                            fontFamily: (controller.getPlanDetailData.planDesc?.indexOf(e) == 0) ? FontFamily.helveticaBold : null,
                                                            color: (controller.getPlanDetailData.planDesc?.indexOf(e) == 0) ? null : AppColors().darkAndWhite.changeOpacity(0.5),
                                                            maxLines: 1,
                                                          ),
                                                  ),
                                                  Flexible(
                                                    flex: 2,
                                                    fit: FlexFit.tight,
                                                    child: e.pro == "1"
                                                        ? const Icon(
                                                            Icons.check,
                                                            color: AppColors.primary,
                                                          )
                                                        : (controller.getPlanDetailData.planDesc?.indexOf(e) == 0)
                                                            ? Column(
                                                                children: [
                                                                  AppText(
                                                                    e.pro ?? "",
                                                                    textAlign: TextAlign.center,
                                                                    color: AppColors.primary,
                                                                    fontFamily: FontFamily.helveticaBold,
                                                                  ),
                                                                  AppText(
                                                                    "(${Languages.of(context)!.unlimited})",
                                                                    textAlign: TextAlign.center,
                                                                    maxLines: 1,
                                                                    color: AppColors.greyLight3,
                                                                  ),
                                                                ],
                                                              )
                                                            : Text(
                                                                e.pro ?? "",
                                                                textAlign: TextAlign.center,
                                                              ),
                                                  ),
                                                ],
                                              ).paddingOnly(bottom: 10.px),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  if (controller.getPlanDetailData.review != null) SizedBox(height: 20.px),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 15.px),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.px),
                                      border: Border.all(color: AppColors().darkAndWhite.changeOpacity(0.4), width: 0.5),
                                    ),
                                    child: Column(
                                      children: [
                                        CarouselSlider(
                                          options: CarouselOptions(
                                            reverse: false,
                                            autoPlay: true,
                                            autoPlayInterval: const Duration(seconds: 5),
                                            viewportFraction: 1,
                                            aspectRatio: 2.2,
                                            pageSnapping: true,
                                            onPageChanged: (index, _) async {
                                              controller.reviewCurrentIndex.value = index;
                                            },
                                          ),
                                          items: controller.getPlanDetailData.review?.map((e) {
                                            return Column(
                                              children: [
                                                Image.asset(ImagePath.ratingImage, color: AppColors.primary, height: 20.px),
                                                AppText(
                                                  e.title ?? "",
                                                  textAlign: TextAlign.center,
                                                  fontSize: 14.px,
                                                ).paddingSymmetric(vertical: 20.px, horizontal: 7.w),
                                              ],
                                            );
                                          }).toList(),
                                        ),
                                        if (controller.getPlanDetailData.review == null)
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: controller.getPlanDetailData.review!.map(
                                                (e) {
                                                  int index = controller.getPlanDetailData.review!.indexOf(e);
                                                  return Container(
                                                    height: 10.px,
                                                    width: 10.px,
                                                    margin: EdgeInsets.symmetric(horizontal: 5.px),
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: (controller.reviewCurrentIndex.value == index) ? AppColors.primary : AppColors.grayLight,
                                                    ),
                                                  );
                                                },
                                              ).toList())
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 30.px),
                                    ),
                                  if (controller.getPlanDetailData.uses != null)
                                    Wrap(
                                      alignment: WrapAlignment.center,
                                      children: controller.getPlanDetailData.uses!.map(
                                        (e) {
                                          return Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Image.asset(ImagePath.done2, height: 15.px),
                                              SizedBox(width: 10.px),
                                              AppText(
                                                e.title ?? "",
                                                fontSize: 14.px,
                                                color: AppColors().darkAndWhite,
                                              ),
                                            ],
                                          ).paddingOnly(right: 10.px, top: 10.px);
                                        },
                                      ).toList(),
                                  SizedBox(height: 10.px),
                                  */
            /*Center(
                                    child: GestureDetector(
                                        onTap: () async {
                                          if (controller.firstTimeSubscription != "1") {
                                            controller.waitingDialog();
                                          } else {
                                            controller.backToHomeScreen();
                                          }
                                        },
                                        child: AppText(
                                          Languages.of(context)!.maybeLater,
                                          color: AppColors.primary,
                                          fontFamily: FontFamily.helveticaRegular,
                                          decoration: TextDecoration.underline,
                                        )),
                                  ),*/
            /*
                                ],
                              ),
                            )),
                            SizedBox(height: 10.px),
                            CommonButton(
                              onTap: () async {
                                if (controller.isLoadingView.value) return;
                                HapticFeedback.mediumImpact();
                                controller.isPurchased = false;
                                controller.restoreButtonClick = true;
                                controller.purchaseBottomSheet(
                                  planId: ((!utils.isValidationEmpty(controller.getPlanDetailData.plans?[controller.selectedPlan.value].freeTrialProductId)) && (!controller.isFreeTrial)) ? controller.getPlanDetailData.plans![controller.selectedPlan.value].freeTrialProductId : controller.getPlanDetailData.plans?[controller.selectedPlan.value].productId,
                                );
                              },
                              title: ((!utils.isValidationEmpty(controller.getPlanDetailData.plans?[controller.selectedPlan.value].freeTrialProductId)) && controller.isFreeTrial) ? Languages.of(context)!.tryTodayFor : Languages.of(context)!.continues,
                              buttonColor: AppColors.primary,
                              child: controller.isLoadingView.value ? Global.isLoadingView() : null,
                            ),
                            SizedBox(height: 10.px),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      ImagePath.recycle,
                                      height: 15.px,
                                      color: AppColors().darkAndWhite,
                                    ),
                                    SizedBox(width: 5.px),
                                    AppText(
                                      Languages.of(context)!.autoRenewable,
                                      fontSize: 12.px,
                                      color: AppColors().darkAndWhite,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.TERMS_PAGE);
                                      },
                                      child: AppText(
                                        Languages.of(context)!.termsOfUse,
                                        fontSize: 12.px,
                                        color: AppColors().darkAndWhite,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    SizedBox(width: 5.px),
                                    AppText(
                                      "|",
                                      fontSize: 12.px,
                                      color: AppColors().darkAndWhite,
                                    ),
                                    SizedBox(width: 5.px),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.PRIVACY_POLICY);
                                      },
                                      child: AppText(
                                        Languages.of(context)!.privacyPolicy,
                                        fontSize: 12.px,
                                        color: AppColors().darkAndWhite,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ).paddingSymmetric(horizontal: 20.px),
                      )
                    : const SizedBox()),*/
          );
        });
      },
    );
  }
}

class CloseButton extends ImplicitlyAnimatedWidget {
  final bool visible;

  const CloseButton(
    this.visible, {
    super.key,
    required this.child,
    super.duration = Durations.short4,
  });

  final Widget child;

  @override
  AnimatedWidgetBaseState<CloseButton> createState() => _CloseButtonState();
}

class _CloseButtonState extends AnimatedWidgetBaseState<CloseButton> {
  @override
  Widget build(BuildContext context) {
    var scaleAnim = _scale!.animate(animation);
    return ScaleTransition(
      scale: scaleAnim,
      child: FadeTransition(opacity: scaleAnim, child: widget.child),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _scale =
        visitor(
              _scale,
              widget.visible ? 1.0 : 0.0,
              (targetValue) => Tween<double>(begin: targetValue),
            )
            as Tween<double>;
  }

  Tween<double>? _scale;
  // Tween<double>? _fade;
}
