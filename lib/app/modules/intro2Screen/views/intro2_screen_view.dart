import 'package:chatsy/app/modules/intro1Screen/views/intro1_screen_view.dart';
import 'package:lottie/lottie.dart' hide LottieCache;

import '/extension.dart';
import '../../../helper/all_imports.dart';
import '../../../routes/app_pages.dart';
import '../controllers/intro2_screen_controller.dart';

class Intro2ScreenView extends GetView<Intro2ScreenController> {
  const Intro2ScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Intro2ScreenController>(
      init: Intro2ScreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: LottieBuilder.asset(
                      controller.getIntroData.intro2.log ?? "",
                      repeat: true,
                      renderCache: RenderCache.raster,
                    ),
                    /*
                                            LottieBuilder.network(
                          controller.getIntroData.intro2!,
                          // controller: controller.lottieController,
                          repeat: true,
                          renderCache: RenderCache.raster,
                          // frameBuilder: (context, child, composition) {
                          //   return child;
                          // },
                        )
                                            */
                  ),
                ),
                SizedBox(
                  height: 40.px,
                  child: LottieBuilder.asset(
                    controller.getIntroData.happyUsers ?? "",
                    repeat: true,
                    renderCache: RenderCache.raster,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.004),

                introCommonRichText(
                  firstText: "Join thousands of",
                  secondText: "\nHappy Users",
                  firstColor: AppColors.black,
                  secondColor: AppColors.primary,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.px),
                  child: introCommonButton(
                    onTap: () async {
                      Get.toNamed(Routes.INTRO3, arguments: {"data": controller.getIntroData});
                    },
                    currentIndex: 2,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
