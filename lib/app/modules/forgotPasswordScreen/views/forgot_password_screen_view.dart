import 'package:chatsy/app/common_widget/common_button.dart';
import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/extension.dart';

import '../../../Localization/local_language.dart';
import '../../../common_widget/comman_text_feild_bottom_sheet.dart';
import '../../../helper/image_path.dart';
import '../../Login/views/login_view.dart';
import '../controllers/forgot_password_screen_controller.dart';

class ForgotPasswordScreenView extends GetView<ForgotPasswordScreenController> {
  const ForgotPasswordScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgotPasswordScreenController>(
      init: ForgotPasswordScreenController(),
      builder: (controller) {
        return CommonScreen(
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
                    firstText: Languages.of(context)!.forgotPassword,
                    secondText: Languages.of(context)!.noWorriesHelpYou,
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
                    textInputAction: TextInputAction.done,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      FilteringTextInputFormatter.deny(RegExp('A-Z')),
                    ],
                  ),
                  SizedBox(height: 30.px),
                  CommonButton(
                    onTap: () {
                      utils.hideKeyboard();
                      controller.forgotValidation();
                    },
                    title: Languages.of(context)!.send,
                  ),
                ],
              ).paddingSymmetric(horizontal: commonLeadingWith),
              SizedBox(height: 30.px),
            ],
          ),
        );
      },
    );
  }
}
