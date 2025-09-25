import 'package:chatsy/app/common_widget/common_container.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/helper/font_family.dart';
import 'package:chatsy/app/helper/image_path.dart';
import 'package:chatsy/extension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../intro1Screen/views/intro1_screen_view.dart';
import '../controllers/notification_permission_page_controller.dart';

class NotificationPermissionPageView extends GetView<NotificationPermissionPageController> {
  const NotificationPermissionPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: NotificationPermissionPageController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                      LottieBuilder.asset(
                        controller.getIntroData.notifications ?? "",
                        height: 170.px,
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
                      Center(child: Image.asset(ImagePath.notificationOn, height: 36.px)),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                      introCommonRichText(
                        firstText: "Stay ",
                        secondText: "Ahead",
                        firstColor: AppColors.black,
                        secondColor: AppColors.primary,
                      ).paddingSymmetric(horizontal: 30.px),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                      CommonContainer(
                        padding: EdgeInsets.only(top: 20.px),
                        color: const Color(0XFFB3B3B3).changeOpacity(0.2),
                        child: Column(
                          children: [
                            introCommonRichText(
                              firstText: "ChatSY would like to send you notifications",
                              secondText: "",
                              firstColor: AppColors.black,
                              secondColor: AppColors.black,
                              secondFontFamily: FontFamily.helveticaRegular,
                              fontSize: 17.px,
                              secondFontSize: 14.px,
                            ).paddingSymmetric(horizontal: 30.px),
                            SizedBox(height: 17.px),
                            Container(height: 1, color: const Color(0XFF808080).changeOpacity(0.4)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.goToHome();
                                    },
                                    child: Center(
                                      child: AppText(
                                        "Don’t Allow",
                                        fontSize: 17.px,
                                        color: AppColors.black,
                                        fontFamily: FontFamily.helveticaBold,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 40.px,
                                  alignment: Alignment.center,
                                  color: const Color(0XFF808080).changeOpacity(0.4),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      await Permission.notification.request();
                                      controller.goToHome();
                                    },
                                    child: Center(
                                      child: AppText(
                                        "Allow",
                                        fontSize: 17.px,
                                        color: AppColors.primary,
                                        fontFamily: FontFamily.helveticaBold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ).paddingSymmetric(horizontal: MediaQuery.of(context).size.width * 0.15),
                      SizedBox(height: 10.px),
                      SlideAnimation(
                        position: controller.position,
                        child: Align(
                          alignment: Alignment(0.4, 0),
                          child: SvgPicture.asset(ImagePath.arrowUp),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.px),
                  child: introCommonButton(currentIndex: 4),
                ).paddingOnly(bottom: MediaQuery.of(context).size.height * 0.04),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SlideAnimation extends StatelessWidget {
  const SlideAnimation({super.key, required this.child, required this.position});

  final Widget child;

  final Animation<Offset> position;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: position, child: child);
  }
}
