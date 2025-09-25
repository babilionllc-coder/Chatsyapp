import 'package:chatsy/app/helper/font_family.dart';
import 'package:chatsy/extension.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../Localization/local_language.dart';
import '../../../common_widget/comman_text_feild_bottom_sheet.dart';
import '../../../common_widget/common_show_model_bottom_sheet.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/get_storage_data.dart';
import '../../../helper/image_path.dart';
import '../../home/controllers/all_prompt_model.dart';
import '../../newChat/controllers/new_chat_controller.dart';

class TranslateController extends GetxController with WidgetsBindingObserver {
  //TODO: Implement TranslateController
  ScrollController scrollController = ScrollController();
  TextEditingController newChatController = TextEditingController();
  TextEditingController searchLanguageController = TextEditingController();
  FocusNode newChatFocusNode = FocusNode();
  List<Language> languageList = [];
  RxList<Language> searchList = <Language>[].obs;
  RxList<ChatItem> chatItem = <ChatItem>[].obs;

  Rxn<Language> fromLanguage = Rxn<Language>();
  Rxn<Language> toLanguage = Rxn<Language>();

  RxBool isFromLangSelect = true.obs;

  @override
  void onInit() {
    var p = GetStorageData().readObject(GetStorageData().prompts);
    prompts = Prompts.fromJson(p);

    loadLanguagesFromAssets();

    printAction("--------------      ${prompts.toJson()}");

    if (Get.arguments != null) {
      chatItem.value = Get.arguments[HttpUtil.chatItemList];
      WidgetsBinding.instance.addObserver(this);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    }
    super.onInit();
  }

  @override
  void onClose() {
    ChatApi.stopStreaming();
    HttpUtil.cancelRequests();
    modelsHistoryAPI(chatItem, null, prompts.name, promptId: prompts.promptId);

    super.onClose();
  }

  Prompts prompts = Prompts();

  languageSelect() {
    searchLanguageController.clear();
    searchList.value = languageList;
    return CommonShowModelBottomSheet(
      child: Obx(() {
        return Column(
          children: [
            AppText(
              Languages.of(Get.context!)!.setLanguages,
              fontSize: 14.px,
              fontFamily: FontFamily.helveticaBold,
            ).marginOnly(top: 10.px),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // English Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      isFromLangSelect.value = true;
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10.px, 10.px, 10.px, 7.px),
                      decoration: BoxDecoration(
                        color: (isFromLangSelect.value == true) ? AppColors.primary : null,

                        border: Border.all(
                          color:
                              (isFromLangSelect.value == true)
                                  ? AppColors.primary
                                  : AppColors().darkAndWhite.changeOpacity(0.2), // Border color
                          width: 1.px, // Border width
                        ),
                        borderRadius: BorderRadius.circular(30.0), // Rounded corners
                      ),
                      child: AppText(
                        color: (isFromLangSelect.value == true) ? AppColors.white : null,
                        textAlign: TextAlign.center,
                        fromLanguage.value?.name ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14.px,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Language? from = fromLanguage.value;
                    Language? to = toLanguage.value;
                    fromLanguage.value = to;
                    toLanguage.value = from;
                  },
                  child: SvgPicture.asset(
                    ImagePath.icLanguageChange,
                    height: 20.px,
                    width: 20.px,
                    color: AppColors().darkAndWhite,
                  ).marginSymmetric(horizontal: 11.px),
                ),

                // Spanish Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      isFromLangSelect.value = false;
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(10.px, 10.px, 10.px, 7.px),
                      decoration: BoxDecoration(
                        color: (isFromLangSelect.value != true) ? AppColors.primary : null,

                        border: Border.all(
                          color:
                              (isFromLangSelect.value != true)
                                  ? AppColors.primary
                                  : AppColors().darkAndWhite.changeOpacity(0.2), // Border color
                          width: 1.px, // Border width
                        ),
                        borderRadius: BorderRadius.circular(30.0), // Rounded corners
                      ),
                      child: AppText(
                        color: (isFromLangSelect.value != true) ? AppColors.white : null,
                        textAlign: TextAlign.center,
                        toLanguage.value?.name ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14.px,
                      ),
                    ),
                  ),
                ),
              ],
            ).marginOnly(top: 10.px),
            CommonTextFiledBottomSheet(
              textColor: (isLight) ? null : AppColors().whiteAndDark,
              onChanged: (p0) {
                if (p0.isEmpty) {
                  searchList.value = languageList;
                } else {
                  searchList.value =
                      languageList
                          .where(
                            (user) => user.name.toLowerCase().contains(p0.trim().toLowerCase()),
                          )
                          .toList();
                }
                searchList.refresh();
              },
              fillColor: Color(0xFFF9F9F9),
              controller: searchLanguageController,
              maxLine: 1,
              prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10.px, right: 8.px),
                child: SvgPicture.asset(ImagePath.icSearch),
              ),
              hintText: Languages.of(Get.context!)!.search,
            ).marginOnly(top: 10.px),
            (searchList.value.isNotEmpty)
                ? ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: searchList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (isFromLangSelect.value) {
                          fromLanguage.value = searchList[index];
                        } else {
                          toLanguage.value = searchList[index];
                        }
                        Get.back();
                      },
                      child: AppText(
                        searchList[index].name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ).paddingSymmetric(vertical: 5.px),
                    );
                  },
                )
                : AppText(
                  Languages.of(Get.context!)!.languagesNotFound,
                  fontSize: 14.px,
                  fontFamily: FontFamily.helveticaBold,
                ).marginOnly(top: 10.px, bottom: 10.px),
          ],
        );
      }).marginSymmetric(horizontal: 16.px),
    );
  }

  Future<void> loadLanguagesFromAssets() async {
    String jsonString = await rootBundle.loadString('assets/jsons/language.json');
    List<dynamic> jsonResponse = jsonDecode(jsonString);
    languageList = jsonResponse.map((json) => Language.fromJson(json)).toList();

    if (languageList.isNotEmpty && languageList.length > 2) {
      fromLanguage.value = languageList.first;
      toLanguage.value = languageList[1];
    }
  }
}

class Language {
  final String code;
  final String name;

  Language({required this.code, required this.name});

  // Factory constructor to create a Language from JSON
  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(code: json['code'], name: json['name']);
  }
}
