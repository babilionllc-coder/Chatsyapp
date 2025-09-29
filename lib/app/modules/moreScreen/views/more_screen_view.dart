import 'package:chatsy/app/common_widget/common_button.dart';
import 'package:chatsy/app/common_widget/common_screen.dart';

import '../../../Localization/local_language.dart';
import '../../../helper/all_imports.dart';
import '../../../routes/app_pages.dart';
import '../controllers/more_screen_controller.dart';

class MoreScreenView extends GetView<MoreScreenController> {
  const MoreScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      title: Languages.of(context)!.more,
      body: Column(
        children: [
          CommonButton(
            onTap: () {
              HapticFeedback.mediumImpact();

              Get.toNamed(Routes.REASON);
            },
            title: Languages.of(context)!.deleteAccount,
          ).paddingSymmetric(horizontal: 20.px),
        ],
      ),
    );
  }
}
