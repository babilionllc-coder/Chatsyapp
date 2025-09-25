import 'package:chatsy/app/helper/all_imports.dart';
import 'package:flutter/foundation.dart';

import '../../../Localization/local_language.dart';
import '../../../api_repository/api_function.dart';
import '../../../api_repository/loading.dart';
import '../../../routes/app_pages.dart';
import '../../signUpScreen/models/send_otp_model.dart';

class ForgotPasswordScreenController extends GetxController {
  TextEditingController email = TextEditingController(
    text: (kDebugMode) ? "montu.kmphitech@gmail.com" : null,
  );

  void forgotValidation() async {
    if (utils.isValidationEmpty(email.text.trim())) {
      utils.showToast(message: Languages.of(Get.context!)!.errorMessageEmail);
    } else if (!utils.emailValidator(email.text.trim())) {
      utils.showToast(message: Languages.of(Get.context!)!.errorMessageValidEmail);
    } else {
      forgotPasswordAPI();
    }
  }

  forgotPasswordAPI() async {
    FormData formData = FormData.fromMap({"email": email.text.trim()});
    final data = await APIFunction().apiCall(
      apiName: Constants.forgotPassword,
      params: formData,
      isLoading: true,
    );
    Loading.dismiss();

    SendOtpModel model = SendOtpModel.fromJson(data);
    if (model.responseCode == 1) {
      Get.toNamed(Routes.OTP_SCREEN, arguments: {HttpUtil.email: email.text.trim()});
    } else {
      utils.showToast(message: model.responseMsg ?? "");
    }
  }
}
