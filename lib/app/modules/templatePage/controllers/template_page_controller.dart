import 'package:get/get.dart';

import '../../../helper/all_imports.dart';
import '../../../helper/get_storage_data.dart';
import '../../home/controllers/all_prompt_model.dart';

class TemplatePageController extends GetxController {
  @override
  void onInit() {
    if (Get.arguments != null) {
      var p = GetStorageData().readObject(GetStorageData().prompts);
      prompts = Prompts.fromJson(p);
    }

    for (var item in prompts.formFields ?? []) {
      item.value = "";
    }

    for (var formFields in prompts.formFields ?? []) {
      if (formFields.fieldType == "dropdown") {
        formFields.value = formFields.dropdownValue?.first.name ?? "";
      }
    }
    super.onInit();
  }

  String imagePathData = "";

  Prompts prompts = Prompts();
}
