import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../Localization/local_language.dart';
import '../../../helper/all_imports.dart';
import '../controllers/about_us_controller.dart';

class AboutUsView extends GetView<AboutUsController> {
  const AboutUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutUsController>(
      init: AboutUsController(),
      builder: (controller) {
        return CommonScreen(
          title: Languages.of(context)!.aboutUs,
          body: Obx(() {
            return SafeArea(
              child: Visibility(
                visible: !controller.isHide.value,
                child:
                    (controller.webController != null)
                        ? WebViewWidget(controller: controller.webController!)
                        : SizedBox(),
              ),
            );
          }),
        );
      },
    );
  }
}
