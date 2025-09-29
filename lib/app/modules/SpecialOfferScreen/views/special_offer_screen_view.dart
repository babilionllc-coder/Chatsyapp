import 'dart:io';

import 'package:chatsy/app/common_widget/common_button.dart';
import 'package:chatsy/app/common_widget/common_container.dart';
import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/helper/image_path.dart';
import 'package:chatsy/app/routes/app_pages.dart';
import 'package:chatsy/extension.dart';

import '../../../Localization/local_language.dart';
import '../../../helper/Global.dart';
import '../../../helper/all_imports.dart' hide CloseButton;
import '../../../helper/font_family.dart';
import '../../purchase/models/get_plan_details_model.dart';
import '../../purchase/views/purchase_view.dart';
import '../controllers/special_offer_screen_controller.dart';

class SpecialOfferScreenView extends GetView<SpecialOfferScreenController> {
  const SpecialOfferScreenView({super.key});

  static Future<T?>? route<T>({dynamic arguments}) {
    if (Global.isSubscription.value == '1') {
      return Future.value();
    }
    return Get.toNamed(Routes.SPECIAL_OFFER_SCREEN, arguments: arguments);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SpecialOfferScreenController>(
      init: SpecialOfferScreenController(),
      builder: (controller) {
        return Stack(
          children: [
            Image.asset(ImagePath.specialOfferImage),
            CommonScreen(
              backgroundColor: AppColors.transparent,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: AppColors.transparent,
                statusBarIconBrightness: (Platform.isAndroid) ? Brightness.light : Brightness.dark,
                statusBarBrightness: (Platform.isAndroid) ? Brightness.light : Brightness.dark,
                systemNavigationBarColor: AppColors.white,
                systemNavigationBarDividerColor: Colors.transparent,
                systemNavigationBarIconBrightness: Brightness.dark,
              ),
              leading: Obx(() {
                return CloseButton(
                  controller.closeButton.value,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.all(20.px),
                      child: Icon(Icons.close, color: AppColors().darkAndWhite),
                    ),
                  ),
                );
              }),
              body: IgnorePointer(
                ignoring: controller.isLoadingView.value,
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0x000D141A),
                            Color(0x000D141A),
                            Color(0xFF0D141A),
                            Color(0xFF0D141A),
                            Color(0xFF0D141A),
                            Color(0xFF0D141A),
                            Color(0xFF0D141A),
                          ],
                          begin: Alignment(0.0, -0.9),
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppText(
                          Languages.of(context)!.specialOffer,
                          color: AppColors.primary,
                          fontSize: 24.px,
                        ),
                        AppText(
                          Languages.of(context)!.offAnnualPlan,
                          fontSize: 24.px,
                          color: Colors.white,
                        ),
                        SizedBox(height: 20.px),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.offerData.planDesc?.length ?? 0,
                          itemBuilder: (context, index) {
                            PlanDesc data = controller.offerData.planDesc?[index] ?? PlanDesc();
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // SvgPicture.asset(ImagePath.done, height: 20.px),
                                Flexible(
                                  child: Icon(Icons.done, color: AppColors.primary, size: 20.px),
                                ),
                                SizedBox(width: 5.px),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: AppText(
                                    data.title ?? "",
                                    fontSize: 14.px,
                                    fontFamily: FontFamily.helveticaBold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ).paddingSymmetric(vertical: 5.px);
                          },
                        ),
                        SizedBox(height: 20.px),
                        CommonContainer(
                          isBorder: true,
                          border: Border.all(color: AppColors.primary),
                          padding: EdgeInsets.all(12.px),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: AppText(
                                      controller.offerData.offerPlan?.planName ?? "",
                                      color: Colors.white.changeOpacity(0.6),
                                      fontSize: 12.px,
                                    ),
                                  ),
                                  AppText(
                                    controller.offerData.offerPlan?.planDesc ?? "",
                                    color: Colors.white.changeOpacity(0.6),
                                    fontSize: 12.px,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        if (!utils.isValidationEmpty(
                                          controller.offerData.offerPlan?.price,
                                        ))
                                          AppText(
                                            "${Languages.of(context)!.just} ",
                                            color: Colors.white,
                                            fontSize: 20.px,
                                          ),
                                        if (!utils.isValidationEmpty(
                                          controller.offerData.offerPlan?.price,
                                        ))
                                          AppText(
                                            "${controller.originalPrice} ",
                                            color: Colors.white.changeOpacity(0.6),
                                            fontSize: 20.px,
                                            decoration: TextDecoration.lineThrough,
                                          ),
                                        AppText(
                                          controller.offerData.offerPlan?.price ?? "",
                                          color: Colors.white,
                                          fontSize: 20.px,
                                        ),
                                      ],
                                    ),
                                  ),
                                  AppText(
                                    controller.calculatePrice(
                                      controller.offerData.offerPlan?.price ?? "",
                                      52,
                                    ),
                                    color: Colors.white,
                                    fontSize: 20.px,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Obx(() {
                          return CommonButton(
                            onTap: () async {
                              if (controller.isLoadingView.value) return;

                              HapticFeedback.mediumImpact();
                              controller.isPurchased = false;
                              controller.purchaseBottomSheet(
                                planId: controller.offerData.offerPlan?.productId ?? "",
                              );
                            },
                            title: Languages.of(context)!.continues,
                            child: controller.isLoadingView.value ? Global.isLoadingView() : null,
                          ).paddingSymmetric(vertical: 20.px);
                        }),
                      ],
                    ).paddingSymmetric(horizontal: 20.px),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
