import '../../../Localization/local_language.dart';
import '../../../api_repository/api_function.dart';
import '../../../common_widget/common_button.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/font_family.dart';
import '../models/common_response_model.dart';

class ReasonController extends GetxController {
  final count = 0.obs;
  TextEditingController otherReasonController = TextEditingController();
  List deleteReasonList = [
    Languages.of(Get.context!)!.itSpam,
    Languages.of(Get.context!)!.falseInformation,
    Languages.of(Get.context!)!.privacyConcerns,
    Languages.of(Get.context!)!.violenceThreats,
    Languages.of(Get.context!)!.other,
  ];

  bool isValidation() {
    if (count.value == (deleteReasonList.length - 1) &&
        utils.isValidationEmpty(otherReasonController.text)) {
      utils.showToast(message: Languages.of(Get.context!)!.pleaseEnterReason);

      return false;
    } else {
      return true;
    }
  }

  Future<bool> deleteShowDialog() async {
    bool isDelete = false;
    await showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          iconPadding: EdgeInsets.zero,
          buttonPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          content: Container(
            decoration: BoxDecoration(
              color: AppColors().whiteAndDark,
              borderRadius: BorderRadius.circular(20.px),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  Languages.of(context)!.deleteAccount,
                  fontSize: 24.px,
                  fontFamily: FontFamily.helveticaBold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.px),
                AppText(
                  Languages.of(context)!.areYouSureYouWantTo,
                  fontSize: 14.px,
                  fontFamily: FontFamily.helveticaRegular,
                  textAlign: TextAlign.center,
                ).paddingSymmetric(horizontal: 8.w),
                AppText(
                  Languages.of(context)!.youWilLoseAllYourData,
                  fontSize: 14.px,
                  fontFamily: FontFamily.helveticaRegular,
                  textAlign: TextAlign.center,
                ).paddingSymmetric(horizontal: 8.w),
                SizedBox(height: 30.px),
                Row(
                  children: [
                    Expanded(
                      child: CommonButton(
                        onTap: () {
                          Get.back();
                        },
                        borderRadius: 10.px,
                        title: Languages.of(context)!.cancel,
                        buttonColor: AppColors().grayMix2,
                        textColor: AppColors.black,
                      ),
                    ),
                    SizedBox(width: 10.px),
                    Expanded(
                      child: CommonButton(
                        onTap: () {
                          isDelete = true;
                          Get.back();
                        },
                        title: Languages.of(context)!.deleteAccount.capitalize,
                        textColor: AppColors.white,
                        borderRadius: 10.px,
                      ),
                    ),
                  ],
                ),
              ],
            ).paddingAll(16.px),
          ),
        );
      },
    );
    return isDelete;
  }

  deleteAccountAPI({required String reason}) async {
    String userId = getStorageData.readString(getStorageData.userId) ?? "";
    FormData formData = FormData.fromMap({
      "user_id": userId,
      (isDeleteAccount) ? "delete_reason" : "reason": reason,
      if (!utils.isValidationEmpty(answer)) "answer": answer,
      // "is_test": kDebugMode,
    });
    final data = await APIFunction().apiCall(
      apiName: isDeleteAccount ? Constants.deleteAccount : Constants.report,
      params: formData,
      token: getStorageData.readString(getStorageData.token),
    );
    CommonResponseModel model = CommonResponseModel.fromJson(data);
    if (model.responseCode == 1) {
      if (isDeleteAccount) {
        getStorageData.removeLoginData();
      } else {
        Get.back();
      }
      utils.showToast(message: model.responseMsg ?? "");
    } else {
      utils.showToast(message: model.responseMsg ?? "");
    }
  }

  bool isDeleteAccount = true;

  String answer = "";

  @override
  void onInit() {
    if (Get.arguments != null) {
      isDeleteAccount = false;
      answer = Get.arguments['reason'];
      if (!isDeleteAccount) {
        deleteReasonList = [
          Languages.of(Get.context!)!.itSpam,
          Languages.of(Get.context!)!.falseInformation,
          Languages.of(Get.context!)!.hateSpeechSymbols,
          Languages.of(Get.context!)!.bullyingOrHarassment,
          Languages.of(Get.context!)!.scamOrFraud,
          Languages.of(Get.context!)!.other,
        ];
      }
    }
    super.onInit();
  }

  void increment() => count.value++;
}
