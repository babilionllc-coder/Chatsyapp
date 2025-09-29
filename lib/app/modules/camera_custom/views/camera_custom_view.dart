import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/extension.dart';
import 'package:camera/camera.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Localization/local_language.dart';
import '../../../common_widget/common_button.dart';
import '../../../helper/image_path.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../controllers/camera_custom_controller.dart';

class CameraCustomView extends GetView<CameraCustomController> {
  const CameraCustomView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CameraCustomController>(
      init: CameraCustomController(),
      builder: (controller) {
        return CommonScreen(
          title: Languages.of(context)!.takeOrChoosePhoto,
          leading: SizedBox(),
          actions: [
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.cancel, color: AppColors().darkAndWhite),
            ),
            SizedBox(width: 16.px),
          ],
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.px),
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(12.px)),
                    ),
                    child: CameraPreview(controller.cameraController),
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors().bgColor3,
                        border: Border.all(width: 1.px, color: AppColors.black.changeOpacity(0.04)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.px),
                        child: SvgPicture.asset(
                          ImagePath.icBack1,
                          height: 24.px,
                          width: 24.px,
                          color: AppColors().grayMix,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.px),
                  Expanded(
                    child: CommonButton(
                      onTap: () => controller.takePicture(),
                      fontSize: 14.px,
                      title: Languages.of(Get.context!)!.recognize,
                      textColor: AppColors().whiteAndDark,
                    ),
                  ),
                  SizedBox(width: 20.px),
                  GestureDetector(
                    onTap: () async {
                      HapticFeedback.mediumImpact();
                      final ImagePicker picker = ImagePicker();
                      final XFile? image2 = await picker.pickImage(source: ImageSource.gallery);
                      if (image2 != null) {
                        if ((!await Utils().isImageCorrupted(image2.path))) {
                          await cropImageProcess(imagePath: image2.path).then((value) {
                            Get.back(result: value?.path.toString());
                          });
                        } else {
                          Utils().showToast(
                            message:
                                "The selected image is corrupted. Please choose a different one.",
                          );
                        }
                      } else {}
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors().bgColor3,
                        border: Border.all(width: 1.px, color: AppColors.black.changeOpacity(0.04)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.px),
                        child: SvgPicture.asset(
                          ImagePath.icGallery1,
                          height: 24.px,
                          width: 24.px,
                          color: AppColors().grayMix,
                        ),
                      ),
                    ),
                  ),
                ],
              ).paddingAll(20.px),
            ],
          ),
        );
      },
    );
  }
}
