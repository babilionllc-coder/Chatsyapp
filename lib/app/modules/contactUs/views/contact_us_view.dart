import 'package:chatsy/app/Localization/local_language.dart';
import 'package:chatsy/app/common_widget/comman_text_field.dart';
import 'package:chatsy/app/common_widget/common_button.dart';
import 'package:chatsy/app/common_widget/common_screen.dart';

import '../../../helper/all_imports.dart';
import '../../../helper/font_family.dart';
import '../controllers/contact_us_controller.dart';

class ContactUsView extends GetView<ContactUsController> {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactUsController>(
      init: ContactUsController(),
      builder: (controller) {
        return CommonScreen(
          title: Languages.of(context)!.contactUs,
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                AppText(
                  Languages.of(context)!.name,
                  fontFamily: FontFamily.helveticaBold,
                  fontSize: 16.px,
                ),
                SizedBox(height: 8.px),
                CommonTextField(
                  padding: EdgeInsets.symmetric(vertical: 12.px, horizontal: 10.px),
                  borderRadius: BorderRadius.circular(15.px),
                  paddingShow: false,
                  isBorder: true,
                  hintText: Languages.of(context)!.enterName,
                  color: AppColors().whiteAndDark,
                  controller: controller.name,
                  // hintText: Languages.of(context)!.name,
                  inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
                ),
                SizedBox(height: 15.px),
                AppText(
                  Languages.of(context)!.email,
                  fontFamily: FontFamily.helveticaBold,
                  fontSize: 16.px,
                ),
                SizedBox(height: 8.px),
                CommonTextField(
                  color: AppColors().whiteAndDark,
                  paddingShow: false,
                  isBorder: true,
                  hintText: Languages.of(context)!.enterEmail,

                  padding: EdgeInsets.symmetric(vertical: 12.px, horizontal: 10.px),
                  borderRadius: BorderRadius.circular(15.px),
                  controller: controller.email,
                  keyboardType: TextInputType.emailAddress,
                  // hintText: Languages.of(context)!.name,
                  inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
                ),
                SizedBox(height: 15.px),
                AppText(
                  Languages.of(context)!.subject,
                  fontFamily: FontFamily.helveticaBold,
                  fontSize: 16.px,
                ),
                SizedBox(height: 8.px),
                CommonTextField(
                  color: AppColors().whiteAndDark,
                  paddingShow: false,
                  isBorder: true,

                  hintText: Languages.of(context)!.enterSubject,
                  controller: controller.subject,
                  padding: EdgeInsets.symmetric(vertical: 12.px, horizontal: 10.px),
                  borderRadius: BorderRadius.circular(15.px),
                  // hintText: Languages.of(context)!.name,
                  inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
                ),
                SizedBox(height: 15.px),
                AppText(
                  Languages.of(context)!.message,
                  fontFamily: FontFamily.helveticaBold,
                  fontSize: 16.px,
                ),
                SizedBox(height: 8.px),
                CommonTextField(
                  paddingShow: false,
                  isBorder: true,
                  color: AppColors().whiteAndDark,
                  padding: EdgeInsets.symmetric(vertical: 12.px, horizontal: 10.px),
                  borderRadius: BorderRadius.circular(15.px),
                  controller: controller.message,
                  keyboardType: TextInputType.multiline,
                  hintText: Languages.of(context)!.writeHere,
                  textInputAction: TextInputAction.newline,
                  maxLine: 4,
                  minLine: 4,
                ),
                SizedBox(height: 30.px),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.px),
                  child: CommonButton(
                    borderRadius: 25.px,
                    onTap: () {
                      controller.isValidation();
                    },
                    title: Languages.of(context)!.submit,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
