import 'package:chatsy/app/helper/image_path.dart';
import 'package:gif_view/gif_view.dart';

import '../../../helper/all_imports.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  (isLight) ? ImagePath.backgroundImage : ImagePath.backgroundImageDark,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GifView.asset(ImagePath.loader, height: 150.px, width: 150.px, frameRate: 25),
                // AppText(
                //   Languages.of(context)!.aiChatSy.toUpperCase(),
                //   fontSize: 34.px,
                //   color: AppColors().darkAndWhite,
                //   fontWeight: FontWeight.w800,
                // )
              ],
            ),
          ),
        );
      },
    );
  }
}
