import 'package:chatsy/app/common_widget/common_container.dart';
import 'package:chatsy/app/modules/purchase/views/purchase_view.dart';
import 'package:chatsy/app/routes/app_pages.dart';
import 'package:chatsy/extension.dart';
import 'package:lottie/lottie.dart';

import '../../../Localization/local_language.dart';
import '../../../common_widget/common_button.dart';
import '../../../common_widget/common_screen.dart';
import '../../../helper/Global.dart';
import '../../../helper/all_imports.dart' hide CloseButton;
import '../../../helper/font_family.dart';
import '../../../helper/image_path.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../purchase/models/get_plan_details_model.dart';
import '../controllers/offer_screen_controller.dart';

class OfferScreenView extends GetView<OfferScreenController> {
  const OfferScreenView({super.key});

  static Future<T?>? route<T>({dynamic arguments}) {
    if (Global.isSubscription.value == '1') {
      return Future.value();
    }
    return Get.toNamed(Routes.OFFER_SCREEN, arguments: arguments);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OfferScreenController>(
      init: OfferScreenController(),
      builder: (controller) {
        return WillPopScope(
          onWillPop: () async {
            controller.backToHomeScreen();

            return false;
          },
          child: CommonScreen(
            // backgroundColor: AppColors.white,
            leading: Obx(() {
              return CloseButton(
                controller.closeButton.value,
                child: GestureDetector(
                  onTap: () {
                    controller.backToHomeScreen();
                  },
                  child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.all(20.px),
                    child: Icon(Icons.close, color: AppColors().darkAndWhite),
                  ),
                ),
              );
            }),
            title:
                (controller.type == Constants.offer15)
                    ? null
                    : Languages.of(context)!.onlyForYou,
            body: SafeArea(
              minimum: EdgeInsets.only(bottom: 16),
              child: IgnorePointer(
                ignoring: controller.isLoadingView.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                      (controller.type == Constants.offer15)
                          ? [
                            Center(
                              child: AppText(
                                Languages.of(context)!.specialOffer,
                                color: AppColors.primary,
                                fontSize: 32.px,
                                height: 1,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 5.px),
                            Center(
                              child: AppText(
                                Languages.of(context)!.offFirstYear,
                                color: AppColors().darkAndWhite,
                                fontSize: 32.px,
                                height: 1,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 35.px),
                            Center(
                              child: AppText(
                                Languages.of(context)!.thisOfferExpiresIn,
                                fontSize: 14.px,
                                color: AppColors().lightGray,
                              ),
                            ),
                            SizedBox(height: 10.px),
                            if (Get.isRegistered<
                                  BottomNavigationController
                                >() ||
                                utils.isValidationEmpty(
                                  getStorageData.readString(
                                    getStorageData.isIntro,
                                  ),
                                ))
                              Center(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 12.px,
                                    horizontal: 25.px,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors().darkAndWhite
                                          .changeOpacity(0.08),
                                    ),
                                    borderRadius: BorderRadius.circular(10.px),
                                  ),
                                  child: Obx(() {
                                    return AppText(
                                      (Get.isRegistered<
                                                BottomNavigationController
                                              >() &&
                                              Get.put(
                                                    BottomNavigationController(),
                                                  ).timer !=
                                                  null)
                                          ? Get.put(
                                            BottomNavigationController(),
                                          ).remainingTimeValue.value
                                          : controller.remainingTimeValue.value,
                                    );
                                  }),
                                ),
                              ),
                            SizedBox(height: 16.px),
                            Expanded(
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 46,
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20.px,
                                          ).copyWith(top: 60),
                                          decoration: BoxDecoration(
                                            color: AppColors.lightWhite,
                                            borderRadius: BorderRadius.circular(
                                              30.px,
                                            ),
                                          ),
                                          constraints: BoxConstraints.tight(
                                            Size.square(500),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  AppText(
                                                    Languages.of(context)!.here,
                                                    fontFamily:
                                                        FontFamily
                                                            .helveticaBold,
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.px,
                                                  ),
                                                  CommonContainer(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                          vertical: 8.px,
                                                          horizontal: 12.px,
                                                        ),
                                                    color: AppColors.primary,
                                                    child: AppText(
                                                      Languages.of(
                                                        context,
                                                      )!.save115,
                                                      color: AppColors.white,
                                                      fontSize: 18.px,
                                                      fontFamily:
                                                          FontFamily
                                                              .helveticaBold,
                                                    ),
                                                  ),
                                                  AppText(
                                                    Languages.of(
                                                      context,
                                                    )!.discount,
                                                    fontFamily:
                                                        FontFamily
                                                            .helveticaBold,
                                                    color: AppColors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.px,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 35.px),
                                              CommonButton(
                                                onTap: () {},
                                                title:
                                                    "${Languages.of(context)!.only} ${controller.calculatePrice(controller.offerData.offerPlan?.price ?? "", 52, rawPrice: controller.offerData.offerPlan?.rawPrice.toString())} / ${Languages.of(context)!.weekly}",
                                              ),
                                              SizedBox(height: 35.px),
                                              AppText(
                                                Languages.of(
                                                  context,
                                                )!.lowestPriceEver,
                                                fontFamily:
                                                    FontFamily.helveticaRegular,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16.px,
                                                color: AppColors.black
                                                    .changeOpacity(0.5),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    left: 0,
                                    right: 0,
                                    child: SizedBox.square(
                                      dimension: 92,
                                      child: DecoratedBox(
                                        decoration: const BoxDecoration(
                                          color: AppColors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Center(
                                            child: LottieBuilder.asset(
                                              ImagePath.offBonusGift,
                                              backgroundLoading: true,
                                              repeat: true,
                                              reverse: true,
                                              fit: BoxFit.cover,
                                              renderCache: RenderCache.raster,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  LottieBuilder.asset(
                                    ImagePath.congratsOfferPage,
                                    backgroundLoading: true,
                                    repeat: true,
                                    fit: BoxFit.cover,
                                    renderCache: RenderCache.raster,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 35.px),
                            Obx(() {
                              return CommonButton(
                                onTap: () {
                                  if (controller.isLoadingView.value) return;

                                  HapticFeedback.mediumImpact();
                                  controller.isPurchased = false;
                                  controller.purchaseBottomSheet(
                                    planId:
                                        controller
                                            .offerData
                                            .offerPlan
                                            ?.productId ??
                                        "",
                                  );
                                },
                                title:
                                    Languages.of(
                                      context,
                                    )!.claimYourLimitedOffer,
                                child:
                                    controller.isLoadingView.value
                                        ? Global.isLoadingView()
                                        : null,
                              );
                            }),
                          ]
                          : [
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  Center(
                                    child: LottieBuilder.asset(
                                      ImagePath.offBonusGift,
                                      height: 80.px,
                                      width: 80.px,
                                      backgroundLoading: true,
                                      repeat: true,
                                      reverse: true,
                                      fit: BoxFit.cover,
                                      renderCache: RenderCache.raster,
                                      // frameBuilder: (context, child, composition) {
                                      //   return child;
                                      // },
                                    ),
                                  ),
                                  SizedBox(height: 10.px),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      AppText(
                                        controller.type == Constants.offer15
                                            ? "15"
                                            : "45",
                                        color: AppColors.primary,
                                        fontSize: 104.px,
                                        height: 1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      SizedBox(width: 5.px),
                                      AppText(
                                        "OFF\n%",
                                        color: AppColors.primary,
                                        fontSize: 43.px,
                                        height: 1,
                                        textAlign: TextAlign.center,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.px),
                                  SizedBox(height: 30.px),
                                  ((controller.offerData.planDesc?.length ??
                                              0) ==
                                          0)
                                      ? SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                            0.25,
                                      )
                                      : Center(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount:
                                              controller
                                                  .offerData
                                                  .planDesc
                                                  ?.length ??
                                              0,
                                          itemBuilder: (context, index) {
                                            PlanDesc data =
                                                controller
                                                    .offerData
                                                    .planDesc?[index] ??
                                                PlanDesc();
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                // SvgPicture.asset(ImagePath.done, height: 20.px),
                                                Flexible(
                                                  child: Icon(
                                                    Icons.done,
                                                    color: AppColors.primary,
                                                    size: 20.px,
                                                  ),
                                                ),
                                                SizedBox(width: 5.px),
                                                Flexible(
                                                  fit: FlexFit.tight,
                                                  child: AppText(
                                                    data.title ?? "",
                                                    fontSize: 14.px,
                                                    fontFamily:
                                                        FontFamily
                                                            .helveticaBold,
                                                    color:
                                                        AppColors()
                                                            .darkAndWhite,
                                                  ),
                                                ),
                                              ],
                                            ).paddingSymmetric(vertical: 5.px);
                                          },
                                        ),
                                      ),
                                  SizedBox(height: 30.px),
                                ],
                              ),
                            ),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 20.px,
                                    color: AppColors().darkAndWhite,
                                    fontFamily: FontFamily.helveticaRegular,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "${Languages.of(context)!.just} ",
                                      style: TextStyle(
                                        fontSize: 20.px,
                                        color: AppColors().darkAndWhite
                                            .changeOpacity(0.5),
                                        fontFamily: FontFamily.helveticaRegular,
                                      ),
                                    ),
                                    TextSpan(
                                      text: controller.originalPrice,
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: AppColors().darkAndWhite
                                            .changeOpacity(0.5),
                                        fontSize: 20.px,
                                        fontFamily: FontFamily.helveticaRegular,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          " ${controller.offerData.offerPlan?.price ?? ""} ",
                                      style: TextStyle(
                                        fontFamily: FontFamily.helveticaBold,
                                        fontSize: 20.px,
                                        color: AppColors().darkAndWhite,
                                      ),
                                    ),
                                    TextSpan(
                                      text: Languages.of(context)!.perFirstYear,
                                      style: TextStyle(
                                        fontSize: 20.px,
                                        color: AppColors().darkAndWhite
                                            .changeOpacity(0.5),
                                        fontFamily: FontFamily.helveticaRegular,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 8.px),
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                  children: [
                                    TextSpan(
                                      text:
                                          "${Languages.of(context)!.lessThan} ",
                                      style: TextStyle(
                                        fontSize: 14.px,
                                        color: AppColors.greyLight3,
                                        fontFamily: FontFamily.helveticaRegular,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          "${controller.calculatePrice(controller.offerData.offerPlan?.price ?? "", 52, rawPrice: controller.offerData.offerPlan?.rawPrice.toString())} ",
                                      style: const TextStyle(
                                        color: AppColors.primary,
                                        fontFamily: FontFamily.helveticaBold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: Languages.of(context)!.perWeek,
                                      style: TextStyle(
                                        fontSize: 14.px,
                                        color: AppColors.greyLight3,
                                        fontFamily: FontFamily.helveticaRegular,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 30.px),
                            Obx(() {
                              return CommonButton(
                                onTap: () async {
                                  if (controller.isLoadingView.value) return;
                                  HapticFeedback.mediumImpact();
                                  controller.isPurchased = false;
                                  controller.purchaseBottomSheet(
                                    planId:
                                        controller
                                            .offerData
                                            .offerPlan
                                            ?.productId ??
                                        "",
                                  );
                                },
                                title: Languages.of(context)!.grabThisDeal,
                                child:
                                    controller.isLoadingView.value
                                        ? Global.isLoadingView()
                                        : null,
                              );
                            }),
                            SizedBox(height: 12.px),
                            Row(
                              children: [
                                Expanded(
                                  child: AppText(
                                    Languages.of(context)!.autoRenewable,
                                    color: AppColors.greyLight3,
                                  ),
                                ),
                                AppText(
                                  Languages.of(context)!.cancelAnytime,
                                  color: AppColors.greyLight3,
                                ),
                              ],
                            ),
                            SizedBox(height: 30.px),
                          ],
                ).paddingSymmetric(horizontal: 20.px),
              ),
            ),
          ),
        );
      },
    );
  }
}
