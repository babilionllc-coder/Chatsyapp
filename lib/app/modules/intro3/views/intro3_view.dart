import 'package:chatsy/app/helper/font_family.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../helper/all_imports.dart';
import '../../../routes/app_pages.dart';
import '../../chat_gpt/views/chat_gpt_view.dart';
import '../../intro1Screen/views/intro1_screen_view.dart';
import '../controllers/intro3_controller.dart';

class Intro3View extends GetView<Intro3Controller> {
  const Intro3View({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Intro3Controller>(
      init: Intro3Controller(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.white,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                AppText("Did You Know?", fontSize: 30.px, fontFamily: FontFamily.helveticaBold),
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: controller.getIntroData.didUKnow ?? "",
                    progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(),
                    errorWidget: (context, url, uri) => errorWidgetView().paddingAll(8.px),
                  ).paddingSymmetric(horizontal: 20.px),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                introCommonRichText(firstText: "ChatSY", secondText: "\ncan change your life"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.px),
                  child: introCommonButton(
                    onTap: () async {
                      Get.toNamed(
                        Routes.NOTIFICATION_PERMISSION_PAGE,
                        arguments: {"data": controller.getIntroData},
                      );
                    },
                    currentIndex: 3,
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
