import 'package:chatsy/app/common_widget/common_button.dart';
import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/common_widget/iphone_has_notch.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/helper/font_family.dart';
import 'package:chatsy/app/helper/image_path.dart';
import 'package:chatsy/app/routes/app_pages.dart';
import 'package:chatsy/extension.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../gen/assets.gen.dart';
import '../../../Localization/local_language.dart';
import '../../../common_widget/comman_text_feild_bottom_sheet.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  bool? mainLogIn = false;

  LoginView({this.mainLogIn, super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Obx(() {
          controller.isReview.value;
          return GestureDetector(
            onTap: () {
              utils.hideKeyboard();
            },
            child: CommonScreen(
              bottomNavigationBar: AppRichText(
                firstText: Languages.of(context)!.doHaveAnAccount,
                secondText: " ${Languages.of(context)!.signUp}",
                firstTextColor: AppColors().grayColorMix,
                secondTextColor: AppColors().darkAndWhite,
                onTap: () {
                  Get.toNamed(Routes.SIGN_UP_SCREEN);
                },
              ).paddingOnly(bottom: (IphoneHasNotch.hasNotch) ? 30.px : 20.px),
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
                          firstText: Languages.of(context)!.welcomeBack,
                          secondText: Languages.of(context)!.pleaseSignInToContinue,
                        ),
                        SizedBox(height: 30.px),
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              utils.hideKeyboard();
                              Get.toNamed(Routes.FORGOT_PASSWORD_SCREEN);
                            },
                            child: AppText(Languages.of(context)!.forgotPassword),
                          ),
                        ),
                        SizedBox(height: 30.px),
                        CommonButton(
                          onTap: () {
                            controller.isValidationOfLogin();
                          },
                          verticalPadding: 13.px,
                          title: Languages.of(context)!.signIn,
                        ),
                        SizedBox(height: 30.px),
                      ],
                    ).paddingSymmetric(horizontal: commonLeadingWith),
                  ],
                );
              }),
            ),
          );
        });
      },
    );
  }
}

class TwoLineTextView extends StatelessWidget {
  const TwoLineTextView({super.key, this.firstText, this.secondText, this.crossAxisAlignment});

  final String? firstText;
  final String? secondText;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      children: [
        AppText(firstText ?? '', fontFamily: FontFamily.helveticaBold, fontSize: 24.px),
        AppText(secondText ?? '', fontSize: 16.px, color: AppColors().grayMix),
      ],
    );
  }
}
