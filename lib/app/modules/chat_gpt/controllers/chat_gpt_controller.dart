import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatsy/app/Localization/local_language.dart';
import 'package:chatsy/app/common_widget/common_button.dart';
import 'package:chatsy/app/common_widget/common_show_model_bottom_sheet.dart';
import 'package:chatsy/app/helper/Global.dart';
import 'package:chatsy/app/helper/image_path.dart';
import 'package:chatsy/app/modules/OfferScreen/views/offer_screen_view.dart';
import 'package:chatsy/app/modules/SpecialOfferScreen/views/special_offer_screen_view.dart';
import 'package:chatsy/app/modules/home/controllers/ai_assistants_model.dart';
import 'package:chatsy/app/modules/imageScan/views/image_scan_view.dart';
import 'package:chatsy/app/modules/purchase/views/purchase_view.dart';
import 'package:chatsy/app/modules/summarizeDocument/controllers/summarize_document_controller.dart';
import 'package:chatsy/app/modules/userProfile/controllers/user_profile_controller.dart';
import 'package:chatsy/extension.dart';
import 'package:chatsy/main.dart';
import 'package:docx_to_text/docx_to_text.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html/parser.dart' as html;
import 'package:http/http.dart' as http;
import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:read_pdf_text/read_pdf_text.dart'; // import 'package:read_pdf_text/read_pdf_text.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../../api_repository/api_function.dart';
import '../../../api_repository/loading.dart';
import '../../../common_widget/comman_text_feild_bottom_sheet.dart';
import '../../../common_widget/iphone_has_notch.dart';
import '../../../common_widget/rx_common_model.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/font_family.dart';
import '../../../routes/app_pages.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../home/controllers/user_profile_model.dart';
import '../../newChat/controllers/new_chat_controller.dart';
import '../../purchase/controllers/purchase_controller.dart';
import '../../purchase/models/get_plan_details_model.dart';
import '../../summarizeWebsite/controllers/summarize_website_controller.dart';
import '../../youtubeSummary/controllers/youtube_summary_controller.dart';
import '../views/chat_gpt_view.dart';

class ChatGptController extends GetxController {
  RxString url = "".obs;
  RxString name = "".obs;
  TextEditingController textEditController = TextEditingController();

  File? tempFile;
  RxString question = "".obs;
  String userId = "";
  RxInt selectedPlan = 0.obs;
  List<AssistantData> assistantsList = [];

  void goToNewChatPage({required ToolsModel model}) {
    if (!kDebugMode &&
        model.isPremium == "1" &&
        Global.isSubscription.value != "1") {
      goToPurchasePage();
      return;
    }

    Get.delete<NewChatController>();

    Get.toNamed(
      Routes.NEW_CHAT,
      arguments: {HttpUtil.isAssistant: false, HttpUtil.isModel: model},
    );
  }

  int convertToSeconds(String time) {
    List<String> parts = time.split(':');

    if (parts.length != 3) {
      throw FormatException('Time format must be HH:MM:SS');
    }

    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);

