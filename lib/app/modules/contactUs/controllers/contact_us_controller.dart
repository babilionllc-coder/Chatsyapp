import 'package:chatsy/app/Localization/local_language.dart';
import 'package:chatsy/app/api_repository/api_function.dart';
import 'package:chatsy/app/modules/contactUs/controllers/contactUs_Model.dart';

import '../../../common_widget/error_and_update_dialog.dart';
import '../../../helper/all_imports.dart';
import '../../splash/controllers/login_model.dart';

class ContactUsController extends GetxController {
  //TODO: Implement ContactUsController

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();
  LoginData? loginData;

  @override
  void onInit() {
    super.onInit();
    getLoginData();
  }

  getLoginData() async {
    if (getStorageData.containKey(getStorageData.loginData)) {
      loginData = LoginData.fromJson(getStorageData.readObject(getStorageData.loginData));
    }
    update();
  }

  clearTextController() {
    name.clear();
    email.clear();
    subject.clear();
    message.clear();
  }

  contactUsAPI() async {
    String token = getStorageData.readString(getStorageData.token) ?? "";
    FormData formData = FormData.fromMap({
      "name": name.text,
      "email": email.text,
      "subject": subject.text,
      "message": message.text,
    });

    final data = await APIFunction().apiCall(
      apiName: Constants.contactUs,
      params: formData,
      token: token,
    );

    ContactUsModel model = ContactUsModel.fromJson(data);

    if (model.responseCode == 1) {
      clearTextController();
      Get.back();
      utils.showToast(message: model.responseMsg!);
      // utils.showToasts(context: Get.context!, message: model.responseMsg!, statusCode: model.responseCode!);
    } else if (model.responseCode == 0) {
      errorDialog(model.responseMsg);
    } else if (model.responseCode == 26) {
      updateDialog(model.responseMsg);
    } else {
      utils.showToast(message: model.responseMsg!);
    }
  }

  isValidation() {
    if (utils.isValidationEmpty(name.text.trim())) {
      utils.showToast(message: Languages.of(Get.context!)!.errorMessageValidYourName);
    } else if (utils.isValidationEmpty(email.text.trim())) {
      utils.showToast(message: Languages.of(Get.context!)!.errorMessageEmail);
    } else if (!utils.emailValidator(email.text.trim())) {
      utils.showToast(message: Languages.of(Get.context!)!.errorMessageValidEmail);
    } else if (utils.isValidationEmpty(subject.text.trim())) {
      utils.showToast(message: Languages.of(Get.context!)!.errorMessageSubject);
    } else if (utils.isValidationEmpty(message.text.trim())) {
      utils.showToast(message: Languages.of(Get.context!)!.errorMessageMessage);
    } else {
      contactUsAPI();
    }
  }
}
