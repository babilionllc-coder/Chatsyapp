import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/extension.dart';
import 'package:pinput/pinput.dart';

import '../../../Localization/local_language.dart';
import '../../../common_widget/common_button.dart';
import '../../../common_widget/iphone_has_notch.dart';
import '../../../helper/font_family.dart';
import '../../Login/views/login_view.dart';
import '../controllers/otp_screen_controller.dart';

class OTPScreenView extends GetView<OTPScreenController> {
  const OTPScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OTPScreenController>(
      init: OTPScreenController(),
      builder: (controller) {
        return CommonScreen(
          bottomNavigationBar: AppRichText(
            firstText: Languages.of(context)!.didReceiveTheCode,
            secondText: " ${Languages.of(context)!.resend}",
            firstTextColor: AppColors().grayColorMix,
            secondTextColor: AppColors().darkAndWhite,
            onTap: () {
              if (controller.isSignUp ?? false) {
                controller.sendOtp();
              } else {
                controller.forgotPasswordAPI();
              }
            },
          ).paddingOnly(bottom: (IphoneHasNotch.hasNotch) ? 30.px : 20.px),
          body: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            children: [
              SizedBox(height: 30.px),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TwoLineTextView(
                    firstText: Languages.of(context)!.authentication,
                    secondText: Languages.of(context)!.enterTheVerificationCodeSent,
                  ),
                  SizedBox(height: 30.px),
                  Pinput(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    controller: controller.otpController,
                    length: 4,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]"))],
                    cursor: Container(height: 30.px, width: 2, color: AppColors.primary),
                    scrollPadding: EdgeInsets.zero,
                    defaultPinTheme: PinTheme(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 60.px,
                      width: 75.px,
                      textStyle: TextStyle(
                        fontSize: 18.px,
                        fontFamily: FontFamily.helveticaBold,
                        color: AppColors().darkAndWhite,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors().darkWhiteAndBlack2.changeOpacity(0.05),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      height: 60.px,
                      width: 75.px,
                      textStyle: TextStyle(
                        fontSize: 18.px,
                        fontFamily: FontFamily.helveticaBold,
                        color: AppColors().darkAndWhite,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors().darkWhiteAndBlack2.changeOpacity(0.05),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  SizedBox(height: 70.px),
                  CommonButton(
                    title: Languages.of(context)!.verify,
                    onTap: () {
                      utils.hideKeyboard();
                      controller.isOTPValidation();
                    },
                  ),
                  SizedBox(height: 70.px),
                ],
              ).paddingSymmetric(horizontal: commonLeadingWith),
            ],
          ),
        );
      },
    );
  }
}