    return (hours * 3600) + (minutes * 60) + seconds;
  }

  // RxString selectedLanguage = "English".obs;
  TextEditingController questions = TextEditingController();

  Future<void> onTapTools({required ToolsModel model}) async {
    HapticFeedback.mediumImpact();

    if (Global.isSubscription.value != "1" && Global.chatLimit.value <= 0) {
      // controller.creditBottomSheet();
      goToPurchasePage();
    } else if (model.model == Constants.summarizeDocAPIType) {
      if (getStorageData.readBool(getStorageData.uploadAndAsk) == null) {
        uploadAskFirstBottomSheet(
          model,
          onTap: () {
            uploadAndAskCommon(model);
          },
        );
      } else {
        uploadAndAskCommon(model);
      }
    } else if (model.model == Constants.summarizeWebAPIType) {
      if (getStorageData.readBool(getStorageData.summarizeWebsite) == null) {
        summarizeWebFirstBottomSheet(
          model: model,
          onTap: () {
            HapticFeedback.mediumImpact();

            summarizeWebOnTap(model);
          },
        );
      } else {
        summarizeWebOnTap(model);
      }
    } else if (model.model == Constants.imageScanAPIType) {
      debugPrint("image Scan");
      if (getStorageData.readBool(getStorageData.visionScan) == null) {
        imageScanFirstBottomSheet(
          model,
          onTap: () async {
            File? imagePath = await imagePickerBottomSheet(
              isSub: model.isPremium == "1",
            );
            if (imagePath?.path != null) {
              /// TODO: model pass krvanu che
              ImageScanView.toNamed(model: model, imagePath: imagePath?.path);
              // Get.toNamed(
              //   Routes.IMAGE_SCAN,
              //   arguments: {"imagePath": imagePath?.path, "toolModel": model},
              // );
            }
          },
        );
      } else {
        File? imagePath = await imagePickerBottomSheet(
          isSub: model.isPremium == "1",
        );
        if (imagePath?.path != null) {
          ImageScanView.toNamed(model: model, imagePath: imagePath?.path);
        }
      }
    } else if (model.model == Constants.textScanAPIType) {
      if (getStorageData.readBool(getStorageData.textScan) == null) {
        textScanFirstBottomSheet(
          model,
          onTap: () {
            if (Global.isSubscription.value != "1" && model.isPremium == "1") {
              // controller.creditBottomSheet();
              goToPurchasePage();

              return;
            }
            Get.delete<NewChatController>();
            Get.toNamed(
              Routes.NEW_CHAT,
              arguments: {
                HttpUtil.isAssistant: false,
                HttpUtil.isTextScan: true,
                "toolModel": model,
              },
            );
          },
        );
      } else {
        if (Global.isSubscription.value != "1" && model.isPremium == "1") {
          // controller.creditBottomSheet();

          goToPurchasePage();

          return;
        }
        Get.delete<NewChatController>();
        Get.toNamed(
          Routes.NEW_CHAT,
          arguments: {
            HttpUtil.isAssistant: false,
            HttpUtil.isTextScan: true,
            "toolModel": model,
          },
        );
      }
    } else if (model.model == Constants.imageGenerationAPIType) {
      if (getStorageData.readBool(getStorageData.imageGeneration) == null) {
        imageGenerationFirstBottomSheet(
          model,
          onTap: () {
            if (Global.isSubscription.value != "1" && model.isPremium == "1") {
              // controller.creditBottomSheet();

              goToPurchasePage();

              return;
            }
            Get.toNamed(
              Routes.IMAGE_GENERATION,
              arguments: {"toolModel": model},
            );
          },
        );
      } else {
        if (Global.isSubscription.value != "1" && model.isPremium == "1") {
          // controller.creditBottomSheet();

          goToPurchasePage();

          return;
        }
        Get.toNamed(Routes.IMAGE_GENERATION, arguments: {"toolModel": model});
      }
    } else if (model.model == Constants.youtubeSummarizeAPIType) {
      youtubeOnTap(model);
    } else if (model.model == Constants.realTimeWebAPIType) {
      if (Global.isSubscription.value != "1" && model.isPremium == "1") {
        goToPurchasePage();

        return;
      }

      Get.delete<NewChatController>();
      Get.toNamed(
        Routes.NEW_CHAT,
        arguments: {
          HttpUtil.isAssistant: false,
          HttpUtil.isRealTime: true,
          "toolModel": model,
        },
      );
    }
  }

  // RefreshController refreshController = RefreshController(initialRefresh: false);
  final easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
  );

  void uploadAskFirstBottomSheet(
    ToolsModel model, {
    required void Function() onTap,
  }) {
    commonFirstTimeOpenBottomSheet(
      modelList: uploadAndAsk,
      imageNetwork: model.logo ?? "",
      image: "",
      imagePath: ImagePath.summarizeDocumentImage,
      title: model.name ?? "",
      subTitle: Languages.of(Get.context!)!.summarizeDocument,
      onTap: () {
        getStorageData.saveBool(getStorageData.uploadAndAsk, true);
        Get.back();
        if (Global.isSubscription.value == "0" && Global.chatLimit.value == 0) {
          goToPurchasePage();
        } else {
          onTap();
        }
      },
    );
  }

  void imageScanFirstBottomSheet(
    ToolsModel model, {
    required void Function() onTap,
  }) {
    commonFirstTimeOpenBottomSheet(
      modelList: visionScan,
      image: "",
      imageNetwork: model.logo,
      imagePath: ImagePath.imageScanImage,
      title: model.name ?? "",
      subTitle: Languages.of(Get.context!)?.scanDocumentsImages ?? '',
      onTap: () {
        getStorageData.saveBool(getStorageData.visionScan, true);
        Get.back();
        onTap();
      },
    );
  }

  void chatGptFirstTimeBottomSheet({
    required void Function() onTap,
    required String image,
  }) {
    commonFirstTimeOpenBottomSheet(
      image: "",
      modelList: chatGPT,
      imageNetwork: image,
      padding: EdgeInsets.zero,
      title: Languages.of(Get.context!)!.chatGPT,
      subTitle: Languages.of(Get.context!)!.chatGPTIsYourAIAssistant,
      onTap: () {
        getStorageData.saveBool(getStorageData.chatGPT, true);
        Get.back();
        onTap();
      },
    );
  }

  void gpt4oFirstTimeBottomSheet({
    required void Function() onTap,
    required String image,
  }) {
    commonFirstTimeOpenBottomSheet(
      image: "",
      title: AppStrings.T.GPT4o,
      modelList: gpt4o,
      imageNetwork: image,
      padding: EdgeInsets.zero,
      subTitle: Languages.of(Get.context!)!.chatGPT4IsYourAdvancedAIAssistant,
      onTap: () {
        getStorageData.saveBool(getStorageData.gpt4o, true);
        Get.back();
        onTap();
      },
    );
  }

  void palmFirstTimeBottomSheet({
    required void Function() onTap,
    required String image,
  }) {
    commonFirstTimeOpenBottomSheet(
      image: "",
      modelList: palm,
      imageNetwork: image,
      padding: EdgeInsets.zero,
      title: Languages.of(Get.context!)!.palm,
      subTitle:
          Languages.of(
            Get.context!,
          )!.paLMIsAnAILanguageModelDevelopedByGoogleAI,
      onTap: () {
        getStorageData.saveBool(getStorageData.palm, true);
        Get.back();
        if (Global.isSubscription.value == "0" && Global.chatLimit.value == 0) {
          goToPurchasePage();
        } else {
          onTap();
        }
      },
    );
  }

  void geminiFirstTimeBottomSheet({
    required void Function() onTap,
    required String image,
  }) {
    commonFirstTimeOpenBottomSheet(
      image: "",
      modelList: gemini,
      imageNetwork: image,
      padding: EdgeInsets.zero,
      title: Languages.of(Get.context!)!.gemini,
      subTitle: Languages.of(Get.context!)!.geminiIsAnInnovativeAITechnology,
      onTap: () {
        getStorageData.saveBool(getStorageData.gemini, true);
        Get.back();
        if (Global.isSubscription.value == "0" && Global.chatLimit.value == 0) {
          goToPurchasePage();
        } else {
          onTap();
        }
      },
    );
  }

  void deepseekFirstTimeBottomSheet({
    required void Function() onTap,
    required String image,
  }) {
    commonFirstTimeOpenBottomSheet(
      image: "",
      modelList: deepseek,
      imageNetwork: image,
      padding: EdgeInsets.zero,
      title: Languages.of(Get.context!)!.deepseek,
      subTitle: Languages.of(Get.context!)!.deepseekIsAnInnovativeAITechnology,
      onTap: () {
        getStorageData.saveBool(getStorageData.deepseek, true);
        Get.back();
        if (Global.isSubscription.value == "0" && Global.chatLimit.value == 0) {
          goToPurchasePage();
        } else {
          onTap();
        }
      },
    );
  }

  void imageGenerationFirstBottomSheet(
    ToolsModel model, {
    required void Function() onTap,
  }) {
    commonFirstTimeOpenBottomSheet(
      modelList: imageGeneration,
      image: "",
      imageNetwork: model.logo,
      imagePath: ImagePath.imageGenerationImage,
      title: model.name ?? "",
      subTitle: Languages.of(Get.context!)!.transformYourVisionIntoArt,
      onTap: () {
        getStorageData.saveBool(getStorageData.imageGeneration, true);
        Get.back();
        onTap();
      },
    );
  }

  void realTimeWebFirstBottomSheet(
    ToolsModel model, {
    required void Function() onTap,
  }) {
    commonFirstTimeOpenBottomSheet(
      modelList: realTimeWeb,
      image: "",
      imageNetwork: model.logo,
      imagePath: ImagePath.webSiteImage,
      title: model.name ?? "",
      subTitle: Languages.of(Get.context!)!.accessesLiveInfoForRealTimeResponses,
      onTap: () {
        getStorageData.saveBool(getStorageData.realTimeWeb, true);
        Get.back();
        onTap();
      },
    );
  }

  void textScanFirstBottomSheet(
    ToolsModel model, {
    required void Function() onTap,
  }) {
    commonFirstTimeOpenBottomSheet(
      modelList: textScan,
      image: "",
      imageNetwork: model.logo,
      imagePath: ImagePath.textScanImage,
      title: model.name ?? "",
      subTitle: Languages.of(Get.context!)!.scanAnyText,
      onTap: () {
        getStorageData.saveBool(getStorageData.textScan, true);
        Get.back();
        onTap();
      },
    );
  }

  void summarizeWebFirstBottomSheet({
    required ToolsModel model,
    required void Function() onTap,
  }) {
    commonFirstTimeOpenBottomSheet(
      modelList: summarizeWeb,
      image: "",
      imageNetwork: model.logo ?? "",
      imagePath: ImagePath.webSiteImage,
      title: model.name ?? "",
      subTitle: Languages.of(Get.context!)!.websiteInsightsWithAIChatSY,
      onTap: () {
        getStorageData.saveBool(getStorageData.summarizeWebsite, true);
        Get.back();
        onTap();
      },
    );
  }

  void summarizePDFFirstBottomSheet({required void Function() onTap}) {
    commonFirstTimeOpenBottomSheet(
      modelList: summarizePDF,
      image: ImagePath.summarizePDF,
      imagePath: ImagePath.summarizePdfImage,
      title: Languages.of(Get.context!)!.summarizePDF,
      subTitle: Languages.of(Get.context!)!.summarizeAnyPDF,
      onTap: () {
        getStorageData.saveBool(getStorageData.summarizePDF, true);
        Get.back();
        onTap();
      },
    );
  }

  Future<String?> getAllPlainTextFromWebsite(
    String url,
    RxBool isProcess,
  ) async {
    printAction("getAllPlainTextFromWebsite     $url");
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(Duration(seconds: 10));
      if (response.statusCode != 200) {
        isProcess.value = false;
        printAction('Failed to fetch website: ${response.statusCode}');
        throw Exception('Failed to fetch website: ${response.statusCode}');
      }
      final document = html.parse(response.body);
      document.querySelectorAll('noscript, script, style, img').forEach((
        element,
      ) {
        element.remove();
      });

      document.querySelectorAll('div[style]').forEach((element) {
        element.remove();
      });

      var plainText = "${document.head!.text} ${document.body!.text}";

      isProcess.value = false;
      if (plainText.length > 50000) {
        plainText = plainText.substring(0, 50000);
      }
      return plainText;
    } catch (e) {
      printAction("eeeeeee $e");
      isProcess.value = false;
    }
    return null;
  }

  Future<Map<String, dynamic>?>? getAllPlainTextFromWebsiteDataMap(
    String url,
  ) async {
    printAction("getAllPlainTextFromWebsite     $url");
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        printAction('Failed to fetch website: ${response.statusCode}');
        throw Exception('Failed to fetch website: ${response.statusCode}');
      }
      final document = html.parse(response.body);
      document.querySelectorAll('noscript, script, style, img').forEach((
        element,
      ) {
        element.remove();
      });

      document.querySelectorAll('div[style]').forEach((element) {
        element.remove();
      });

      var plainText = document.body!.text;

      if (plainText.length > 50000) {
        plainText = plainText.substring(0, 50000);
      }
      return {"title": document.head!.text, "body": plainText};
    } catch (e) {
      printAction("eeeeeee $e");
    }
    return null;
  }

  RxString desc = "".obs;
  RxBool isSend = false.obs;
  RxBool isProcess = false.obs;

  void summarizeWebOnTap(ToolsModel model) {
    if (Global.isSubscription.value != "1" && model.isPremium == "1") {
      // creditBottomSheet();
      goToPurchasePage();
      return;
    }
    RxBool isClearShow = false.obs;
    isSend = false.obs;
    isProcess = false.obs;

    textEditController.text = "";
    // selectedLanguage.value = "English";
    question.value = "";
    desc = "".obs;
    commonToolsBottomSheet(
      placeholder: "",
      type: Constants.website,
      title: Languages.of(Get.context!)!.addWebsite,
      sunTitle: Languages.of(Get.context!)!.addWebsiteDesc,
      btnText: Languages.of(Get.context!)!.addWebsite,
      // sunTitle: Languages.of(Get.context!)!.summarizeArticleWeb,
      onTap: () async {
        HapticFeedback.mediumImpact();
        utils.hideKeyboard();

        if (textEditController.text.isNotEmpty) {
          if (!utils.isValidationEmpty(desc.value)) {
            if (isSend.value) {
              Get.back();

              Get.delete<SummarizeWebsiteController>();

              Get.toNamed(
                Routes.SUMMARIZE_WEBSITE,
                arguments: {
                  "question":
                      textEditController.text.contains("https://")
                          ? textEditController.text
                          : "https://${textEditController.text}",
                  "toolModel": model,
                  "documentText": desc.value,
                },
              );
              textEditController.clear();
              return;
            }
            // });
          }
          // Loading.show();
          isProcess.value = true;
          bool status = await isCorrectWebsite(
            textEditController.text,
            isProcess,
          );
          if (status) {
            if (Utils().isValidationEmpty(desc.value)) {
              desc.value =
                  await getAllPlainTextFromWebsite(
                    textEditController.text.contains("https://")
                        ? textEditController.text
                        : "https://${textEditController.text}",
                    isProcess,
                  ) ??
                  "";
              if (Utils().isValidationEmpty(desc.value)) {
                utils.showToast(
                  message: Languages.of(Get.context!)!.pleaseEnterValidUrl,
                );
              } else {
                isSend.value = true;
              }
            } else {
              // Get.back();
            }
          } else {
            utils.showToast(
              message: Languages.of(Get.context!)!.pleaseEnterValidUrl,
            );
          }
        } else {
          utils.showToast(message: Languages.of(Get.context!)!.pleaseEnterUrl);
        }
      },
      child: GetBuilder<ChatGptController>(
        init: ChatGptController(),
        builder: (controller) {
          return Obx(() {
            return CommonTextFiledBottomSheet(
              controller: textEditController,
              maxLine: 1,
              suffixIcon:
                  isClearShow.value
                      ? GestureDetector(
                        onTap: () {
                          textEditController.clear();
                          desc.value = "";

                          isClearShow.value = false;
                          isSend.value = false;
                        },
                        child: SvgPicture.asset(
                          ImagePath.icCloseBlue,
                        ).marginOnly(right: 6.px, left: 5),
                      )
                      : const SizedBox(),
              onChanged: (p0) {
                isSend.value = false;

                desc.value = "";
                if (p0.isEmpty) {
                  isClearShow.value = false;
                } else {
                  isClearShow.value = true;
                }
              },
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10.px, right: 10.px),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.px),
                  child: Obx(() {
                    return CachedNetworkImage(
                      imageUrl:
                          Utils().isValidationEmpty(desc.value)
                              ? model.defaultLogo ?? ""
                              : model.logo ?? "",
                      width: 18.px,
                      height: 18.px,
                      progressIndicatorBuilder:
                          (context, url, progress) =>
                              progressIndicatorView(borderRadius: 5.px),
                      errorWidget:
                          (context, url, uri) =>
                              errorWidgetView().paddingAll(8.px),
                    );
                  }),
                ),
              ),
              bottomLeft: url.value == "" ? 10.px : 0.px,
              bottomRight: url.value == "" ? 10.px : 0.px,
              hintText: Languages.of(Get.context!)!.pasteLink,
            );
          }).marginOnly(bottom: 2.px);
        },
      ),
    );
  }

  void youtubeOnTap(ToolsModel model) {
    if (Global.isSubscription.value != "1" && model.isPremium == "1") {
      // creditBottomSheet();

      goToPurchasePage();
      return;
    }

    name.value = "";
    url.value = "";
    Map data = {};
    isSend = false.obs;
    isProcess.value = false;
    textEditController.text = "";
    String? videoId;
    commonToolsBottomSheet(
      placeholder: "",
      title: Languages.of(Get.context!)!.youtubeSummary,
      type: Constants.youtube,
      sunTitle:
          Languages.of(Get.context!)!.searchAndAskAboutYouTubeVideoContent,
      btnText: Languages.of(Get.context!)!.addWebsite,
      onTap: () async {
        HapticFeedback.mediumImpact();
        utils.hideKeyboard();
        if (textEditController.text.isEmpty) {
          Utils().showToast(message: Languages.of(Get.context!)!.url);
        } else {
          if (data.isNotEmpty) {
            Get.back();
            Get.delete<YoutubeSummaryController>();
            Get.toNamed(Routes.YOUTUBE_SUMMARY, arguments: data);
            return;
          }

          if (Utils().isValidYouTubeUrl(textEditController.text)) {
            videoId = Utils().getYouTubeVideoId(textEditController.text);
            if (videoId != null) {
              if (Utils().isValidationEmpty(name.value) &&
                  Utils().isValidationEmpty(url.value)) {
                printAction("isSend.valueisSend.value111111 ${isSend.value}");
                if (!isSend.value) {
                  data = await getYouTubeVideoTitle(
                    videoId ?? "",
                    model,
                    isProcess,
                  );
                  if (data.isNotEmpty) {
                    isSend.value = true;
                    printAction(
                      "isSend.valueisSend.value2222222 ${isSend.value}",
                    );
                  }
                }
              } else {
                printAction(
                  "isSendisSendisSendisSendisSend3333333 ${isSend.value}",
                );
              }
            } else {
              Utils().showToast(
                message: Languages.of(Get.context!)!.pleaseEnterValidUrl,
              );
            }
          } else {
            Utils().showToast(
              message: Languages.of(Get.context!)!.pleaseEnterValidUrl,
            );
          }
        }
      },
      child: Obx(
        () => Column(
          children: [
            CommonTextFiledBottomSheet(
              controller: textEditController,
              maxLine: 1,
              onChanged: (p0) {
                isSend.value = false;
                name.value = "";
                url.value = "";

                if (data.isNotEmpty) {
                  data = {};
                }
              },
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10.px, right: 10.px),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.px),
                  child: CachedNetworkImage(
                    imageUrl:
                        url.value != ""
                            ? model.logo ?? ""
                            : model.defaultLogo ?? "",
                    width: 18.px,
                    height: 18.px,
                    progressIndicatorBuilder:
                        (context, url, progress) =>
                            progressIndicatorView(borderRadius: 5.px),
                    errorWidget:
                        (context, url, uri) =>
                            errorWidgetView().paddingAll(8.px),
                  ),
                ),
              ),
              bottomLeft: url.value == "" ? 10.px : 0.px,
              bottomRight: url.value == "" ? 10.px : 0.px,
              hintText: Languages.of(Get.context!)!.enterYoutubeLink,
            ).marginOnly(bottom: 2.px),
            url.value != ""
                ? Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.black.changeOpacity(0.08),
                      // Border color
                      width: 1.px, // Border width
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.px),
                      bottomRight: Radius.circular(10.px),
                    ), // Circular border radius
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.px),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.px),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: url.value,
                            width: 64.px,
                            height: 64.px,
                            fit: BoxFit.cover,
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                    progressIndicatorView(),
                            errorWidget:
                                (context, url, uri) =>
                                    errorWidgetView().paddingAll(8.px),
                          ),
                        ).marginOnly(right: 8.px),
                        Expanded(
                          child: AppText(
                            name.value,
                            maxLines: 2,
                            fontSize: 14.px,
                            color: AppColors().darkAndWhite,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  // realTimeWebOnTap(ToolsModel model) async {
  //   commonToolsBottomSheet(
  //     placeholder: "",
  //     title: "Real Time Web",
  //     type: Constants.realTimeWeb,
  //     sunTitle: "Real Time Web is coming soon",
  //     btnText: Languages.of(Get.context!)!.cancel,
  //     onTap: () async {},
  //     child: Column(
  //       children: [
  //         ClipRRect(
  //           child: CachedNetworkImage(
  //             imageUrl: model.logo ?? "",
  //             width: 45.px,
  //             height: 45.px,
  //             progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(),
  //             errorWidget: (context, url, uri) => errorWidgetView().paddingAll(10.px),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Future<String> getCaptions(String videoId) async {
    final apiKey = Constants.youtubeKey;

    // Fetch captions list for the provided video ID
    final captionsUrl =
        "https://www.googleapis.com/youtube/v3/captions?videoId=$videoId&key=$apiKey&part=snippet";

    final response = await http.get(Uri.parse(captionsUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final captionsList = data["items"];

      if (captionsList.isNotEmpty) {
        final captionsId = captionsList[0]["id"];

        // Fetch captions text in SRT format
        final captionTextUrl =
            "https://www.googleapis.com/youtube/v3/captions/$captionsId?key=$apiKey&tfmt=srt";
        final captionsResponse = await http.get(Uri.parse(captionTextUrl));

        if (captionsResponse.statusCode == 200) {
          return captionsResponse.body; // Returns SRT formatted captions text
        } else {
          return "Error fetching captions text.";
        }
      } else {
        return "No captions available for this video.";
      }
    } else {
      return "Error fetching captions list: ${response.reasonPhrase}";
    }
  }

  Future<Map> getYouTubeVideoTitle(
    String videoId,
    ToolsModel model,
    RxBool isProcess,
  ) async {
    name.value = "";
    String channelId = "";
    String channelTitle = "";

    try {
      final url1 =
          'https://www.googleapis.com/youtube/v3/videos?part=snippet&id=$videoId&key=${Constants.youtubeKey}';

      final response = await http.get(Uri.parse(url1));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['items'].length > 0) {
          printAction("-=-=-=-=-=-=--=-${data['items'][0]}");
          name.value = data['items'][0]['snippet']['title'];
          channelId = data['items'][0]['snippet']['channelId'];
          channelTitle = data['items'][0]['snippet']['channelTitle'];

          url.value = "https://img.youtube.com/vi/$videoId/hqdefault.jpg";
          isProcess.value = true;
          var yt = YoutubeExplode();
          try {
            printAction("-=-=-=-= try");
            ClosedCaptionManifest trackManifest = await yt.videos.closedCaptions
                .getManifest(videoId);
            printAction("-=-=-=-= try  2121212");
            String transcription = "";

            log("trackManifest-----     ${trackManifest.tracks.length}");
            if (trackManifest.tracks.isNotEmpty) {
              var trackInfo = trackManifest.getByLanguage(
                trackManifest.tracks.first.language.code,
                autoGenerated: true,
              );

              if (trackInfo.isNotEmpty) {
                var track = await yt.videos.closedCaptions.get(trackInfo.first);
                transcription = track.captions
                    .map((caption) => caption.text)
                    .join(' ');
              }
            } else {
              transcription = "";
            }

            log(
              "-=-=-==transcriptiontranscriptiontranscriptiontranscription $transcription",
            );
            isProcess.value = false;

            return {
              "title": name.value,
              "transcription": transcription,
              "channelId": channelId,
              "channelTitle": channelTitle,
              "url": textEditController.text,
              "toolModel": model,
            };
          } on VideoUnavailableException catch (e) {
            printAction("Video unavailable $e");
            isProcess.value = false;

            // Get.back();
            // // utils.showToast(message: e.toString());
            return {
              "title": name.value,
              "transcription": "",
              "channelId": channelId,
              "channelTitle": channelTitle,
              "url": textEditController.text,
              "toolModel": model,
            };
          } catch (e) {
            printAction("-=-=-=-=-===catch is is $e");
            isProcess.value = false;

            return {
              "title": name.value,
              "transcription": "",
              "channelId": channelId,
              "channelTitle": channelTitle,
              "url": textEditController.text,
              "toolModel": model,
            };
          }
        } else {
          isProcess.value = false;

          utils.showToast(message: "Video not found");
          name.value = "";

          return {};
        }
      } else {
        isProcess.value = false;

        utils.showToast(message: "'Failed to load video data'");
        return {};
      }
    } catch (e) {
      printAction("-=-=-=-=-===catch is $e");
      isProcess.value = false;

      // Get.back();
      // // utils.showToast(message: e.toString());
      return {
        "title": name.value,
        "transcription": "",
        "channelId": channelId,
        "channelTitle": channelTitle,
        "url": textEditController.text,
        "toolModel": model,
      };
    }
  }

  List<Plans> purchaseList = [];

  List<RxCommonModel> uploadAndAsk = [
    RxCommonModel(
      title: Languages.of(Get.context!)!.uploadYourDocument,
      subTitle:
          Languages.of(Get.context!)!.clickTheUploadButtonAndSelectYourFile,
      image: ImagePath.upload,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.askQuestion,
      subTitle: Languages.of(Get.context!)!.typeInYourQueryBboutTheDocument,
      image: ImagePath.askQuestion,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.getAnswer,
      subTitle: Languages.of(Get.context!)!.receiveInstantAIGeneratedResponses,
      image: ImagePath.getAnswer,
    ),
  ];

  List<RxCommonModel> visionScan = [
    RxCommonModel(
      title: Languages.of(Get.context!)!.scanDocument,
      subTitle: Languages.of(Get.context!)!.captureYourDocumentOrImage,
      image: ImagePath.scanDocument,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.askQuestion,
      subTitle: Languages.of(Get.context!)!.enterYourQuestion,
      image: ImagePath.askQuestion,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.getInsights,
      subTitle: Languages.of(Get.context!)!.receiveInstantAIGeneratedAnswers,
      image: ImagePath.getInsights,
    ),
  ];
  List<RxCommonModel> textScan = [
    RxCommonModel(
      title: Languages.of(Get.context!)!.uploadOrCapture,
      subTitle: Languages.of(Get.context!)!.uploadAnyDocumentOrPicture,
      image: ImagePath.upload,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.askAnything,
      subTitle: Languages.of(Get.context!)!.askAICHATSYWhatDocument,
      image: ImagePath.askQuestion,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.getRespondOnScan,
      subTitle: Languages.of(Get.context!)!.getQuickResponsesInSeconds,
      image: ImagePath.getAnswer,
    ),
  ];
  List<RxCommonModel> imageGeneration = [
    RxCommonModel(
      title: Languages.of(Get.context!)!.describeImage,
      subTitle:
          Languages.of(Get.context!)!.enterBriefDescriptionOfTheImageYouWant,
      image: ImagePath.describeImage,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.selectStyle,
      subTitle:
          Languages.of(Get.context!)!.pickStyleOrTemplateThatSuitsYourVision,
      image: ImagePath.selectStyle,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.generate,
      subTitle: Languages.of(Get.context!)!.clickToCreateYourImage,
      image: ImagePath.generates,
    ),
  ];
  List<RxCommonModel> summarizeWeb = [
    RxCommonModel(
      title: Languages.of(Get.context!)!.addWebsiteURL,
      subTitle: Languages.of(Get.context!)!.pasteTheWebsiteLink,
      image: ImagePath.lightLink,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.clickSummarize,
      subTitle: Languages.of(Get.context!)!.hitTheSummarizeButtonStart,
      image: ImagePath.askQuestion,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.readSummary,
      subTitle: Languages.of(Get.context!)!.getConciseSummaryWebpage,
      image: ImagePath.generates,
    ),
  ];
  List<RxCommonModel> summarizePDF = [
    RxCommonModel(
      title: Languages.of(Get.context!)!.uploadPDF,
      subTitle: Languages.of(Get.context!)!.uploadAnyDocumentOrPdf,
      image: ImagePath.pdf,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.askAnything,
      subTitle: Languages.of(Get.context!)!.askAICHATSYWhatDocument,
      image: ImagePath.selectStyle,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.getResponses,
      subTitle: Languages.of(Get.context!)!.getQuickResponsesInSeconds,
      image: ImagePath.generates,
    ),
  ];
  List<RxCommonModel> chatGPT = [
    RxCommonModel(
      title: Languages.of(Get.context!)!.knowledgeBase,
      subTitle:
          Languages.of(Get.context!)!.deliversAccurateInformativeResponses,
      image: ImagePath.knowledge,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.creativity,
      subTitle: Languages.of(Get.context!)!.helpsGenerateIdeasAndWriteContent,
      image: ImagePath.creativity,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.efficiency,
      subTitle: Languages.of(Get.context!)!.providesQuickReliableAnswers,
      image: ImagePath.efficiency,
    ),
  ];
  List<RxCommonModel> gpt4o = [
    RxCommonModel(
      title: Languages.of(Get.context!)!.enhancedUnderstanding,
      subTitle: Languages.of(Get.context!)!.deliversMoreAccurateResponses,
      image: ImagePath.enhanced,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.creativeAssistance,
      subTitle:
          Languages.of(Get.context!)!.generatesIdeasAndContentEffortlessly,
      image: ImagePath.creative,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.realTimeUpdates,
      subTitle:
          Languages.of(Get.context!)!.accessesLiveInfoForRealTimeResponses,
      image: ImagePath.realTime,
    ),
  ];
  List<RxCommonModel> palm = [
    RxCommonModel(
      title: Languages.of(Get.context!)!.advancedPatternRecognition,
      subTitle:
          Languages.of(Get.context!)!.enhancesPatternRecognitionCapabilities,
      image: ImagePath.advanced,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.contextualUnderstanding,
      subTitle:
          Languages.of(Get.context!)!.improvesModelsComprehensionOfContext,
      image: ImagePath.contextual,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.enhancedPerformance,
      subTitle:
          Languages.of(Get.context!)!.boostOverallModelCapabilitiesEffectively,
      image: ImagePath.enhancedPerformance,
    ),
  ];
  List<RxCommonModel> gemini = [
    RxCommonModel(
      title: Languages.of(Get.context!)!.smoothInteractions,
      subTitle: Languages.of(Get.context!)!.enablesIntuitiveUserEngagement,
      image: ImagePath.smoothInteractions,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.efficientTasks,
      subTitle: Languages.of(Get.context!)!.enhancesProductivity,
      image: ImagePath.efficientTasks,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.advancedIntegration,
      subTitle: Languages.of(Get.context!)!.cuttingEdgeAIOptimization,
      image: ImagePath.advancedIntegration,
    ),
  ];

  List<RxCommonModel> deepseek = [
    RxCommonModel(
      title: Languages.of(Get.context!)!.smoothInteractions,
      subTitle: Languages.of(Get.context!)!.enablesIntuitiveUserEngagement,
      image: ImagePath.smoothInteractions,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.efficientTasks,
      subTitle: Languages.of(Get.context!)!.enhancesProductivity,
      image: ImagePath.efficientTasks,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.advancedIntegration,
      subTitle: Languages.of(Get.context!)!.cuttingEdgeAIOptimization,
      image: ImagePath.advancedIntegration,
    ),
  ];

  List<RxCommonModel> realTimeWeb = [
    RxCommonModel(
      title: Languages.of(Get.context!)!.realTimeUpdates,
      subTitle: Languages.of(Get.context!)!.accessesLiveInfoForRealTimeResponses,
      image: ImagePath.realTime,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.enhancedUnderstanding,
      subTitle: Languages.of(Get.context!)!.deliversMoreAccurateResponses,
      image: ImagePath.enhanced,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.creativeAssistance,
      subTitle: Languages.of(Get.context!)!.generatesIdeasAndContentEffortlessly,
      image: ImagePath.creative,
    ),
  ];

  commonToolsBottomSheet({
    required final String type,
    required final String title,
    required final Widget child,
    required final String sunTitle,
    final String? btnText,
    required void Function() onTap,
    required final String placeholder,
  }) async {
    fileName.value = '';
    question.value = "";

    await CommonShowModelBottomSheet(
      child: Obx(() {
        question.value;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppText(
              title,
              fontSize: 20.px,
              fontFamily: FontFamily.helveticaBold,
              color: AppColors().darkAndWhite,
            ).marginOnly(bottom: 8.px, top: 24.px),
            AppText(
              sunTitle,
              fontSize: 14.px,
              color: AppColors().darkAndWhite.changeOpacity(.70),
            ).marginOnly(bottom: 24.px),
            placeholder == ""
                ? const SizedBox()
                : AppText(
                  placeholder,
                  fontSize: 12.px,
                  color: AppColors().darkAndWhite,
                ).marginOnly(bottom: 8.px),
            child.marginOnly(bottom: 24.px),
            CommonButton(
              onTap: isProcess.value ? () {} : onTap,
              title:
                  ((Constants.document == type ||
                              Constants.website == type ||
                              Constants.youtube == type) &&
                          (isSend.value))
                      ? Languages.of(Get.context!)!.summarize
                      : (btnText ?? Languages.of(Get.context!)!.continues),
              textColor: AppColors.white,
              child: isProcess.value ? Global.isLoadingView() : null,
            ),
          ],
        );
      }).marginSymmetric(horizontal: 16.px),
    );

    isSend.value = false;
    isProcess.value = false;
  }

  commonFirstTimeOpenBottomSheet({
    final String? imageNetwork,
    required final String image,
    String? imagePath,
    required final String title,
    EdgeInsetsGeometry? padding,
    String? buttonName,
    required final String subTitle,
    required final void Function() onTap,
    required final List<RxCommonModel> modelList,
  }) {
    CommonShowModelBottomSheet(
      child: Column(
        children: [
          imagePath == null
              ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: padding ?? EdgeInsets.all(18.px),
                    margin: EdgeInsets.only(top: 24.px, bottom: 16.px),
                    child: Center(
                      child:
                          image.isNotEmpty
                              ? Image.asset(image, height: 32.px)
                              : ClipRRect(
                                borderRadius: BorderRadius.circular(10.px),
                                child: CachedNetworkImage(
                                  imageUrl: imageNetwork ?? "",
                                  height: 32.px,
                                  width: 32.px,
                                  progressIndicatorBuilder:
                                      (context, url, progress) =>
                                          progressIndicatorView(
                                            borderRadius: 10.px,
                                          ),
                                  errorWidget:
                                      (context, url, uri) =>
                                          errorWidgetView().paddingAll(8.px),
                                ),
                              ),
                    ),
                  ),
                  AppText(
                    title,
                    fontSize: 20.px,
                    fontFamily: FontFamily.helveticaBold,
                    color: AppColors().darkAndWhite,
                  ).marginOnly(bottom: 16.px),
                  AppText(
                    subTitle,
                    fontSize: 14.px,
                    textAlign: TextAlign.center,
                    color: AppColors().darkAndWhite.changeOpacity(.70),
                  ).marginOnly(bottom: 32.px),
                ],
              )
              : Column(
                children: [
                  SizedBox(height: 10.px),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: padding ?? EdgeInsets.all(10.px),
                        child: ClipOval(
                          child:
                              image.isNotEmpty
                                  ? Image.asset(image, height: 30.px)
                                  : CachedNetworkImage(
                                    imageUrl: imageNetwork ?? "",
                                    height: 32.px,
                                    width: 32.px,
                                    progressIndicatorBuilder:
                                        (context, url, progress) =>
                                            progressIndicatorView(circle: true),
                                    errorWidget:
                                        (context, url, uri) =>
                                            errorWidgetView().paddingAll(8.px),
                                  ),
                        ),
                      ),
                      AppText(
                        title,
                        fontSize: 20.px,
                        fontFamily: FontFamily.helveticaBold,
                        color: AppColors().darkAndWhite,
                      ),
                    ],
                  ),
                  Image.asset(imagePath, height: 30.h),
                  SizedBox(height: 10.px),
                  AppText(
                    subTitle,
                    fontSize: 20.px,
                    textAlign: TextAlign.center,
                    fontFamily: FontFamily.helveticaBold,
                    color: AppColors().darkAndWhite,
                  ),
                  SizedBox(height: 10.px),
                ],
              ),
          if (modelList.isNotEmpty)
            Container(
              padding: EdgeInsets.all(12.px),
              margin: EdgeInsets.only(bottom: 24.px),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.px),
                color: AppColors.primary.changeOpacity(.05),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: modelList.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  RxCommonModel obj = modelList[index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        obj.image,
                        height: 24.px,
                        color: AppColors.primary,
                      ).marginOnly(right: 12.px),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AppText(
                              obj.title,
                              fontSize: 14.px,
                              fontFamily: FontFamily.helveticaBold,
                              textAlign: TextAlign.start,
                              color: AppColors().darkAndWhite,
                            ),
                            AppText(
                              obj.subTitle,
                              fontSize: 14.px,
                              textAlign: TextAlign.start,
                              color: AppColors().darkAndWhite.changeOpacity(.7),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).marginOnly(
                    bottom: index + 1 != uploadAndAsk.length ? 32.px : 0,
                  );
                },
              ),
            ),
          CommonButton(
            onTap: onTap,
            textSize: 14.px,
            textColor: AppColors.white,
            textWeight: FontWeight.w700,
            title: buttonName ?? Languages.of(Get.context!)!.letsGo,
          ).marginOnly(bottom: 20),
        ],
      ).marginSymmetric(horizontal: 16.px),
    );
  }

  getPlanDetailAPI({bool? isLoading}) async {
    try {
      if (isLoading ?? true) Loading.show();

      FormData formData = FormData.fromMap({
        'user_id': getStorageData.readString(getStorageData.userId),
      });
      final data = await APIFunction().apiCall(
        apiName: Constants.getPlanDetail,
        headers: {"deviceType": Platform.operatingSystem},
        params: formData,
        isLoading: false,
      );
      GetPlanDetailModel model = GetPlanDetailModel.fromJson(data);
      if (model.responseCode == 1) {
        purchaseList = model.data?.plans ?? [];
        Set<String> allIds = {
          for (Plans plan in purchaseList) (plan.productId ?? ""),
          for (Plans plan in purchaseList) (plan.freeTrialProductId ?? ""),
        };
        allIds.remove("");
        Set<String> subscriptionIds = allIds;
        final ProductDetailsResponse response = await InAppPurchase.instance
            .queryProductDetails(subscriptionIds);
        List<ProductDetails> products = response.productDetails;
        for (int i = 0; i < response.productDetails.length; i++) {
          printAction(
            "response.productDetails[i].title.trim() ${response.productDetails[i].id.trim()}",
          );
          printAction("products[i] ${products[i].title}");
          printAction("products[i] ${products[i].price}");
          printAction("products[i] ${products[i].description}");
          printAction("products[i] ${products[i].currencySymbol}");
          printAction("products[i] ${products[i].rawPrice}");
          for (Plans item in purchaseList) {
            if (item.productId == response.productDetails[i].id.trim()) {
              item.price = response.productDetails[i].price.trim();
              printAction("item.priceitem.price ${item.price}");
            }
          }
        }
        Get.put(ChatGptController()).update();
        Loading.dismiss();
      } else {
        Loading.dismiss();
      }
    } catch (e) {
      Loading.dismiss();
    }
  }

  creditBottomSheet() async {
    if (purchaseList.isEmpty) {
      await getPlanDetailAPI();
    }
    CommonShowModelBottomSheet(
      child: Column(
        children: [
          AppText(
            Languages.of(Get.context!)!.yourDailyFreeCredits,
            fontSize: 16.px,
            fontFamily: FontFamily.helveticaBold,
          ).marginOnly(bottom: 16.px),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(15.px),
                  decoration: BoxDecoration(
                    color:
                        Global.isSubscription.value == "1"
                            ? const Color(0xff3BDBD4)
                            : Global.chatLimit.value > 0
                            ? AppColors().darkAndWhite
                            : AppColors().darkAndWhite.changeOpacity(0.5),
                    borderRadius: BorderRadius.circular(20.px),
                  ),
                  child: Container(
                    height: 25.px,
                    width: 25.px,
                    decoration: BoxDecoration(
                      color: AppColors().backgroundColor1,
                      borderRadius: BorderRadius.circular(5.px),
                    ),
                  ),
                ),
                SizedBox(width: 10.px),
                Container(
                  padding: EdgeInsets.all(15.px),
                  decoration: BoxDecoration(
                    color:
                        Global.isSubscription.value == "1"
                            ? const Color(0xff3BDBD4)
                            : Global.chatLimit.value > 1
                            ? AppColors().darkAndWhite
                            : AppColors().darkAndWhite.changeOpacity(0.5),
                    borderRadius: BorderRadius.circular(20.px),
                  ),
                  child: Container(
                    height: 25.px,
                    width: 25.px,
                    decoration: BoxDecoration(
                      color: AppColors().backgroundColor1,
                      borderRadius: BorderRadius.circular(5.px),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.px),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(15.px),
                  decoration: BoxDecoration(
                    color:
                        Global.isSubscription.value == "1"
                            ? const Color(0xff3BDBD4)
                            : Global.chatLimit.value > 2
                            ? AppColors().darkAndWhite
                            : AppColors().darkAndWhite.changeOpacity(0.5),
                    borderRadius: BorderRadius.circular(20.px),
                  ),
                  child: Container(
                    height: 25.px,
                    width: 25.px,
                    decoration: BoxDecoration(
                      color: AppColors().backgroundColor1,
                      borderRadius: BorderRadius.circular(5.px),
                    ),
                  ),
                ),
                SizedBox(width: 10.px),
                Container(
                  padding: EdgeInsets.all(15.px),
                  decoration: BoxDecoration(
                    color:
                        Global.isSubscription.value == "1"
                            ? const Color(0xff3BDBD4)
                            : Global.chatLimit.value > 3
                            ? AppColors().darkAndWhite
                            : AppColors().darkAndWhite.changeOpacity(0.5),
                    borderRadius: BorderRadius.circular(20.px),
                  ),
                  child: Container(
                    height: 25.px,
                    width: 25.px,
                    decoration: BoxDecoration(
                      color: AppColors().backgroundColor1,
                      borderRadius: BorderRadius.circular(5.px),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.px),
          Container(
            margin: EdgeInsets.only(bottom: 20.px),
            padding: EdgeInsets.symmetric(vertical: 16.px),
            decoration: BoxDecoration(
              color: AppColors().bgColor3,
              borderRadius: BorderRadius.circular(80.px),
              border: Border.all(color: AppColors.black.changeOpacity(.04)),
            ),
            child: Center(
              child: Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${Languages.of(Get.context!)?.youHave} ",
                      style: TextStyle(
                        fontSize: 16.px,
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.helveticaRegular,
                        color: AppColors().darkAndWhite,
                      ),
                    ),
                    TextSpan(
                      text:
                          Global.isSubscription.value == "0"
                              ? Global.chatLimit.value.toString()
                              : Languages.of(Get.context!)!.pro,
                      style: TextStyle(
                        color: AppColors().darkAndWhite,
                        fontSize: 16.px,
                        fontWeight: FontWeight.w700,
                        fontFamily: FontFamily.helveticaRegular,
                      ),
                    ),
                    TextSpan(
                      text: " ${Languages.of(Get.context!)?.creditLeft}",
                      style: TextStyle(
                        fontSize: 16.px,
                        fontWeight: FontWeight.w500,
                        fontFamily: FontFamily.helveticaRegular,
                        color: AppColors().darkAndWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(
                  text: "${Languages.of(Get.context!)?.upgradeToAICHATSY}",
                  style: TextStyle(
                    fontSize: 16.px,
                    fontWeight: FontWeight.w500,
                    fontFamily: FontFamily.helveticaRegular,
                    color: AppColors().darkAndWhite,
                  ),
                ),
                TextSpan(
                  text: Languages.of(Get.context!)!.pro.toUpperCase(),
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 16.px,
                    fontWeight: FontWeight.w600,
                    fontFamily: FontFamily.helveticaRegular,
                  ),
                ),
              ],
            ),
          ).marginOnly(bottom: 4),
          AppText(
            Languages.of(Get.context!)!.getUnlimitedAccessToAllFeatures,
            fontSize: 12.px,
            fontFamily: FontFamily.helveticaBold,
            color: AppColors.tebBartTextColor,
          ).marginOnly(bottom: 12),
          ListView.separated(
            shrinkWrap: true,
            itemCount: purchaseList.length,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              Plans data = purchaseList[index];

              return SizedBox(height: (data.isActive == "1") ? 10.px : 0);
            },
            itemBuilder: (context, index) {
              Plans data = purchaseList[index];
              return GestureDetector(
                onTap: () {
                  HapticFeedback.mediumImpact();
                  selectedPlan.value = index;
                },
                child:
                    (data.isActive == "1")
                        ? Obx(() {
                          return Container(
                            padding: EdgeInsets.all(10.px),
                            decoration: BoxDecoration(
                              color:
                                  (selectedPlan.value == index)
                                      ? AppColors.lightImageColor.changeOpacity(
                                        0.1,
                                      )
                                      : AppColors.transparent,
                              borderRadius: BorderRadius.circular(10.px),
                              border: Border.all(
                                color:
                                    (selectedPlan.value == index)
                                        ? AppColors.lightImageColor
                                        : AppColors().darkAndWhite
                                            .changeOpacity(0.4),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppText(
                                        data.planName ?? "",
                                        fontSize: 12.px,
                                        color: AppColors().darkAndWhite
                                            .changeOpacity(0.6),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          AppText(
                                            fontSize: 20.px,
                                            data.price ?? "",
                                            fontFamily:
                                                FontFamily.helveticaBold,
                                            color: AppColors().darkAndWhite,
                                          ).marginOnly(right: 8.px),
                                          AppText(
                                            fontSize: 10.px,
                                            data.planDesc ?? "",
                                            color: AppColors().darkAndWhite
                                                .changeOpacity(0.6),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 23.px,
                                  height: 23.px,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(6.px),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:
                                        (selectedPlan.value == index)
                                            ? AppColors.primary
                                            : AppColors.black.changeOpacity(
                                              .05,
                                            ),
                                    border: Border.all(
                                      color:
                                          (selectedPlan.value == index)
                                              ? AppColors.lightImageColor
                                              : AppColors().darkAndWhite
                                                  .changeOpacity(0.4),
                                    ),
                                  ),
                                  child: Image.asset(
                                    ImagePath.check,
                                    color:
                                        (selectedPlan.value == index)
                                            ? AppColors.white
                                            : Colors.transparent,
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                        : SizedBox(),
              );
            },
          ).marginOnly(bottom: 20.px),
          CommonButton(
            onTap: () {
              Get.back();
              Get.delete<PurchaseController>();

              goToPurchasePage(
                arguments: {
                  "plan_id": purchaseList[selectedPlan.value].productId,
                },
              );
            },
            textSize: 14.px,
            textColor: Colors.white,
            title: Languages.of(Get.context!)!.subscribe,
          ),
        ],
      ).marginSymmetric(
        horizontal: 16.px,
        vertical: (IphoneHasNotch.hasNotch) ? 30.px : 20.px,
      ),
    );
  }

  void goToOfferPage() {
    if (Global.offerType != null) {
      if (Global.offerType == Constants.offer25) {
        SpecialOfferScreenView.route()?.then((value) {
          if (value == "plan_purchase") {
            Get.put(
              BottomNavigationController(),
            ).getUserProfileAPI(isLoading: true);
          }
        });
      } else if (Global.offerType == Constants.offer35) {
        OfferScreenView.route()?.then((value) {
          if (value == "plan_purchase") {
            Get.put(
              BottomNavigationController(),
            ).getUserProfileAPI(isLoading: true);
          }
        });
      }
      Global.offerType = null;
    }
  }

  void goToPurchasePage({dynamic arguments}) {
    Get.delete<PurchaseController>();
    PurchaseView.route(arguments: arguments)?.then((value) async {
      goToOfferPage();

      if (value != null && value == "plan_purchase") {
        if (Get.isRegistered<BottomNavigationController>()) {
          await Get.find<BottomNavigationController>().getUserProfileAPI();
        }
        if (Get.isRegistered<UserProfileController>()) {
          Get.find<UserProfileController>().update();
        }
      }
    });
  }

  uploadAndAskCommon(ToolsModel model) {
    if (Global.isSubscription.value != "1" && model.isPremium == "1") {
      // creditBottomSheet();

      goToPurchasePage();
      return;
    }

    String size = "0.0";
    RxBool isShowClear = false.obs;
    textEditController.text = Languages.of(Get.context!)!.documentUpload;
    isSend.value = false;
    isProcess.value = false;
    commonToolsBottomSheet(
      placeholder: '',
      type: Constants.document,
      title: Languages.of(Get.context!)?.summarizeYourDocument ?? "",
      sunTitle: Languages.of(Get.context!)!.summarizeYourDocumentDesc,
      btnText: Languages.of(Get.context!)!.documentUpload,
      onTap: () async {
        HapticFeedback.mediumImpact();
        utils.hideKeyboard();
        if (fileName.isNotEmpty) {
          if (fileName.isNotEmpty) {
            if (!utils.isValidationEmpty(question.value)) {
              Get.back();
              Get.delete<SummarizeDocumentController>();

              Get.toNamed(
                Routes.SUMMARIZE_DOCUMENT,
                arguments: {
                  "upload": question.value,
                  "file_name": fileName.value,
                  "sizeInMb": size,
                  "toolModel": model,
                },
              );
              question.value = "";
              fileName.value = "";
            } else {
              utils.showToast(
                message: Languages.of(Get.context!)!.pleaseUploadFile,
              );
            }
          } else {
            utils.showToast(
              message: Languages.of(Get.context!)!.pleaseEnterValidQuestion,
            );
          }
        } else {
          utils.showToast(
            message: Languages.of(Get.context!)!.pleaseUploadFile,
          );
        }
      },
      child: ListView(
        shrinkWrap: true,
        children: [
          Obx(
            () => CommonTextFiledBottomSheet(
              onTap: () async {
                HapticFeedback.mediumImpact();
                isProcess.value = true;

                Map? map = await filePicker();
                isProcess.value = false;

                if (map != null && map.isNotEmpty) {
                  question.value = map['question'];
                  fileName.value = map['fileName'];
                  size = map['sizeInMb'];
                  isShowClear.value = true;

                  isSend.value = true;
                  textEditController.text =
                      fileName.value.isNotEmpty
                          ? fileName.value
                          : Languages.of(Get.context!)!.uploadFile;
                } else {
                  isSend.value = false;
                }
                isProcess.value = false;
              },
              onChanged: (val) {
                isSend.value = false;
                isProcess.value = false;
              },
              suffixIcon:
                  isShowClear.value
                      ? GestureDetector(
                        onTap: () {
                          textEditController.clear();
                          isShowClear.value = false;
                          isSend.value = false;
                          isProcess.value = false;
                          question.value = "";
                          fileName.value = "";
                          textEditController.text =
                              Languages.of(Get.context!)!.documentUpload;
                        },
                        child: SvgPicture.asset(
                          ImagePath.icCloseBlue,
                        ).marginOnly(right: 6.px, left: 5),
                      )
                      : Image.asset(
                        width: 15.px,
                        height: 15.px,
                        ImagePath.pdfUpload,
                        color: AppColors().darkAndWhite,
                      ).marginOnly(right: 10.px, left: 5),
              controller: textEditController,
              maxLine: 1,
              readOnly: true,
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10.px, right: 10.px),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.px)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.px),
                    child: CachedNetworkImage(
                      imageUrl:
                          isShowClear.value
                              ? model.logo ?? ""
                              : model.defaultLogo ?? "",
                      width: 18.px,
                      height: 18.px,
                      progressIndicatorBuilder:
                          (context, url, progress) =>
                              progressIndicatorView(borderRadius: 5.px),
                      errorWidget:
                          (context, url, uri) =>
                              errorWidgetView().paddingAll(8.px),
                    ),
                  ),
                ),
              ),
              bottomLeft: url.value == "" ? 10.px : 0.px,
              bottomRight: url.value == "" ? 10.px : 0.px,
            ),
          ),
        ],
      ),
    );
  }

  RxString fileName = "".obs;

  String imagePath = "";

  cleanFile() {
    question.value = "";
    fileName.value = "";
  }

  Future<bool> isCorrectWebsite(String url, RxBool isProcess) async {
    bool isCorrect = false;

    printAction(
      "--------sksmk--???-----${url.contains("https://") ? url : "https://$url"}",
    );
    try {
      final response = await http.get(
        Uri.parse(url.contains("https://") ? url : "https://$url"),
      );
      if (response.statusCode == 200) {
        isCorrect = true;
      } else {
        isProcess.value = false;
        isCorrect = false;
      }
    } catch (e) {
      isProcess.value = false;

      isCorrect = false;
    }
    return isCorrect;
  }
}

