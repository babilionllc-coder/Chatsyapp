import 'dart:io';

import 'package:chatsy/app/modules/chatHistory/controllers/chat_history_controller.dart';
import 'package:chatsy/app/modules/imageScan/views/image_scan_view.dart';
import 'package:chatsy/extension.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Localization/local_language.dart';
import '../../../common_widget/common_container.dart';
import '../../../common_widget/common_show_model_bottom_sheet.dart';
import '../../../common_widget/rx_common_model.dart';
import '../../../helper/all_imports.dart';
import '../../../routes/app_pages.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../chat_gpt/controllers/chat_gpt_controller.dart';

Future<Map> addOtherPronts() async {
  Map mapData = {};

  await CommonShowModelBottomSheet(
    // isScrollControlled: true,
    // backgroundColor: Colors.transparent,
    // context: Get.context!,
    child: ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount:
          Get.put(BottomNavigationController()).addOtherPromptsList.length,
      separatorBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(height: 5.px),
            Container(
              height: 1,
              color: AppColors().darkAndWhite.changeOpacity(0.04),
            ),
            SizedBox(height: 5.px),
          ],
        );
      },
      itemBuilder: (context, index) {
        RxCommonModel data =
            Get.put(BottomNavigationController()).addOtherPromptsList[index];
        return GestureDetector(
          onTap: () async {
            if (data.title == Languages.of(context)!.imageScan) {
              Get.back();
              File? imagePath = await imagePickerBottomSheet(isSub: true);

              if (imagePath?.path != null) {
                if (Get.put(
                  BottomNavigationController(),
                ).toolsListModel.isNotEmpty) {
                  ImageScanView.toNamed(
                    model: Get.put(BottomNavigationController()).toolsListModel
                        .firstWhere((element) => element.model == "image_scan"),
                    imagePath: imagePath?.path,
                  );
                  // Get.toNamed(
                  //   Routes.IMAGE_SCAN,
                  //   arguments: {
                  //     "imagePath": imagePath?.path,
                  //     "toolModel": Get.put(
                  //       BottomNavigationController(),
                  //     ).toolsListModel.firstWhere(
                  //       (element) => element.model == "image_scan",
                  //     ),
                  //   },
                  // );
                }
              }
            } else if (data.title == Languages.of(context)!.uploadFile) {
              Get.back();
              if (Get.put(
                BottomNavigationController(),
              ).toolsListModel.isNotEmpty) {
                Get.put(ChatGptController()).uploadAndAskCommon(
                  Get.put(
                    BottomNavigationController(),
                  ).toolsListModel.firstWhere(
                    (element) => element.model == "summarize_doc",
                  ),
                );
              }
            } else if (data.title == Languages.of(context)!.summarizeWeb) {
              Get.back();
              if (Get.put(
                BottomNavigationController(),
              ).toolsListModel.isNotEmpty) {
                Get.put(ChatGptController()).summarizeWebOnTap(
                  Get.put(
                    BottomNavigationController(),
                  ).toolsListModel.firstWhere(
                    (element) => element.model == "summarize_web",
                  ),
                );
              }
            } else if (data.title == Languages.of(context)!.generateImage) {
              Get.back();
              if (Get.put(
                BottomNavigationController(),
              ).toolsListModel.isNotEmpty) {
                Get.toNamed(
                  Routes.IMAGE_GENERATION,
                  arguments: {
                    "toolModel": Get.put(
                      BottomNavigationController(),
                    ).toolsListModel.firstWhere(
                      (element) => element.model == "image_generation",
                    ),
                  },
                );
              }
            } else if (data.title == Languages.of(context)!.scanText) {
              File? imagePath = await imagePickerBottomSheet(isSub: true);
              if (imagePath != null) {
                String? imageText = await imageToText(file: imagePath);

                if (!utils.isValidationEmpty(imageText)) {
                  mapData.addEntries(
                    {
                      HttpUtil.imageText: imageText,
                      HttpUtil.type: Languages.of(Get.context!)!.scanText,
                    }.entries,
                  );
                }
              }
              Get.back();
            } else if (data.title == Languages.of(Get.context!)!.aiAssistants) {
              mapData.addEntries(
                {
                  HttpUtil.type: Languages.of(Get.context!)!.aiAssistants,
                }.entries,
              );
              Get.back();
              Get.back();
              if (Get.isRegistered<ChatHistoryController>()) {
                Get.back();
              }
            } else if (data.title == Languages.of(Get.context!)!.templates) {
              mapData.addEntries(
                {HttpUtil.type: Languages.of(Get.context!)!.templates}.entries,
              );
              Get.back();
              Get.back();
              if (Get.isRegistered<ChatHistoryController>()) {
                Get.back();
              }
            }
          },
          child: CommonContainer(
            padding: EdgeInsets.symmetric(vertical: 12.px, horizontal: 7.px),
            margin: EdgeInsets.symmetric(horizontal: 10.px),
            color: AppColors().backgroundColor1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                data.image.contains(".svg")
                    ? SvgPicture.asset(
                      data.image,
                      height: 26.px,
                      color: AppColors().darkAndWhite,
                    )
                    : Image.asset(
                      data.image,
                      height: 26.px,
                      color: AppColors().darkAndWhite,
                    ),
                SizedBox(width: 10.px),
                AppText(data.title, fontSize: 16.px),
              ],
            ),
          ),
        );
      },
    ),
  );

  printAction("mapDatamapDatamapData $mapData");
  return mapData;
}
