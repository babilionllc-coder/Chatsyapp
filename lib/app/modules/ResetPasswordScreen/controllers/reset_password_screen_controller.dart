import 'package:chatsy/app/modules/Login/controllers/login_controller.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Localization/local_language.dart';
import '../../../api_repository/api_function.dart';
import '../../../api_repository/loading.dart';
import '../../../common_widget/common_button.dart';
import '../../../common_widget/common_show_model_bottom_sheet.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/image_path.dart';
import '../../Login/views/login_view.dart';
import '../../signUpScreen/models/send_otp_model.dart';

class ResetPasswordScreenController extends GetxController {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  RxBool isShowPassword = false.obs;
  RxBool isShowConfirmPassword = false.obs;

  void isValidationResentPassword() {
    if (utils.isValidationEmpty(password.text.trim())) {
      utils.showToast(message: Languages.of(Get.context!)!.pleaseEnterNewPassword);
    } else if (!utils.passwordValidator(password.text.trim())) {
      utils.showToast(
        message: Languages.of(
          Get.context!,
        )!.passwordMustBeMoreThan8Characters(title: Languages.of(Get.context!)!.newName),
      );
    } else if (utils.isValidationEmpty(confirmPassword.text.trim())) {
      utils.showToast(message: Languages.of(Get.context!)!.pleaseEnterNewConfirmPassword);
    } else if (password.text.trim() != confirmPassword.text.trim()) {
      utils.showToast(message: Languages.of(Get.context!)!.newPasswordAndNewConfirmPassword);
    } else {
      updatePasswordAPI();
    }
  }

  void successBottomSheet() {
    CommonShowModelBottomSheet(
      enableDrag: false,
      isDismissible: false,
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Column(
          children: [
            SizedBox(height: 30.px),
            SvgPicture.asset(ImagePath.icDone, height: 70.px),
            SizedBox(height: 30.px),
            TwoLineTextView(
              crossAxisAlignment: CrossAxisAlignment.center,
              firstText: Languages.of(Get.context!)!.successful,
              secondText: Languages.of(Get.context!)!.yourPasswordHasBeen,
            ),
            SizedBox(height: 30.px),
            CommonButton(
              onTap: () {
                Get.back();
                Get.back();
                Get.back();
                Get.back();
                if (Get.isRegistered<LoginController>()) {
                  Get.put(LoginController()).email.clear();
                  Get.put(LoginController()).password.clear();
                  Get.put(LoginController()).isShowPassword.value = false;
                }
              },
              title: Languages.of(Get.context!)!.ok,
            ),
          ],
        ).paddingSymmetric(horizontal: commonLeadingWith),
      ),
    );
  }

  updatePasswordAPI() async {
    FormData formData = FormData.fromMap({
      HttpUtil.email: Get.arguments[HttpUtil.email],
      HttpUtil.newPassword: utils.generateMd5(password.text.trim()),
    });
    final data = await APIFunction().apiCall(
      apiName: Constants.updatePassword,
      params: formData,
      isLoading: true,
    );
    Loading.dismiss();

    SendOtpModel model = SendOtpModel.fromJson(data);
    if (model.responseCode == 1) {
      successBottomSheet();
    } else {
      utils.showToast(message: model.responseMsg ?? "");
    }
  }
}
