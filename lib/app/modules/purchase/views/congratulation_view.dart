import 'package:chatsy/extension.dart';
import 'package:chatsy/main.dart';
import 'package:lottie/lottie.dart';

import '../../../Localization/local_language.dart';
import '../../../common_widget/common_button.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/font_family.dart';
import '../../../helper/image_path.dart';

class CongratulationView extends StatelessWidget {
  CongratulationView({super.key, required this.onTap});

  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final T = AppStrings.T;

    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LottieBuilder.asset(
              ImagePath.congratulation,
              height: 132.px,
              // backgroundLoading: true,
              repeat: true,
              reverse: false,
              renderCache: RenderCache.raster,
              delegates: LottieDelegates(
                values: [
                  ValueDelegate.color([
                    'Path 1',
                    'ADBE Vector Shape - Group',
                    'Stroke 1',
                  ], value: Colors.red),
                ],
              ),
            ),
            Center(
              child: AppText(
                T.congratulations,
                fontSize: 24.px,
                color: AppColors.black,
                fontFamily: FontFamily.helveticaBold,
              ),
            ),
            Center(
              child: AppText(
                T.youAreNowChatSYPro,
                fontSize: 12.px,
                color: AppColors.black.changeOpacity(0.6),
                textAlign: TextAlign.center,
              ).paddingSymmetric(horizontal: 10.w),
            ),
            SizedBox(height: 30.px),
            CommonButton(
              onTap: onTap,
              title: Languages.of(Get.context!)!.letsGo,
            ),
          ],
        ).paddingSymmetric(vertical: 20.px),
        GestureDetector(
          onTap: onTap,
          child: LottieBuilder.asset(ImagePath.congrats, repeat: true),
        ),
      ],
    );
  }
}

class ShowLogInView extends StatelessWidget {
  const ShowLogInView({super.key, required this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final T = AppStrings.T;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.px),
      ),
      padding: EdgeInsets.symmetric(horizontal: 37.px, vertical: 20.px),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Image.asset(scale: 3, ImagePaths.done),
          SizedBox(height: 15.px),
          AppText(
            maxLines: 1,
            T.oops,
            fontSize: 24.px,
            textAlign: TextAlign.center,
            color: AppColors.black,
            fontFamily: FontFamily.helveticaBold,
          ),
          SizedBox(height: 12.px),
          AppText(
            maxLines: 10,
            T.looksLikeYouReNotLoggedIn,
            textAlign: TextAlign.center,
            color: AppColors.black,
          ),
          SizedBox(height: 12.px),
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  onTap: Get.back,
                  title: T.cancel,
                  borderRadius: 10.px,
                  buttonColor: AppColors().grayMix2,
                  textColor: AppColors.black,
                ),
              ),
              SizedBox(width: 10.px),
              Expanded(
                child: CommonButton(
                  title: T.signIn,
                  onTap: onTap,
                  textColor: AppColors.white,
                  borderRadius: 10.px,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
