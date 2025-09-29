import 'package:chatsy/app/common_widget/common_button.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/extension.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../gen/assets.gen.dart';
import '../../../Localization/local_language.dart';
import '../../../common_widget/comman_text_feild_bottom_sheet.dart';
import '../../../common_widget/common_screen.dart';
import '../../../helper/image_path.dart';
import '../../Login/views/login_view.dart';
import '../controllers/reset_password_screen_controller.dart';

class ResetPasswordScreenView extends GetView<ResetPasswordScreenController> {
  const ResetPasswordScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResetPasswordScreenController>(
      init: ResetPasswordScreenController(),
      builder: (controller) {
        return CommonScreen(
          body: Obx(() {
            return ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                SizedBox(height: 30.px),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TwoLineTextView(
                      firstText: Languages.of(context)!.resetPassword,
                      secondText: Languages.of(context)!.yourNewPasswordMustBe,
                    ),
                    SizedBox(height: 30.px),
                    CommonTextFiledBottomSheet(
                      title: Languages.of(context)!.newPassword,
                      fillColor: AppColors().darkWhiteAndBlack2.changeOpacity(0.05),
                      padding: EdgeInsets.symmetric(vertical: 15.px),
                      controller: controller.password,
                      prefixIconPath: ImagePath.lock,
                      obscureText: controller.isShowPassword.value,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.next,
                      hintText: Languages.of(context)!.enterNewPassword,
                      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.isShowPassword.value = !controller.isShowPassword.value;
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.px, left: 10.px),
                          child: SvgPicture.asset(
                            controller.isShowPassword.value
                                ? Assets.svg.icEye
                                : Assets.svg.icEyeSlash,
                            color: AppColors().grayMix,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.px),
                    CommonTextFiledBottomSheet(
                      title: Languages.of(context)!.newConfirmPassword,
                      fillColor: AppColors().darkWhiteAndBlack2.changeOpacity(0.05),
                      padding: EdgeInsets.symmetric(vertical: 15.px),
                      controller: controller.confirmPassword,
                      prefixIconPath: ImagePath.lock,
                      obscureText: controller.isShowConfirmPassword.value,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: Languages.of(context)!.enterConfirmNewPassword,
                      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.isShowConfirmPassword.value =
                              !controller.isShowConfirmPassword.value;
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.px, left: 10.px),
                          child: SvgPicture.asset(
                            controller.isShowConfirmPassword.value
                                ? Assets.svg.icEye
                                : Assets.svg.icEyeSlash,
                            color: AppColors().grayMix,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 60.px),
                    CommonButton(
                      onTap: () {
                        utils.hideKeyboard();

                        controller.isValidationResentPassword();
                      },
                      title: Languages.of(context)!.updatePassword,
                    ),
                  ],
                ).paddingSymmetric(horizontal: commonLeadingWith),
                SizedBox(height: 30.px),
              ],
            );
          }),
        );
      },
    );
  }
}