filePicker({FileType? type}) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: false,
    type: type ?? FileType.any,
  );

  if (result != null) {
    final f = File("${result.paths[0]}");

    int sizeInBytes = f.lengthSync();
    double sizeInMb = sizeInBytes / (1024 * 1024);
    String? question;
    if (result.files.first.extension == "docx") {
      final file = File('${result.paths[0]}');
      final bytes = await file.readAsBytes();
      question = docxToText(bytes, handleNumbering: false);
    } else if (result.files.first.extension == "txt") {
      try {
        question = await readTextFromFile(result.paths[0]!);
      } catch (e) {
        throw (e.toString());
      }
    } else if (result.files.first.extension == "pdf") {
      try {
        if (sizeInMb > 10) {
          utils.showToast(message: "it must be 10.0 MB max.");
          return;
        } else {
          question = await getPDFText(result.paths[0]!);
        }
      } catch (e) {
        throw (e.toString());
      }
    }

    String formattedValue =
        (sizeInMb.toString().length > 5)
            ? sizeInMb.toString().substring(
              0,
              sizeInMb.toString().indexOf('.') + 4,
            )
            : sizeInMb.toString();
    return {
      "question": question,
      "fileName": result.names.first!,
      "sizeInMb": formattedValue,
    };
  } else {
    // Utils().showToast(message: "Document file are corrupted");
  }
}

