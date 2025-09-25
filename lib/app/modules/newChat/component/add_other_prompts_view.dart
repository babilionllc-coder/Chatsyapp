import 'package:cached_network_image/cached_network_image.dart';

import '../../../helper/all_imports.dart';
import '../../../helper/image_path.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../chat_gpt/controllers/chat_gpt_controller.dart';
import '../../chat_gpt/views/chat_gpt_view.dart';
import '../../home/controllers/user_profile_model.dart';

class AddOtherPromptsView extends StatelessWidget {
  RxInt? apiCall;

  // void Function()? onTapForAiAssistants;
  // void Function()? onTapForTemplate;

  AddOtherPromptsView({
    super.key,
    this.apiCall,
    // this.onTapForAiAssistants,
    // this.onTapForTemplate,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(Get.put(BottomNavigationController()).toolsListModel.length, (
            index,
          ) {
            ToolsModel data = Get.put(BottomNavigationController()).toolsListModel[index];
            return (data.name == Constants.comingSoon)
                ? SizedBox()
                : Container(
                  padding: EdgeInsets.symmetric(vertical: 12.px, horizontal: 7.px),
                  margin: EdgeInsets.symmetric(horizontal: 10.px),
                  // color: AppColors().whiteAndDark.changeOpacity(0.6),
                  child: GestureDetector(
                    onTap: () async {
                      /*if (data.title == Languages.of(context)!.imageScan) {
                          Get.back();

                          File? imagePath = await imagePickerBottomSheet(isSub: true);

                          if (imagePath?.path != null) {
                            if (Get.put(BottomNavigationController()).toolsListdata.isNotEmpty) {
                              Get.toNamed(Routes.IMAGE_SCAN, arguments: {
                                "imagePath": imagePath?.path,
                                "toolModel": Get.put(BottomNavigationController()).toolsListdata.firstWhere((element) => element.model == "image_scan"),
                              });
                            }
                          }
                        } else if (data.title == Languages.of(context)!.uploadFile) {
                          Get.back();

                          if (Get.put(BottomNavigationController()).toolsListdata.isNotEmpty) {
                            Get.put(ChatGptController()).uploadAndAskCommon(Get.put(BottomNavigationController()).toolsListdata.firstWhere((element) => element.model == "summarize_doc"));
                          }
                        } else if (data.title == Languages.of(context)!.summarizeWeb) {
                          Get.back();
                          if (Get.put(BottomNavigationController()).toolsListdata.isNotEmpty) {
                            Get.put(ChatGptController()).summarizeWebOnTap(Get.put(BottomNavigationController()).toolsListdata.firstWhere((element) => element.model == "summarize_web"));
                          }
                        } else if (data.title == Languages.of(context)!.generateImage) {
                          Get.back();
                          if (Global.isSubscription.value != "1") {
                            Get.put(ChatGptController()).creditBottomSheet();
                            return;
                          }
                          if (Get.put(BottomNavigationController()).toolsListdata.isNotEmpty) {
                            Get.toNamed(Routes.IMAGE_GENERATION, arguments: {"toolModel": Get.put(BottomNavigationController()).toolsListdata.firstWhere((element) => element.model == "image_generation")});
                          }
                        } else if (data.title == Languages.of(context)!.scanText) {
                          Get.back();

                          File? imagePath = await imagePickerBottomSheet(isSub: true);
                          if (imagePath != null) {
                            String? imageText = await imageToText(file: imagePath);

                            if (!utils.isValidationEmpty(imageText)) {
                              newChatController?.text = imageText;
                              getStorageData.saveSend(value: true);
                              printAction("readSendreadSendreadSendreadSend ${getStorageData.readSend()}");
                              if (newChatFocusNode!.hasFocus) {
                                newChatFocusNode!.unfocus();
                              }

                              await Get.put(BottomNavigationController()).speechToText.stop();

                              Future.delayed(const Duration(milliseconds: 100), () {
                                newChatFocusNode!.requestFocus();
                              });
                            }
                          }
                        } else if (data.title == Languages.of(Get.context!)!.aiAssistants) {
                          apiCall?.value = 1;
                          Get.back();
                          Get.back();
                          if (Get.isRegistered<ChatHistoryController>()) {
                            Get.back();
                          }
                          if (onTapForAiAssistants != null) {
                            onTapForAiAssistants!();
                          }
                        } else if (data.title == Languages.of(Get.context!)!.templates) {
                          apiCall?.value = 2;

                          Get.back();
                          Get.back();
                          if (Get.isRegistered<ChatHistoryController>()) {
                            Get.back();
                          }

                          if (onTapForTemplate != null) {
                            onTapForTemplate!();
                          }
                        }*/

                      Get.back();
                      Get.back();
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Get.put(ChatGptController()).onTapTools(model: data);
                      });
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            (ImagePath.logo == data.logo || ImagePath.darkLogo == data.logo)
                                ? 0
                                : 10.px,
                          ),
                          child:
                              data.name == Constants.comingSoon
                                  ? Image.asset(
                                    (isLight) ? ImagePath.darkLogo : ImagePath.logo,
                                    width:
                                        (ImagePath.logo == data.logo ||
                                                ImagePath.darkLogo == data.logo)
                                            ? 15.px
                                            : 30.px,
                                    height:
                                        (ImagePath.logo == data.logo ||
                                                ImagePath.darkLogo == data.logo)
                                            ? 15.px
                                            : 30.px,
                                  )
                                  : CachedNetworkImage(
                                    imageUrl: data.logo ?? "",
                                    width: 30.px,
                                    height: 30.px,
                                    progressIndicatorBuilder:
                                        (context, url, progress) => progressIndicatorView(),
                                    errorWidget:
                                        (context, url, uri) => errorWidgetView().paddingAll(10.px),
                                  ),
                        ),
                        SizedBox(width: 10.px),
                        Flexible(
                          child: AppText(
                            data.name ?? "",
                            fontSize: 16.px,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
          }),
        ),
      ),
    );
  }
}

addOtherPromptsOnTap({required RxBool menu, required BuildContext context}) {
  if (menu.value) {
    Get.back();
    return;
  }
  menu.value = !menu.value;
  if (menu.value) {
    var entry = LocalHistoryEntry(
      onRemove: () {
        // Get.arguments;
        menu.value = false;
      },
    );

    ModalRoute.of(context)?.addLocalHistoryEntry(entry);
  }
}
