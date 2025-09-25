import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/routes/app_pages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common_widget/common_prompt_view.dart';
import '../../../common_widget/common_screen.dart';
import '../../../helper/image_path.dart';
import '../../chat_gpt/views/chat_gpt_view.dart';
import '../../imageGeneration/controllers/image_generation_controller.dart';
import '../../newChat/component/text_to_speech.dart';
import '../controllers/image_show_controller.dart';

class ImageShowView extends GetView<ImageShowController> {
  const ImageShowView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ImageShowController>(
      init: ImageShowController(),
      builder: (controller) {
        return CommonScreen(
          leadingOnTap: () async {
            Get.back();
          },
          backgroundColor: AppColors().backgroundColor1,
          body: ListView(
            shrinkWrap: true,
            primary: false,
            padding: EdgeInsets.zero,
            children: [
              Row(
                children: [
                  BGIcon(
                    icon: ImagePath.icDeletePhoto,
                    padding: 10.px,
                    marginHorizontal: 0.px,
                    color: isLight ? AppColors.primaryLight : Color(0xFF333438),
                    iconColor: AppColors.primary,
                    checkOnPress: () {
                      Get.back(result: HttpUtil.deleteImage);
                    },
                  ),
                  Spacer(),
                  // BGIcon(
                  //   icon: ImagePath.report,
                  //   padding: 6.px,
                  //   marginHorizontal: 6.px,
                  //   color: isLight ? AppColors.primaryLight : Color(0xFF333438),
                  //   iconColor: AppColors.primary,
                  //   checkOnPress: () {
                  //     Get.toNamed(Routes.REASON, arguments: {'reason': controller.imageUrl.value});
                  //   },
                  // ),
                  BGIcon(
                    icon: ImagePath.icRotatePhoto,
                    padding: 10.px,
                    marginHorizontal: 6.px,
                    color: isLight ? AppColors.primaryLight : Color(0xFF333438),
                    iconColor: AppColors.primary,
                    checkOnPress: () {
                      Get.back(result: HttpUtil.regenerate);
                    },
                  ),
                  BGIcon(
                    icon: ImagePath.report,
                    padding: 6.px,
                    marginHorizontal: 0.px,
                    color: isLight ? AppColors.primaryLight : Color(0xFF333438),
                    iconColor: AppColors.primary,
                    checkOnPress: () {
                      Get.toNamed(Routes.REASON, arguments: {'reason': controller.imageUrl.value});
                    },
                  ),
                  BGIcon(
                    icon: ImagePath.icSharePhoto,
                    padding: 10.px,
                    marginHorizontal: 6.px,
                    color: isLight ? AppColors.primaryLight : Color(0xFF333438),
                    iconColor: AppColors.primary,
                    checkOnPress: () {
                      controller.downloadImage(true);
                      //  Share.share(controller.imageUrl.value);
                    },
                  ),
                  BGIcon(
                    icon: ImagePath.icDownloadPhoto,
                    padding: 10.px,
                    marginHorizontal: 0.px,
                    color: isLight ? AppColors.primaryLight : Color(0xFF333438),
                    iconColor: AppColors.primary,
                    checkOnPress: () {
                      controller.downloadImage(false);
                    },
                  ),
                ],
              ).marginOnly(bottom: 12.px),
              Hero(
                tag: controller.imageUrl.value,
                child: Container(
                  // width: double.infinity,
                  // height: Get.size.width / 1.1,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(17.px),
                    child: CachedNetworkImage(
                      imageUrl: controller.imageUrl.value,
                      progressIndicatorBuilder:
                          (context, url, progress) => imageGenerationLoadingImage(),
                      errorWidget:
                          (context, url, uri) => errorWidgetView(height: 25.px, wight: 25.px),
                      // height: 25.px,
                      // width: 25.px,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: controller.question.value));
                      Utils().showToast(message: "Text copied");
                    },
                    child: CommonPromptView(prompt: "Copy Prompt", boxShadow: false),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Get.back(result: HttpUtil.createAnother);
                    },
                    child: CommonPromptView(
                      prompt: "Create Another",
                      marginRight: 0.px,
                      boxShadow: false,
                      color: AppColors.primary,
                      prefixIcon: SvgPicture.asset(
                        ImagePath.icCreateAnother,
                        height: 16.px,
                        width: 16.px,
                        color: AppColors.primary,
                      ).marginOnly(right: 4.px),
                    ),
                  ),
                ],
              ).marginOnly(top: 10.px),
            ],
          ).marginSymmetric(horizontal: 16.px),
        );
      },
    );
  }
}
