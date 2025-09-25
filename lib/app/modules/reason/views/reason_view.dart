import 'package:chatsy/app/common_widget/common_button.dart';
import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/extension.dart';

import '../../../Localization/local_language.dart';
import '../../../common_widget/comman_text_field.dart';
import '../controllers/reason_controller.dart';

class ReasonView extends GetView<ReasonController> {
  const ReasonView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReasonController>(
      init: ReasonController(),
      builder: (controller) {
        return CommonScreen(
          title:
              (controller.isDeleteAccount)
                  ? Languages.of(context)!.deleteAccount
                  : Languages.of(context)!.report,
          body: Obx(() {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.px),
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                AppText(Languages.of(context)!.chooseAReason, fontSize: 17.px),
                ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 20.px),
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.deleteReasonList.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 15.px);
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.count.value = index;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors().ansColor,
                          borderRadius: BorderRadius.circular(10.px),
                          border: Border.all(
                            color:
                                controller.count.value == index
                                    ? AppColors.primary
                                    : AppColors.transparent,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14.px, horizontal: 16.px),
                        child: AppText(controller.deleteReasonList[index]),
                      ),
                    );
                  },
                ),
                if (controller.count.value == (controller.deleteReasonList.length - 1))
                  CommonTextField(
                    maxLine: 3,
                    minLine: 3,
                    isBorder: true,

                    borderRadius: BorderRadius.circular(10.px),
                    padding: EdgeInsets.symmetric(vertical: 12.px, horizontal: 10.px),
                    color: AppColors().conColor2,
                    hintText: Languages.of(context)!.writeYourReason,

                    controller: controller.otherReasonController,
                    onChanged: (val) {},
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    // hintText: formFields.name,
                    // color: isLight ? AppColors.transparent : AppColors.lightBlack,
                    borderColor: AppColors().darkAndWhite.changeOpacity(0.1),
                    cursorColor: AppColors().darkAndWhite,
                    hintColor: AppColors.gray,
                  ).paddingOnly(bottom: 25.px),
                CommonButton(
                  onTap: () async {
                    if (controller.isValidation()) {
                      if (controller.isDeleteAccount) {
                        if (await controller.deleteShowDialog()) {
                          controller.deleteAccountAPI(
                            reason:
                                controller.count.value == (controller.deleteReasonList.length - 1)
                                    ? controller.otherReasonController.text
                                    : controller.deleteReasonList[controller.count.value],
                          );
                        }
                      } else {
                        controller.deleteAccountAPI(
                          reason:
                              controller.count.value == (controller.deleteReasonList.length - 1)
                                  ? controller.otherReasonController.text
                                  : controller.deleteReasonList[controller.count.value],
                        );
                      }
                    }
                  },
                  title:
                      (controller.isDeleteAccount)
                          ? Languages.of(context)!.deleteAccount
                          : Languages.of(context)!.report,
                ),
              ],
            );
          }),
        );
      },
    );
  }
}
