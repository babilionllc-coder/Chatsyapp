import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/modules/themePage/views/selected_view.dart';
import 'package:chatsy/extension.dart';

import '../../../Localization/local_language.dart';
import '../../purchase/controllers/purchase_controller.dart';
import '../controllers/theme_page_controller.dart';

class ThemePageView extends GetView<ThemePageController> {
  const ThemePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemePageController>(
      init: ThemePageController(),
      builder: (controller) {
        return CommonScreen(
          title: Languages.of(context)!.theme,
          body: Obx(() {
            controller.count.value;

            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 17.px),
              separatorBuilder: (context, index) {
                return SizedBox(height: 12.px);
              },
              itemCount: controller.themeList.length,
              itemBuilder: (context, index) {
                SubscriptionCarousel data = controller.themeList[index];
                return SelectedView(
                  color: AppColors().darkAndWhite,
                  onTap: () async {
                    HapticFeedback.mediumImpact();
                    if (data.title == Languages.of(context)!.lightMode) {
                      isLight = true;
                    } else {
                      isLight = false;
                    }
                    await getStorageData.saveBool(
                      getStorageData.isLight,
                      isLight,
                    );
                    getStorageData.readBool(getStorageData.isLight)?.log;
                    Get.forceAppUpdate();
                    controller.count.value = index;

                    controller.update();
                  },
                  data: data,
                  index: index,
                  count: controller.count,
                );
              },
            );
          }),
        );
      },
    );
  }
}
