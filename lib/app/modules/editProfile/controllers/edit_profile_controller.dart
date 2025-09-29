import 'dart:developer';
import 'dart:io';

import 'package:chatsy/app/common_widget/common_button.dart';
import 'package:chatsy/app/common_widget/common_show_model_bottom_sheet.dart';
import 'package:chatsy/app/common_widget/rx_common_model.dart';
import 'package:chatsy/app/helper/font_family.dart';
import 'package:chatsy/app/helper/image_path.dart';
import 'package:chatsy/app/modules/splash/controllers/login_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../Localization/local_language.dart';
import '../../../api_repository/api_function.dart';
import '../../../helper/all_imports.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../chat_gpt/views/chat_gpt_view.dart';

class EditProfileController extends GetxController {
  TextEditingController userNameController = TextEditingController();

  String? imagePath;
  RxInt currentIndex = 3.obs;
  RxList<RxCommonModel> userList =
      <RxCommonModel>[
        RxCommonModel(image: ImagePath.user1),
        RxCommonModel(image: ImagePath.user2),
        RxCommonModel(image: ImagePath.user3),
        RxCommonModel(image: ImagePath.user4),
        RxCommonModel(image: ImagePath.user5),
        RxCommonModel(image: ImagePath.user6),
        RxCommonModel(image: ImagePath.user7),
        RxCommonModel(image: ImagePath.user8),
        RxCommonModel(image: ImagePath.user9),
        RxCommonModel(image: ImagePath.user10),
        RxCommonModel(image: ImagePath.user11),
        RxCommonModel(image: ImagePath.user12),
        RxCommonModel(image: ImagePath.user13),
        RxCommonModel(image: ImagePath.user14),
        RxCommonModel(image: ImagePath.user15),
        RxCommonModel(image: ImagePath.darkUserId),
      ].obs;

  LoginData loginData = LoginData();
  String userIdentification = "";

  String insertFirstFiveAfter(String fullName, String subString) {
    if (fullName.isEmpty) {
      return "";
    }

    // Check if the length is less than 5 characters
    if (fullName.length < 5) {
      return "$fullName${subString}a";
    }
    String firstFive = fullName.substring(0, 5);
    String remaining = fullName.substring(5);

    return "$firstFive${subString}a$remaining";
  }

