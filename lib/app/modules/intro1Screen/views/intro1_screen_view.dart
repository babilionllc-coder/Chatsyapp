import 'package:chatsy/app/helper/font_family.dart';
import 'package:chatsy/app/helper/image_path.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../common_widget/common_button.dart';
import '../../../helper/all_imports.dart';
import '../../../routes/app_pages.dart';
import '../../chat_gpt/views/chat_gpt_view.dart';
import '../controllers/intro1_screen_controller.dart';
import '../models/get_intro_details_model.dart';

class Intro1ScreenView extends GetView<Intro1ScreenController> {
  const Intro1ScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Intro1ScreenController>(
      init: Intro1ScreenController(),
      builder: (controller) {
        Utils.darkStatusBar();

        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            backgroundColor: AppColors.white,
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(ImagePath.darkLogo, height: 23.px),
                      SizedBox(width: 10.px),
                      Center(
                        child: AppText(
                          "CHATSY",
                          fontSize: 20.px,
                          color: AppColors.greyLight3,
                          fontFamily: Constants.neuePowerTrialTextExtraBold,
                        ),
                      ),
                      // Center(
                      //   child: introCommonRichText(
                      //     firstText: "Chat",
                      //     secondText: "SY",
                      //     firstColor: AppColors.black,
                      //     secondColor: AppColors.primary,
                      //     fontSize: 14.px,
                      //   ),
                      // ),
                    ],
                  ),
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                  // Container(
                  //   height: 60.px,
                  //   color: Colors.red,
                  // )
                  // (controller.getIntroData.intro3 != null)
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),

                  // Center(
                  //   child: introCommonRichText(
                  //     firstText: "Powerful AI models in",
                  //     secondText: " one App",
                  //     firstColor: AppColors.black,
                  //     secondColor: AppColors.primary,
                  //     fontSize: 14.px,
                  //     firstFontFamily: FontFamily.helveticaRegular,
                  //     secondFontFamily: FontFamily.helveticaRegular,
                  //   ),
                  // ),
                  LottieBuilder.asset(
                    controller.getIntroData.intro3 ?? "",
                    height: 80.px,
                    backgroundLoading: true,
                    repeat: true,
                    renderCache: RenderCache.raster,
                    // frameBuilder: (context, child, composition) {
                    //   return child;
                    // },
                  ),
                  /*LottieBuilder.network(
                            height: 80.px,
                            controller.getIntroData.intro3 ?? "",
                            backgroundLoading: true,
                            repeat: true,
                            renderCache: RenderCache.raster,
                            // frameBuilder: (context, child, composition) {
                            //   return child;
                            // },
                          )
*/

                  // SizedBox(height: 12.px),
                  /*   (controller.getIntroData.intro4 != null)
                        ? SizedBox(
                            child: LottieBuilder.network(
                              controller.getIntroData.intro4 ?? "",
                              repeat: true,
                              renderCache: RenderCache.raster,
                              frameBuilder: (context, child, composition) {
                                return child;
                              },
                            ),
                          )
                        : SizedBox(height: 30.px),*/
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Center(
                    child: introCommonRichText(
                      firstText: "Your",
                      secondText: " AI Chat Assistant",
                      firstColor: AppColors.black,
                      secondColor: AppColors.primary,
                    ),
                  ).paddingSymmetric(horizontal: 20.px),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Expanded(
                    child: LottieBuilder.asset(
                      controller.getIntroData.intro1 ?? "",

                      repeat: true,
                      renderCache: RenderCache.raster,
                      // frameBuilder: (context, child, composition) {
                      //   return child;
                      // },
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  AppText(
                    "Ask in any language",
                    fontSize: 16.px,
                    fontFamily: FontFamily.helveticaBold,
                  ),
                  SizedBox(
                    height: 52.px,
                    child: ListView.separated(
                      itemCount: controller.getIntroData.languageList?.length ?? 0,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return SizedBox(width: 10.px);
                      },
                      itemBuilder: (context, index) {
                        LanguageList data =
                            controller.getIntroData.languageList?[index] ?? LanguageList();
                        return ClipOval(
                          child: CachedNetworkImage(
                            width: 30.px,
                            height: 30.px,
                            imageUrl: data.img!,

                            progressIndicatorBuilder:
                                (context, url, progress) => progressIndicatorView(circle: true),
                            errorWidget: (context, url, uri) => errorWidgetView().paddingAll(8.px),
                            // placeholder: (context, url) => Container(),
                            // errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        );
                      },
                    ),
                  ).paddingSymmetric(horizontal: 20.px),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  introCommonButton(
                    onTap: () async {
                      Get.toNamed(
                        Routes.INTRO7_SCREEN,
                        arguments: {"data": controller.getIntroData},
                      );
                    },
                    currentIndex: 0,
                  ).paddingSymmetric(horizontal: 20.px),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget introCommonButton({GestureTapCallback? onTap, required int currentIndex}) {
  return Hero(
    tag: onTap != null ? "Hero" : "New",
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        introCircleView(currentIndex: currentIndex),
        SizedBox(height: MediaQuery.of(Get.context!).size.height * 0.02),
        if (onTap != null)
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  onTap: onTap,
                  title: "title",
                  buttonColor: AppColors.primary,
                  borderRadius: 10.px,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppText(
                        "Continue",
                        fontFamily: FontFamily.helveticaBold,
                        fontSize: 16.px,
                        color: AppColors.white,
                      ),
                      // SizedBox(width: 10.px),
                      // Icon(
                      //   Icons.arrow_forward_outlined,
                      //   color: AppColors.white,
                      // ),
                    ],
                  ),
                ),
              ),
              /*SizedBox(width: 12.px),
            Transform.rotate(
              angle: 15.7,
              child: GestureDetector(
                onTap: () {
                  if (currentIndex != 0) {
                    Get.back();
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.px, horizontal: 12.px),
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(60.px)),
                  child: Image.asset(
                    ImagePath.introBack,
                    height: 25.px,
                    color: currentIndex == 0 ? AppColors.white.changeOpacity(0.4) : AppColors.white,
                  ),
                ),
              ),
            ),
            SizedBox(width: 8.px),
            GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.px, horizontal: 12.px),
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(60.px)),
                child: Image.asset(
                  ImagePath.introBack,
                  height: 25.px,
                ),
              ),
            )*/
            ],
          ).paddingOnly(bottom: 10.px),
      ],
    ),
  );
}

