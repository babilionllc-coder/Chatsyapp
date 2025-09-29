import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../Localization/local_language.dart';
import '../../../helper/app_colors.dart';
import '../controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PrivacyPolicyController>(
      init: PrivacyPolicyController(),
      builder: (controller) {
        return Obx(() {
          return CommonScreen(
              backgroundColor: AppColors().backgroundColor1,
              title: Languages.of(context)!.privacyPolicy,
              body: SafeArea(
                  child: Visibility(
                visible: !controller.isHide.value,
                child: (controller.webController != null) ? WebViewWidget(controller: controller.webController!) : SizedBox(),
              )));
        });
      },
    );
  }
}
