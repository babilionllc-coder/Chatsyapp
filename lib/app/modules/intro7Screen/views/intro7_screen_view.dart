import 'package:chatsy/app/helper/font_family.dart';
import 'package:chatsy/app/helper/image_path.dart';
import 'package:chatsy/app/modules/intro1Screen/views/intro1_screen_view.dart';
import 'package:lottie/lottie.dart' hide LottieCache;
import 'package:lottie/lottie.dart';
import 'package:square_progress_indicator/square_progress_indicator.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../helper/all_imports.dart';
import '../../../routes/app_pages.dart';
import '../../chat_gpt/views/chat_gpt_view.dart';
import '../../intro1Screen/models/get_intro_details_model.dart';
import '../controllers/intro7_screen_controller.dart';

class Intro7ScreenView extends GetView<Intro7ScreenController> {
  const Intro7ScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Intro7ScreenController>(
      init: Intro7ScreenController(),
      builder: (controller) {
        Utils.darkStatusBar();

        return Obx(() {
          controller.value.value;
          return Scaffold(
            backgroundColor: AppColors.white,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.px),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Expanded(
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          SizedBox(
                            height: (MediaQuery.of(context).size.width - 20.px),
                            width: MediaQuery.of(context).size.width,
                            child:
                                (controller.videoController != null &&
                                        controller.videoController!.value.isInitialized &&
                                        controller.value.value != 0)
                                    ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20.px),
                                      ),
                                      child: SquareProgressIndicator(
                                        value: controller.value.value,
                                        width: 100,
                                        height: 100,
                                        borderRadius: 20,
                                        strokeCap: StrokeCap.butt,
                                        color: AppColors.transparent,
                                        strokeWidth: 10,
                                        emptyStrokeWidth: 1,
                                        strokeAlign: SquareStrokeAlign.center,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20.px),
                                          child: VisibilityDetector(
                                            key: ObjectKey(controller.videoController ?? "0"),
                                            onVisibilityChanged: (visibilityInfo) {
                                              // if (visibilityInfo.visibleFraction > 0.5) {
                                              //   if ((controller.videoController?.value.position.inSeconds ?? 0) <= 1) {
                                              //     controller.videoInitialize();
                                              //   } else {
                                              //     controller.videoController?.play();
                                              //   }
                                              //   debugPrint("controller.videoController?.play");
                                              // } else if (visibilityInfo.visibleFraction < 0.5) {
                                              //   if ((controller.videoController?.value.position.inSeconds ?? 0) <= 1) {
                                              //     controller.videoController = null;
                                              //   } else {
                                              //     controller.videoController?.pause();
                                              //   }
                                              //   debugPrint("controller.videoController?.pause");
                                              // }
                                            },
                                            child: VideoPlayer(controller.videoController!),
                                          ),
                                        ),
                                      ).paddingAll(5.px),
                                    )
                                    : progressIndicatorView(),
                            /*child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.px), color: AppColors.white.changeOpacity(0.3).changeOpacity(0.5)),
                            ),*/
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                          /*Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: controller.getIntroData.toolList?.map(
                                        (e) {
                                          return ClipRRect(
                                            borderRadius: BorderRadius.circular(10.px),
                                            child: CachedNetworkImage(
                                              width: 38.px,
                                              height: 38.px,
                                              imageUrl: e.img ?? "",
                                              progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(borderRadius: 10.px),
                                              errorWidget: (context, url, uri) => errorWidgetView().paddingAll(8.px),
                                              // placeholder: (context, url) => Container(),
                                              // errorWidget: (context, url, error) => const Icon(Icons.error),
                                            ),
                                          );
                                        },
                                      ).toList() ??
                                      []),
                            ),*/
                          SizedBox(
                            height: 40.px,
                            child: LottieBuilder.asset(
                              controller.getIntroData.problemSolvingTasks ?? "",
                              repeat: true,
                              renderCache: RenderCache.raster,
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                          Center(
                            child: introCommonRichText(
                              firstText: 'Solve',
                              secondText: " Problems & Tasks",
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.getIntroData.solveProblemList?.length ?? 0,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10.px);
                      },
                      itemBuilder: (context, index) {
                        SolveProblemList data =
                            controller.getIntroData.solveProblemList?[index] ?? SolveProblemList();
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // CachedNetworkImage(
                            //   width: 25.px,
                            //   height: 25.px,
                            //   imageUrl: data.img!,
                            //
                            //   progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(circle: true),
                            //   errorWidget: (context, url, uri) => errorWidgetView().paddingAll(8.px),
                            //   // placeholder: (context, url) => Container(),
                            //   // errorWidget: (context, url, error) => const Icon(Icons.error),
                            // ),
                            Flexible(child: Image.asset(ImagePath.trues2, height: 20.px)),
                            SizedBox(width: 5.px),
                            Flexible(
                              flex: 4,
                              fit: FlexFit.tight,
                              child: AppText(
                                data.description ?? "",
                                fontSize: 14.px,
                                color: AppColors.black,
                                fontFamily: FontFamily.helveticaBold,
                              ),
                            ),
                            SizedBox(width: 5.px),
                            // Icon(
                            //   Icons.done,
                            //   color: AppColors.primary,
                            //   size: 25.px,
                            // )
                          ],
                        );
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    introCommonButton(
                      onTap: () {
                        if ((controller.videoController?.value.position.inSeconds ?? 0) <= 1) {
                          controller.videoController?.dispose();
                        } else {
                          controller.videoController?.pause();
                        }
                        Get.toNamed(
                          Routes.INTRO2_SCREEN,
                          arguments: {"data": controller.getIntroData},
                        )!.then((val) {
                          if ((controller.videoController?.value.position.inSeconds ?? 0) <= 1) {
                            controller.videoInitialize();
                          } else {
                            debugPrint("asoubajkbkb");
                            controller.videoController?.play();
                          }
                        });
                      },
                      currentIndex: 1,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
