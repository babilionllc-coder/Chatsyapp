import 'dart:io';

import 'package:chatsy/app/api_repository/api_function.dart';
import 'package:chatsy/app/common_widget/common_button.dart';
import 'package:chatsy/app/common_widget/common_show_model_bottom_sheet.dart';
import 'package:chatsy/app/modules/AssistantsPage/controllers/assistants_page_controller.dart';
import 'package:chatsy/app/modules/imageScan/views/image_scan_view.dart';
import 'package:chatsy/service/core/exception.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../Localization/local_language.dart';
import '../../../common_widget/error_and_update_dialog.dart';
import '../../../helper/Global.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/font_family.dart';
import '../../../routes/app_pages.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../chat_gpt/controllers/chat_gpt_controller.dart';
import '../../newChat/controllers/new_chat_controller.dart';
import '../models/whats_new_model.dart';

class WhatsNewController extends GetxController {
  List<WhatsNewData> newList = [];

  bool isBack = true;

  whatsNewAPI() async {
    String uid = getStorageData.readString(getStorageData.userId) ?? "";
    String token = getStorageData.readString(getStorageData.token) ?? "";
    FormData formData = FormData.fromMap({"user_id": uid});
    final data = await APIFunction().apiCall(
      apiName: Constants.getWhatsNewList,
      params: formData,
      token: token,
    );
    WhatsNewModel model = WhatsNewModel.fromJson(data);
    if (model.responseCode == 1) {
      newList = model.data ?? [];
      for (var item in newList) {
        item.videoController = VideoPlayerController.networkUrl(
            Uri.parse(item.media!),
          )
          ..initialize().then((_) {
            item.videoController!.addListener(() {
              if (item.videoController!.value.position >=
                  item.videoController!.value.duration) {
                item.videoController!.seekTo(Duration.zero);
                item.videoController!.play();
              }
            });
            update();
          });
      }
      showToView();
    } else if (model.responseCode == 0) {
      errorDialog(model.responseMsg);
    } else if (model.responseCode == 26) {
      updateDialog(model.responseMsg);
    } else if (model.responseCode == 5) {
      utils.showToast(message: model.responseMsg!);
    } else {
      utils.showToast(message: model.responseMsg!);
    }
  }

