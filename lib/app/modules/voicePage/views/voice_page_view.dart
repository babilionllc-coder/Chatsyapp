import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/extension.dart';

import '../../../Localization/local_language.dart';
import '../../../common_widget/common_screen.dart';
import '../../../helper/image_path.dart';
import '../../home/controllers/user_profile_model.dart';
import '../../purchase/controllers/purchase_controller.dart';
import '../../themePage/views/selected_view.dart';
import '../controllers/voice_page_controller.dart';

class VoicePageView extends GetView<VoicePageController> {
  const VoicePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoicePageController>(
      init: VoicePageController(),
      builder: (controller) {
        return CommonScreen(
          title: Languages.of(context)!.voice,
          body: Obx(() {
            controller.count.value;

            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 17.px),
              physics: const BouncingScrollPhysics(),
              children: [
                AppText(
                  Languages.of(context)!.systemVoices,
                  color: AppColors().darkAndWhite.changeOpacity(0.5),
                ),
                SizedBox(height: 17.px),
                (Constants.isShowElevenLab != "1")
                    ? SelectedView(
                      onTap: () {},
                      data: SubscriptionCarousel(
                        title: Languages.of(context)!.defaultVoice,
                        description: ImagePath.user12,
                      ),
                      index: 0,
                      count: controller.count,
                      height: 32.px,
                    ).paddingSymmetric(horizontal: 17.px)
                    : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 12.px);
                      },
                      itemCount: controller.voiceList.length,
                      itemBuilder: (context, index) {
                        VoiceDtl data = controller.voiceList[index];
                        return SelectedView(
                          height: 32.px,
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            controller.updateVoiceStatusAPI(
                              voiceId: data.voiceId ?? "1",
                              index: index,
                            );
                          },
                          data: SubscriptionCarousel(title: data.name, description: data.img),
                          index: index,
                          count: controller.count,
                        );
                      },
                    ),
              ],
            );
          }),
        );
      },
    );
  }
}