  avatarSelected() {
    CommonShowModelBottomSheet(
      child: Column(
        children: [
          Obx(
            () => GridView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: userList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 11.px,
                crossAxisSpacing: 8.px,
              ),
              itemBuilder: (context, index) {
                RxCommonModel obj = userList[index];
                return GestureDetector(
                  onTap: () async {
                    if (obj.image != userList.last.image) {
                      currentIndex.value = index;
                      if (imagePath != null) {
                        imagePath = null;
                      }
                      userList.refresh();
                    } else {
                      File? file = await imagePickerBottomSheet(isSub: false);
                      if (file != null) {
                        imagePath = file.path;

                        currentIndex.value = index;

                        userList.refresh();
                      }
                    }
                    Get.back();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border:
                          index == currentIndex.value
                              ? Border.all(color: AppColors.primary, width: 2.px)
                              : Border.all(
                                color:
                                    index == (userList.length - 1)
                                        ? const Color(0xFFEEEEEE)
                                        : Colors.transparent,
                                width: 2.px,
                              ),
                    ),
                    child:
                        (imagePath != null && index == (userList.length - 1))
                            ? ClipOval(child: Image.file(File(imagePath!), fit: BoxFit.cover))
                            : (!utils.isValidationEmpty(
                                  getStorageData.readString(getStorageData.profile),
                                ) &&
                                getStorageData
                                        .readString(getStorageData.profile)
                                        .toString()
                                        .compareTo("https//aichatsy.com") ==
                                    1 &&
                                index == (userList.length - 1))
                            ? ClipOval(
                              child: CachedNetworkImage(
                                imageUrl:
                                    getStorageData.readString(getStorageData.profile).toString(),
                                fit: BoxFit.cover,

                                // placeholder: (context, url) => const Center(
                                //   child: CircularProgressIndicator(
                                //     color: AppColors.primary,
                                //   ),
                                // ),
                                // errorWidget: (context, url, uri) => const Center(
                                //   child: Icon(
                                //     Icons.person,
                                //     color: AppColors.primary,
                                //   ),
                                // ),
                                progressIndicatorBuilder:
                                    (context, url, progress) => progressIndicatorView(),
                                errorWidget:
                                    (context, url, uri) => errorWidgetView().paddingAll(8.px),
                              ),
                            )
                            : Padding(
                              padding: EdgeInsets.all(index == (userList.length - 1) ? 20.px : 0),
                              child: Image.asset(
                                obj.image,
                                fit: BoxFit.cover,
                                color:
                                    index == (userList.length - 1)
                                        ? AppColors().darkAndWhite
                                        : null,
                              ),
                            ),
                  ),
                );
              },
            ),
          ).marginOnly(bottom: 32.px),
          // CommonButton(
          //   onTap: () {},
          //   title: Languages.of(Get.context!)!.continues,
          // )
        ],
      ).paddingAll(20.px),
    );
  }

  logOutAPI() async {
    FormData formData = FormData.fromMap({"user_id": loginData.userId});

    final data = await APIFunction().apiCall(
      isLoading: true,
      apiName: Constants.logOut,
      params: formData,
    );

    LoginModel model = LoginModel.fromJson(data);
    getStorageData.removeLoginData();

    if (model.responseCode == 1) {
      utils.showToast(message: model.responseMsg!);

      // Get.offAll(() => LoginSignupView(), binding: LoginSignupBinding());
    } else if (model.responseCode == 2) {
      utils.showToast(message: model.responseMsg!);
    } else if (model.responseCode == 0) {
      utils.showToast(message: model.responseMsg!);
    } else {
      utils.showToast(message: model.responseMsg!);
    }
  }

  logOutShowDialog() {
    showDialog(
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
                  Languages.of(context)!.areYouSureTo,
                  fontSize: 24.px,
                  fontFamily: FontFamily.helveticaBold,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.px),
                AppText(
                  Languages.of(context)!.youWillNotLooseYourDataIf,
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
                          logOutAPI();
                        },
                        title: Languages.of(context)!.logOut.capitalize,
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
  }

  @override
  void onInit() {
    log("-=-=-=-=- login Data ${getStorageData.readObject(getStorageData.loginData)}");
    loginData = LoginData.fromJson(getStorageData.readObject(getStorageData.loginData));
    userNameController.text =
        utils.isValidationEmpty(getStorageData.readString(getStorageData.userName))
            ? ""
            : getStorageData.readString(getStorageData.userName) ?? "";
    userIdentification = insertFirstFiveAfter(
      (!utils.isValidationEmpty(loginData.deviceId.toString()))
          ? loginData.deviceId.toString()
          : getStorageData.readString(getStorageData.deviceId) ?? "",
      loginData.userId.toString(),
    );
    if (!utils.isValidationEmpty(getStorageData.readString(getStorageData.profile))) {
      for (var item in userList) {
        if (item.image == getStorageData.readString(getStorageData.profile)) {
          currentIndex.value = userList.indexOf(item);
          break;
        } else {
          if (!utils.isValidationEmpty(getStorageData.readString(getStorageData.profile)) &&
              getStorageData
                      .readString(getStorageData.profile)
                      .toString()
                      .compareTo("https//aichatsy.com") ==
                  1) {
            currentIndex.value = (userList.length - 1);
            userList.last.title = getStorageData.readString(getStorageData.profile).toString();
            break;
          }
        }
      }
    } else {
      currentIndex.value = 3;
    }

    super.onInit();
  }

  isEditProfileValidation() {
    if (Utils().isValidationEmpty(userNameController.text)) {
      Utils().showToast(message: Languages.of(Get.context!)!.pleaseEnterName);
      return false;
    }
    return true;
  }
}