Widget introLineView({required double percent}) {
  return LinearPercentIndicator(
    percent: percent,
    animation: true,
    lineHeight: 5.px,
    animationDuration: 500,
    animateFromLastPercent: true,
    barRadius: Radius.circular(10.px),
    progressColor: AppColors.primary,
    backgroundColor: AppColors.blackColorIntro,
  );
}

Widget introCircleView({required int currentIndex}) {
  return SizedBox(
    height: 8.px,
    child: ListView.separated(
      primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) {
        return const SizedBox(width: 10);
      },
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          height: 8.px,
          width: (currentIndex == index) ? 25.px : 8.px,
          decoration: BoxDecoration(
            borderRadius: (currentIndex == index) ? BorderRadius.circular(10.px) : null,
            color: (currentIndex == index) ? AppColors.primary : AppColors.grayLightIntro,
            shape: (currentIndex == index) ? BoxShape.rectangle : BoxShape.circle,
          ),
        );
      },
    ),
  );
}

Widget introCommonRichText({
  required String firstText,
  required String secondText,
  Color? firstColor,
  Color? secondColor,
  String? firstFontFamily,
  String? secondFontFamily,
  double? fontSize,
  double? secondFontSize,
}) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      children: [
        TextSpan(
          text: firstText,
          style: TextStyle(
            fontSize: fontSize ?? 24.px,
            color: firstColor ?? AppColors.primary,
            fontFamily: firstFontFamily ?? FontFamily.helveticaBold,
          ),
        ),
        TextSpan(
          text: secondText,
          style: TextStyle(
            fontSize: secondFontSize ?? fontSize ?? 24.px,
            color: secondColor ?? AppColors.black,
            fontFamily: secondFontFamily ?? FontFamily.helveticaBold,
          ),
        ),
      ],
    ),
  );
}

class LottieCacheInApp {
  static final LottieCacheInApp _instance = LottieCacheInApp._internal();
  Map<String, String> cachedLottieData = {};

  LottieCacheInApp._internal();

  static LottieCacheInApp get instance => _instance;

  Future<void> preloadLottie(String url, String identifier) async {
    if (!cachedLottieData.containsKey(identifier)) {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        cachedLottieData[identifier] = response.body;
      } else {
        throw Exception("Failed to fetch Lottie JSON");
      }
    }
  }

  String? getLottie(String identifier) {
    return cachedLottieData[identifier];
  }
}
