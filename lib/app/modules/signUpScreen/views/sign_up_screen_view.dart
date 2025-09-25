import 'package:chatsy/app/common_widget/common_button.dart';
import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/extension.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../gen/assets.gen.dart';
import '../../../Localization/local_language.dart';
import '../../../common_widget/comman_text_feild_bottom_sheet.dart';
import '../../../helper/image_path.dart';
import '../../../routes/app_pages.dart';
import '../../Login/views/login_view.dart';
import '../controllers/sign_up_screen_controller.dart';

class SignUpScreenView extends GetView<SignUpScreenController> {
  const SignUpScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpScreenController>(
      init: SignUpScreenController(),
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
                      firstText: Languages.of(context)!.createNewAccount,
                      secondText: Languages.of(context)!.enterYourDetailsBelowTo,
                    ),
                    SizedBox(height: 30.px),
                    CommonTextFiledBottomSheet(
                      title: Languages.of(context)!.fullName,
                      fillColor: AppColors().darkWhiteAndBlack2.changeOpacity(0.05),
                      padding: EdgeInsets.symmetric(vertical: 15.px),
                      controller: controller.userName,
                      prefixIconPath: ImagePath.user,
                      hintText: Languages.of(context)!.enterFullName,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 15.px),
                    CommonTextFiledBottomSheet(
                      title: Languages.of(context)!.email,
                      fillColor: AppColors().darkWhiteAndBlack2.changeOpacity(0.05),
                      padding: EdgeInsets.symmetric(vertical: 15.px),
                      controller: controller.email,
                      prefixIconPath: ImagePath.email,
                      keyboardType: TextInputType.emailAddress,
                      hintText: Languages.of(context)!.enterEmail,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        FilteringTextInputFormatter.deny(RegExp('A-Z')),
                      ],
                    ),
                    SizedBox(height: 15.px),
                    CommonTextFiledBottomSheet(
                      title: Languages.of(context)!.password,
                      fillColor: AppColors().darkWhiteAndBlack2.changeOpacity(0.05),
                      padding: EdgeInsets.symmetric(vertical: 15.px),
                      controller: controller.password,
                      prefixIconPath: ImagePath.lock,
                      textInputAction: TextInputAction.next,
                      obscureText: controller.isShowPassword.value,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: Languages.of(context)!.enterPassword,
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
                      title: Languages.of(context)!.confirmPassword,
                      fillColor: AppColors().darkWhiteAndBlack2.changeOpacity(0.05),
                      padding: EdgeInsets.symmetric(vertical: 15.px),
                      controller: controller.configPassword,
                      prefixIconPath: ImagePath.lock,
                      obscureText: controller.isConfirmShowPassword.value,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: Languages.of(context)!.enterConfirmPassword,
                      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
                      suffixIcon: GestureDetector(
                        onTap: () {
                          controller.isConfirmShowPassword.value =
                              !controller.isConfirmShowPassword.value;
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.px, left: 10.px),
                          child: SvgPicture.asset(
                            controller.isConfirmShowPassword.value
                                ? Assets.svg.icEye
                                : Assets.svg.icEyeSlash,
                            color: AppColors().grayMix,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.px),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.isAgree.value = !controller.isAgree.value;
                          },
                          child: Container(
                            height: 24.px,
                            width: 24.px,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primary, width: 2),
                              borderRadius: BorderRadius.circular(5.px),
                            ),
                            child:
                                (controller.isAgree.value)
                                    ? Icon(Icons.done, size: 20.px, color: AppColors.primary)
                                    : const SizedBox(),
                          ),
                        ),
                        SizedBox(width: 10.px),
                        Expanded(
                          child: AppRichText(
                            firstText: "${Languages.of(context)!.iAgreeToThe} ",
                            secondText: Languages.of(context)!.privacyPolicy,
                            firstTextColor: AppColors().grayColorMix,
                            thirdTextColor: AppColors().grayColorMix,
                            secondTextColor: AppColors().darkAndWhite,
                            firstFontSize: 16.px,
                            secondFontSize: 16.px,
                            thirdFontSize: 16.px,
                            fourthFontSize: 16.px,
                            textAlign: TextAlign.start,
                            thirdText: " ${Languages.of(context)!.and}",
                            fourthText: "${Languages.of(context)!.termsOfUse}.",
                            onTap: () {
                              Get.toNamed(Routes.PRIVACY_POLICY);
                            },
                            forthOnTap: () {
                              Get.toNamed(Routes.TERMS_PAGE);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.px),
                    CommonButton(
                      onTap: () {
                        utils.hideKeyboard();
                        controller.isValidationOfSignUp();
                      },
                      title: Languages.of(context)!.signUp,
                    ),
                    SizedBox(height: 20.px),
                    Center(
                      child: AppRichText(
                        firstText: "${Languages.of(context)!.alreadyHaveAnAccount} ",
                        secondText: Languages.of(context)!.signIn,
                        firstTextColor: AppColors().grayColorMix,
                        secondTextColor: AppColors().darkAndWhite,
                        thirdTextColor: AppColors().grayColorMix,
                        onTap: () {
                          Get.back();
                        },
                        firstFontSize: 16.px,
                        secondFontSize: 16.px,
                      ),
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