Future<String> readTextFromFile(String filePath) async {
  try {
    final file = File(filePath);
    if (await file.exists()) {
      final text = await file.readAsString();
      return text;
    } else {
      EasyLoading.dismiss();
      return 'File does not exist';
    }
  } catch (e) {
    EasyLoading.dismiss();
    return 'Error reading file: $e';
  }
}

Future<String> getPDFText(String path) async {
  String text = "";
  try {
    text = await ReadPdfText.getPDFtext(path);
  } on PlatformException {}
  return text;
}

// Future<String> getPDFText(String path) async {
//   String text = "";
//
//   try {
//     PDFDoc? pdfDoc = await PDFDoc.fromPath(path);
//
//     if (pdfDoc.length > 0) {
//       text = await pdfDoc.text;
//       if (kDebugMode) {
//         printAction("test_text: $text");
//       }
//       return text;
//     } else {
//       return text;
//     }
//   } on PlatformException {
//     printError("Image pdf No text could be extracted from this file.");
//   }
//   return text;
// }

// Future<String> getPDFText(String path) async {
//   try {
//     //Load an existing PDF document.
//     PdfDocument document = PdfDocument(inputBytes: await File(path).readAsBytes());
//
// //Create a new instance of the PdfTextExtractor.
//     PdfTextExtractor extractor = PdfTextExtractor(document);
//
// //Extract all the text from the document.
//     String text = extractor.extractText();
//
//     return text;
//   } on PlatformException {
//     debugPrint("Image pdf No text could be extracted from this file.");
//     return "";
//   }
// }