  showToView() async {
    await CommonShowModelBottomSheet(
      child: GetBuilder<WhatsNewController>(
        init: WhatsNewController(),
        builder: (controller) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 10.px),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.close, color: Colors.transparent),
                    ),
                    Expanded(
                      child: Center(
                        child: AppText(
                          Languages.of(
                            Get.context!,
                          )!.whatNew.replaceAll("?", ""),
                          maxLines: 1,
                          fontSize: 16.px,
                          fontFamily: FontFamily.helveticaBold,
                          color: AppColors().darkAndWhite,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.close, color: AppColors().darkAndWhite),
                    ),
                  ],
                ),
                ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: controller.newList.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 20.px);
                  },
                  itemBuilder: (_, index) {
                    WhatsNewData data = controller.newList[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height:
                              MediaQuery.of(Get.context!).size.height *
                              0.7 *
                              0.92,
                          width: double.infinity,
                          // padding: EdgeInsets.only(top: 20.px, left: 60.px, right: 60.px),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30.px),
                              topLeft: Radius.circular(30.px),
                            ),
                            gradient: const LinearGradient(
                              begin: Alignment(-0.00, 1.00),
                              end: Alignment(0, -1),
                              colors: [Color(0x193CDAD3), Color(0x993CDAD3)],
                            ),
                          ),
                          child:
                              (data.videoController != null &&
                                      data.videoController!.value.isInitialized)
                                  ? Container(
                                    height:
                                        MediaQuery.of(
                                          Get.context!,
                                        ).size.height *
                                        0.69 *
                                        0.92,
                                    width: double.infinity,
                                    padding: EdgeInsets.only(
                                      top: 50.px,
                                      left: 50.px,
                                      right: 50.px,
                                    ),
                                    child: VisibilityDetector(
                                      key: ObjectKey(
                                        data.videoController ?? "0",
                                      ),
                                      onVisibilityChanged: (visibilityInfo) {
                                        if (visibilityInfo.visibleFraction >
                                            0.5) {
                                          data.videoController?.play();
                                        } else if (visibilityInfo
                                                .visibleFraction <
                                            0.5) {
                                          data.videoController?.pause();
                                        }
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.px),
                                            topRight: Radius.circular(20.px),
                                          ),
                                          border: const Border(
                                            top: BorderSide(
                                              color: AppColors.primary,
                                              width: 8,
                                              strokeAlign:
                                                  BorderSide.strokeAlignOutside,
                                            ),
                                            left: BorderSide(
                                              color: AppColors.primary,
                                              width: 8,
                                              strokeAlign:
                                                  BorderSide.strokeAlignOutside,
                                            ),
                                            right: BorderSide(
                                              color: AppColors.primary,
                                              width: 8,
                                              strokeAlign:
                                                  BorderSide.strokeAlignOutside,
                                            ),
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20.px),
                                            topRight: Radius.circular(20.px),
                                          ),
                                          child: VideoPlayer(
                                            data.videoController!,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  : Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors().darkAndWhite,
                                    ),
                                  ),
                        ),
                        SizedBox(height: 10.px),
                        Center(
                          child: AppText(
                            data.title ?? "",
                            fontSize: 16.px,
                            fontFamily: FontFamily.helveticaBold,
                          ),
                        ),
                        AppText(data.description ?? "", fontSize: 14.px),
                        SizedBox(height: 20.px),
                        CommonButton(
                          onTap: () async {
                            isBack = false;
                            printAction("data.whatsNewId ${data.whatsNewId}");
                            Get.back();
                            Get.back(
                              result:
                                  data.whatsNewId == "5"
                                      ? Constants.youtube
                                      : null,
                            );
                            if (data.whatsNewId == "3") {
                              File? imagePath = await imagePickerBottomSheet(
                                isSub: true,
                              );

                              ///TODO::
                              if (imagePath?.path != null) {
                                if (Get.put(
                                  BottomNavigationController(),
                                ).toolsListModel.isNotEmpty) {
                                  ImageScanView.toNamed(
                                    imagePath: imagePath?.path,
                                    model: Get.put(
                                      BottomNavigationController(),
                                    ).toolsListModel.firstWhere(
                                      (element) =>
                                          element.model == "image_scan",
                                    ),
                                  );
                                  // Get.toNamed(
                                  //   Routes.IMAGE_SCAN,
                                  //   arguments: {
                                  //     "imagePath": imagePath?.path,
                                  //     "toolModel": Get.put(BottomNavigationController())
                                  //         .toolsListModel
                                  //         .firstWhere((element) => element.model == "image_scan"),
                                  //   },
                                  // );
                                }
                              }
                            } else if (data.whatsNewId == "4") {
                              Get.delete<NewChatController>();

                              Get.toNamed(
                                Routes.NEW_CHAT,
                                arguments: {
                                  HttpUtil.isAssistant: false,
                                  HttpUtil.isTextScan: true,
                                  "toolModel": Get.put(
                                    BottomNavigationController(),
                                  ).toolsListModel.firstWhere(
                                    (element) => element.model == "text_scan",
                                  ),
                                },
                              );
                            } else if (data.whatsNewId == "2") {
                              if (!Get.find<AssistantsPageController>()
                                  .apiState
                                  .isSuccess) {
                                Get.find<AssistantsPageController>()
                                    .getAssistantData(refresh: true);
                              }
                              Get.put(BottomNavigationController())
                                  .selectedIndex
                                  .value = 2;
                              Get.put(
                                BottomNavigationController(),
                              ).bottomBarItem.forEach((element) {
                                element.isCheck?.value = false;
                              });
                              Get.put(BottomNavigationController())
                                  .bottomBarItem[Get.put(
                                    BottomNavigationController(),
                                  ).selectedIndex.value]
                                  .isCheck
                                  ?.value = true;

                              printAction(
                                "Get.put(BottomNavigationController()).selectedIndex.value ${Get.put(BottomNavigationController()).selectedIndex.value}",
                              );
                            } else if (data.whatsNewId == "1") {
                              Future.delayed(const Duration(seconds: 2), () {
                                if (Global.isSubscription.value != "1") {
                                  Get.put(
                                    ChatGptController(),
                                  ).creditBottomSheet();
                                } else {
                                  Get.delete<NewChatController>();

                                  Get.toNamed(
                                    Routes.NEW_CHAT,
                                    arguments: {
                                      HttpUtil.isAssistant: false,
                                      HttpUtil.isModel: Get.put(
                                        BottomNavigationController(),
                                      ).selectAiModelList.firstWhereOrNull(
                                        (element) =>
                                            element.modelType == "chat_gpt_4o",
                                      ),
                                    },
                                  );
                                }
                              });
                            } else if (data.whatsNewId == "5") {}
                          },
                          title: Languages.of(Get.context!)!.letTry,
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
    if (isBack) {
      Get.back();
    }
  }

  @override
  Future<void> onInit() async {
    whatsNewAPI();

    super.onInit();
  }

  @override
  void onClose() {
    for (var item in newList) {
      item.videoController?.dispose();
    }
    super.onClose();
  }
}
