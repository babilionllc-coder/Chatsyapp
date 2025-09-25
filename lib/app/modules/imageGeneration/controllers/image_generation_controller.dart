import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatsy/extension.dart';
import 'package:chatsy/service/AI%20Chat/ai_chat_service.dart';
import 'package:chatsy/service/core/exception.dart';

import '../../../Localization/local_language.dart';
import '../../../api_repository/api_function.dart';
import '../../../common_widget/common_button.dart';
import '../../../common_widget/common_show_model_bottom_sheet.dart';
import '../../../common_widget/error_and_update_dialog.dart';
import '../../../helper/Global.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/font_family.dart';
import '../../../helper/image_path.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../home/controllers/user_profile_model.dart';
import '../../newChat/controllers/new_chat_controller.dart';
import '../../newChat/models/phm_id_model.dart';
import '../model/image_style_model.dart';

class ImageGenerationController extends GetxController {
  final apiState = ApiState.initial<PhmIdModel>().obs;
  CancelToken? cancelToken;

  RxString selectSizeIndex = "1024x1024".obs;
  RxString selectRatio = "1:1".obs;
  RxString selectStyle = "None".obs;

  RxList<PhmIdModelData> askQuestionData = <PhmIdModelData>[].obs;
  ToolsModel? toolModel;
  TextEditingController newChatController = TextEditingController();
  FocusNode newChatFocusNode = FocusNode();

  var menu = false.obs;

  ScrollController scrollController = ScrollController();
  final count = 0.obs;
  var imgList = [
    'https://tinyurl.com/2p9a25er',
    'https://tinyurl.com/4h75eyr4',
    'https://tinyurl.com/asbc7n9d',
    'https://tinyurl.com/2p9a25er',
    'https://tinyurl.com/4h75eyr4',
    'https://tinyurl.com/asbc7n9d',
  ];

  RxList<StyleList> styleList = <StyleList>[].obs;

  // RxList<RxCommonModel> styleList = <RxCommonModel>[
  //   RxCommonModel(title: "None", isSelected: true, image: ""),
  //   RxCommonModel(title: "Isometric Art", isSelected: false, image: "https://i.postimg.cc/ryDVvhS6/Rectangle-18081-1.png"),
  //   RxCommonModel(title: "Photolike", isSelected: false, image: "https://i.postimg.cc/SR2vDY25/Rectangle-18081-2.png"),
  //   RxCommonModel(title: "Cyberpunk", isSelected: false, image: "https://i.postimg.cc/d3bSXQG0/Rectangle-18081-3.png"),
  //   RxCommonModel(title: "Anime", isSelected: false, image: "https://i.postimg.cc/d1Sf2j1r/Rectangle-18081-4.png"),
  //   RxCommonModel(title: "Low Poly", isSelected: false, image: "https://i.postimg.cc/3Rw60cK3/Rectangle-18081-5.png"),
  //   RxCommonModel(title: "Comic Book", isSelected: false, image: "https://i.postimg.cc/HLdFdLRc/Rectangle-18081-6.png"),
  //   RxCommonModel(title: "Modelling  Clay", isSelected: false, image: "https://i.postimg.cc/3w1VRTQL/Rectangle-18081-7.png"),
  //   RxCommonModel(title: "Retro", isSelected: false, image: "https://i.postimg.cc/52wDhz7W/Rectangle-18081-8.png"),
  //   RxCommonModel(title: "Line Art", isSelected: false, image: "https://i.postimg.cc/kgrkYsyy/Rectangle-18081-9.png"),
  //   RxCommonModel(title: "Digital Art", isSelected: false, image: "https://i.postimg.cc/8Pf2b9L5/Rectangle-18081-10.png"),
  //   RxCommonModel(title: "Pixel Art", isSelected: false, image: "https://i.postimg.cc/QtxLkMqG/Rectangle-18081-11.png"),
  //   RxCommonModel(title: "Fantasy", isSelected: false, image: "https://i.postimg.cc/zv69rFY8/Rectangle-18081-12.png"),
  //   RxCommonModel(title: "Tile Texture", isSelected: false, image: "https://i.postimg.cc/nVW8Bpjg/Rectangle-18081-13.png"),
  //   RxCommonModel(title: "Movielike", isSelected: false, image: "https://i.postimg.cc/rsKv3Ybf/Rectangle-18081-14.png"),
  //   RxCommonModel(title: "3D", isSelected: false, image: "https://i.postimg.cc/TPcMDbgJ/Rectangle-18081-15.png"),
  //   RxCommonModel(title: "Origami", isSelected: false, image: "https://i.postimg.cc/mr4Wkjzr/Rectangle-18081-16.png"),
  // ].obs;

  RxInt mainListIndex = 0.obs;
  RxList<CategoryCardSub> promptList = <CategoryCardSub>[].obs;
  List<CategoryCard> mainList = [
    CategoryCard(
      image: ImagePath.icNature,
      title: "Nature",
      items: [
        CategoryCardSub(
          title: "Rainforest wildlife",
          backendName:
              "Generate an image of a lush rainforest filled with vibrant plants, tropical birds, and a cascading waterfall, with mist rising and sunlight filtering through the canopy.",
        ),
        CategoryCardSub(
          title: "Mountain sunrise",
          backendName:
              "Create an image of a peaceful mountain range during sunrise, with orange and pink hues lighting up the sky, mist in the valleys, and a crystal-clear lake reflecting the mountains.",
        ),
        CategoryCardSub(
          title: "Ocean view",
          backendName:
              "Design an image of a tranquil ocean at sunset, with gentle waves washing onto the shore, a few seagulls flying overhead, and distant islands silhouetted against a colorful sky.",
        ),
        CategoryCardSub(
          title: "Desert dunes",
          backendName:
              "Generate an image of vast desert dunes with golden sand stretching as far as the eye can see, the sun setting on the horizon, and a lone camel walking through the scene.",
        ),
        CategoryCardSub(
          title: "Tropical beach",
          backendName:
              "Create an image of a tropical beach with turquoise waters, palm trees swaying in the breeze, and colorful beach umbrellas dotting the white sand.",
        ),
      ],
    ),
    CategoryCard(
      image: ImagePath.icFantasy,
      title: "Fantasy",
      items: [
        CategoryCardSub(
          title: "Dragon in flight",
          backendName:
              "Create an image of a majestic dragon soaring through the sky above a medieval castle, with fire streaming from its mouth and knights watching from the castle walls below.",
        ),
        CategoryCardSub(
          title: "Enchanted forest",
          backendName:
              "Generate an image of a mystical forest filled with glowing trees, magical creatures, and a shimmering river running through the middle, all bathed in soft moonlight.",
        ),
        CategoryCardSub(
          title: "Castle on a hill",
          backendName:
              "Design an image of a towering medieval castle perched on a hill, with dark clouds swirling overhead and a storm brewing in the distance, creating a dramatic atmosphere.",
        ),
        CategoryCardSub(
          title: "Fairy village",
          backendName:
              "Generate an image of a tiny fairy village hidden in the woods, with mushroom houses, glowing lanterns, and fairies flying around a central tree, casting a magical glow.",
        ),
        CategoryCardSub(
          title: "Wizard's tower",
          backendName:
              "Create an image of an ancient wizard's tower standing on a cliff, with lightning crackling in the sky, arcane symbols glowing on the tower's surface, and a mysterious figure gazing out from the balcony.",
        ),
      ],
    ),
    CategoryCard(
      image: ImagePath.icHistorical,
      title: "Historical",
      items: [
        CategoryCardSub(
          title: "Ancient Egypt",
          backendName:
              "Generate an image of the Great Pyramids of Giza under the bright sun, with camels and people walking in the foreground, capturing the essence of ancient Egypt.",
        ),
        CategoryCardSub(
          title: "Medieval village",
          backendName:
              "Create an image of a small medieval village with thatched-roof houses, cobblestone streets, villagers going about their daily work, and a castle in the background.",
        ),
        CategoryCardSub(
          title: "Roman Coliseum",
          backendName:
              "Design an image of the Roman Coliseum during a gladiator match, with a roaring crowd, sunlight streaming through the arches, and gladiators battling in the arena.",
        ),
        CategoryCardSub(
          title: "Victorian London",
          backendName:
              "Generate an image of Victorian-era London, with cobblestone streets, horse-drawn carriages, gas streetlights, and people in period clothing walking through the misty evening.",
        ),
        CategoryCardSub(
          title: "Ancient Greece",
          backendName:
              "Create an image of the Parthenon on top of the Acropolis in ancient Greece, with philosophers and citizens gathered around, discussing ideas and admiring the grand architecture.",
        ),
      ],
    ),
    CategoryCard(
      image: ImagePath.icAnimals,
      title: "Animals",
      items: [
        CategoryCardSub(
          title: "Lion in savanna",
          backendName:
              "Generate an image of a powerful lion standing majestically in the African savanna, with tall golden grass swaying in the breeze and a vibrant sunset in the background.",
        ),
        CategoryCardSub(
          title: "Pandas eating bamboo",
          backendName:
              "Create a peaceful image of a group of pandas sitting among bamboo trees, lazily munching on bamboo leaves, with soft sunlight filtering through the greenery.",
        ),
        CategoryCardSub(
          title: "Underwater shark",
          backendName:
              "Design an intense underwater scene featuring a great white shark swimming through the deep blue ocean, with rays of light breaking through the surface and smaller fish scattering around.",
        ),
        CategoryCardSub(
          title: "Butterflies in meadow",
          backendName:
              "Generate an image of a vibrant meadow filled with colorful wildflowers and hundreds of butterflies flying gracefully, with the bright blue sky above and soft sunlight enhancing the scene.",
        ),
        CategoryCardSub(
          title: "Snowy owl",
          backendName:
              "Create a serene image of a snowy owl perched on a tree branch in a wintery forest, with snow gently falling and the owl’s feathers blending into the white surroundings.",
        ),
      ],
    ),
    CategoryCard(
      image: ImagePath.icArchitecture,
      title: "Architecture",
      items: [
        CategoryCardSub(
          title: "Modern skyscraper",
          backendName:
              "Generate an image of a futuristic, sleek skyscraper towering above a city, with reflective glass panels, innovative design, and drones flying around the building in a bustling metropolis.",
        ),
        CategoryCardSub(
          title: "Ancient temple",
          backendName:
              "Create an image of an ancient stone temple hidden in a jungle, with overgrown vines crawling up its walls, faded carvings on the structure, and beams of light piercing through the canopy.",
        ),
        CategoryCardSub(
          title: "Futuristic house",
          backendName:
              "Design an image of a minimalist futuristic house set in a green landscape, with large windows, solar panels on the roof, and a clean, modern aesthetic surrounded by trees.",
        ),
        CategoryCardSub(
          title: "Medieval castle",
          backendName:
              "Generate an image of a grand medieval castle with tall towers, thick stone walls, a moat surrounding it, and a drawbridge leading to the entrance, with banners flying in the wind.",
        ),
        CategoryCardSub(
          title: "Greek ruins",
          backendName:
              "Create an image of ancient Greek ruins, with tall marble columns still standing, cracked statues, and wildflowers growing between the stones, all bathed in the soft light of dusk.",
        ),
      ],
    ),
  ];

  promptListUpdate(int index) {
    mainListIndex.value = index;
    promptList.value = mainList[index].items;
  }

  List<SizeModel> sizeList = [
    SizeModel(
      ratio: "1:1",
      size: "1024x1024",
      image: ImagePath.instagram2,
      height: 16.px,
      width: 16.px,
    ),
    SizeModel(
      ratio: "7:4",
      size: "1792x1024",
      image: ImagePath.instagram2,
      height: 12.px,
      width: 16.px,
    ),
    SizeModel(
      ratio: "4:7",
      size: "1024x1792",
      image: ImagePath.instagram2,
      height: 16.px,
      width: 12.px,
    ),
  ];

  imageFilter() {
    CommonShowModelBottomSheet(
      child: Container(
        // constraints: BoxConstraints(maxHeight: 80.h),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20.px),
              AppText(
                Languages.of(Get.context!)!.selectSize,
                fontSize: 14,
                fontFamily: FontFamily.helveticaBold,
              ),
              SizedBox(height: 5.px),
              GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: sizeList.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisExtent: 32,
                  crossAxisSpacing: 7.px,
                  mainAxisSpacing: 7.px,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Obx(() {
                    return GestureDetector(
                      onTap: () {
                        selectSizeIndex.value = sizeList[index].size;
                        selectRatio.value = sizeList[index].ratio;
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                (selectSizeIndex.value == sizeList[index].size)
                                    ? AppColors.primary
                                    : AppColors.question1,
                          ),
                          color:
                              (selectSizeIndex.value == sizeList[index].size)
                                  ? AppColors.primary.changeOpacity(0.1)
                                  : AppColors.question1,
                          borderRadius: BorderRadius.circular(10.px),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      (selectSizeIndex.value == sizeList[index].size)
                                          ? AppColors.primary
                                          : AppColors.gray,
                                  width: 2.px,
                                ),
                                color:
                                    (selectSizeIndex.value == sizeList[index].size)
                                        ? AppColors.primary.changeOpacity(0.1)
                                        : AppColors.transparent,
                                borderRadius: BorderRadius.circular(2.px),
                              ),
                              height: sizeList[index].height,
                              width: sizeList[index].width,
                            ).marginOnly(right: 8.px),
                            AppText(
                              sizeList[index].ratio,
                              fontSize: 12.px,
                              color:
                                  (selectSizeIndex.value == sizeList[index].size)
                                      ? AppColors().darkAndWhite
                                      : AppColors.black,
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                },
              ),
              SizedBox(height: 24.px),
              AppText(
                Languages.of(Get.context!)!.selectStyle,
                fontSize: 14,
                fontFamily: FontFamily.helveticaBold,
              ).marginOnly(bottom: 12.px),
              Obx(
                () => GridView.builder(
                  shrinkWrap: true,
                  itemCount: styleList.length,
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 4.px,
                    mainAxisSpacing: 4.px,
                    childAspectRatio: Get.mediaQuery.size.width / 500,
                  ),
                  itemBuilder: (context, index) {
                    StyleList obj = styleList[index];
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            for (var element in styleList) {
                              element.isSelected = "0";
                            }
                            obj.isSelected = "1";
                            selectStyle.value = obj.title ?? "None";
                            askQuestionData.refresh();
                            styleList.refresh();
                          },
                          child: Container(
                            // width: 100.px,
                            // height: 100.px,
                            // margin: EdgeInsets.only(bottom: 8.px),
                            padding: EdgeInsets.all(4.px),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.px),
                              border: Border.all(
                                color:
                                    obj.isSelected == "1" ? AppColors.primary : Colors.transparent,
                              ),
                            ),
                            child:
                                obj.image.isNotEmpty
                                    ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10.px),
                                      child: CachedNetworkImage(
                                        imageUrl: obj.image,
                                        // errorWidget: (context, url, uri) => const Center(child: Icon(Icons.error_outline_rounded, color: Colors.red)),
                                        errorWidget:
                                            (context, url, uri) => Container(
                                              color: AppColors.grey1.changeOpacity(0.2),
                                              height: 76.px,
                                              width: double.infinity,
                                              child: Icon(
                                                Icons.not_interested,
                                                color: AppColors.grey2,
                                              ),
                                            ),
                                        placeholder:
                                            (context, url) => SizedBox(
                                              height: 67.px,
                                              child: const Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            ),
                                      ),
                                    )
                                    : Container(
                                      height: 76.px,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: AppColors.grey1.changeOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10.px),
                                      ),
                                      child: Icon(Icons.not_interested, color: AppColors.grey2),
                                    ),
                          ),
                        ),
                        AppText(
                          obj.title,
                          fontSize: 12.px,
                          fontFamily: FontFamily.helveticaBold,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    );
                  },
                ),
              ),
              CommonButton(
                onTap: () {
                  Get.back();
                  Utils().showCustomToast(message: "${selectStyle.value}  ${selectRatio.value}");
                  Utils().hideKeyboard();
                },
                textSize: 14.px,
                textColor: Colors.white,
                title: "Apply",
              ).marginOnly(bottom: 10.px, left: 20.px, right: 20.px, top: 5.px),
            ],
          ).paddingSymmetric(horizontal: 20.px),
        ),
      ),
    );
  }

  @override
  void onInit() {
    getImageStyle();
    getStorageData.saveSend(value: false);
    getStorageData.saveListening(value: false);
    promptListUpdate(0);

    if (Get.arguments != null && Get.arguments.containsKey("toolModel")) {
      toolModel = Get.arguments["toolModel"];
    }
    if (Get.arguments != null && Get.arguments.containsKey(HttpUtil.chatItemList)) {
      askQuestionData.value = Get.arguments[HttpUtil.chatItemList];
    }
    super.onInit();
  }

  void scrollToEnd() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  clearAllImageDialog() async {
    CommonShowModelBottomSheet(
      child: Column(
        children: [
          Container(
            child: AppText(
              Languages.of(Get.context!)!.clearAll,
              fontFamily: FontFamily.helveticaBold,
              fontSize: 18.px,
            ).marginOnly(top: 15.px, bottom: 10.px),
          ),
          AppText(
            textAlign: TextAlign.center,
            Languages.of(Get.context!)!.areYouSureYouWantToClearAllImage,
          ),
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  verticalPadding: 12.px,
                  buttonColor: AppColors.grey1,
                  onTap: () {
                    Get.back();
                  },
                  textSize: 14.px,
                  textColor: Colors.white,
                  title: Languages.of(Get.context!)!.cancel,
                ),
              ),
              SizedBox(width: 15.px),
              Expanded(
                child: CommonButton(
                  verticalPadding: 12.px,
                  onTap: () {
                    clearImageAIPCall();
                    Get.back();
                  },
                  textSize: 14.px,
                  textColor: Colors.white,
                  title: Languages.of(Get.context!)!.yes,
                ),
              ),
            ],
          ).marginOnly(top: 10.px, left: 15.px, right: 15.px, bottom: 10.px),
        ],
      ),
    );
  }

  getImageStyle() async {
    String uid = getStorageData.readString(getStorageData.userId) ?? "";
    FormData formData = FormData.fromMap({"user_id": uid});
    final data = await APIFunction().apiCall(
      apiName: Constants.getImageFilterList,
      params: formData,
      token: getStorageData.readString(getStorageData.token),
    );

    ImageStyleModel model = ImageStyleModel.fromJson(data);
    if (model.responseCode == 1) {
      if (model.data != null) {
        styleList.value = model.data!;
      }
    } else if (model.responseCode == 0) {
      utils.showToast(message: model.responseMsg!);
    } else if (model.responseCode == 26) {
      updateDialog(model.responseMsg);
    } else {
      utils.showToast(message: model.responseMsg!);
    }
  }

  clearImageAIPCall() async {
    String uid = getStorageData.readString(getStorageData.userId) ?? "";
    FormData formData = FormData.fromMap({"user_id": uid, "phm_id": askQuestionData.last.phmId});
    final data = await APIFunction().apiCall(
      apiName: Constants.clearAllRecentImg,
      params: formData,
      token: getStorageData.readString(getStorageData.token),
    );

    PhmIdModel model = PhmIdModel.fromJson(data);
    if (model.responseCode == 1) {
      utils.showToast(message: model.responseMsg!);
      askQuestionData.clear();
      getStorageData.saveSend(value: false);
      getStorageData.saveListening(value: false);
    } else if (model.responseCode == 0) {
      utils.showToast(message: model.responseMsg!);
    } else if (model.responseCode == 26) {
      updateDialog(model.responseMsg);
    } else {
      utils.showToast(message: model.responseMsg!);
    }
  }

  deleteSingleChatAPI({required String scmId}) async {
    String uid = getStorageData.readString(getStorageData.userId) ?? "";
    printAction("===========scm_id$scmId");
    FormData formData = FormData.fromMap({"user_id": uid, "scm_id": scmId});
    final data = await APIFunction().apiCall(
      apiName: Constants.deleteSingleChat,
      params: formData,
      token: getStorageData.readString(getStorageData.token),
    );

    PhmIdModel model = PhmIdModel.fromJson(data);
    if (model.responseCode == 1) {
      askQuestionData.removeWhere((element) => element.scmId == scmId);

      askQuestionData.refresh();
    } else if (model.responseCode == 0) {
      utils.showToast(message: model.responseMsg!);
    } else if (model.responseCode == 26) {
      updateDialog(model.responseMsg);
    } else {
      utils.showToast(message: model.responseMsg!);
    }
  }

  Future<void> convertTextToImageAPI({required String question, required bool isRegenerate}) async {
    // try {
    if (Global.isSubscription.value != "1" && Global.chatLimit.value < 1) {
      askQuestionData.add(PhmIdModelData(question: question, isUpgraded: true));
      utils.hideKeyboard();
      newChatController.clear();
      scrollToEnd();

      return;
    }

    String? styleName;
    for (var element in styleList) {
      if (element.isSelected == "1") {
        styleName = element.title;
      }
    }

    String uid = getStorageData.readString(getStorageData.userId) ?? "";

    // FormData formData = FormData.fromMap({
    //   "user_id": uid,
    //   "question": question,
    //   "size": selectSizeIndex.value,
    //   if (askQuestionData.isNotEmpty) "phm_id": askQuestionData.last.phmId,
    //   "ai_model":
    //       (Get.put(BottomNavigationController()).selectAiModelList.isEmpty
    //               ? "gpt-3.5-turbo"
    //               : Get.put(BottomNavigationController())
    //                       .selectAiModelList[(getStorageData.containKey(
    //                             getStorageData.selectModelIndex,
    //                           ))
    //                           ? int.parse(
    //                             getStorageData.readString(getStorageData.selectModelIndex) ?? "0",
    //                           )
    //                           : 0]
    //                       .model ??
    //                   "gpt-3.5-turbo")
    //           .toString(),
    //   "title": "Image Generation",
    //   "is_edit": isRegenerate ? "1" : "0",
    //   "filter_type": styleName ?? '',
    // });
    newChatController.clear();
    PhmIdModelData data1 = PhmIdModelData(question: question, img: ImagePath.icImageLoading);
    if (!isRegenerate) {
      askQuestionData.add(data1);
    } else {
      askQuestionData.last = data1;
    }

    askQuestionData.refresh();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Durations.medium4,
        curve: Curves.easeInOut,
      );
    });

    String? aiModel;

    if (Get.find<BottomNavigationController>().selectAiModelList.isNotEmpty) {
      aiModel =
          Get.find<BottomNavigationController>()
              .selectAiModelList[int.tryParse(
                    getStorageData.readString(getStorageData.selectModelIndex) ?? "0",
                  ) ??
                  0]
              .model;
    }

    cancelToken ??= CancelToken();

    AIChatService()
        .imageGeneration(
          title: "Image Generation",
          userId: uid,
          question: question,
          size: selectSizeIndex.value,
          aiModel: aiModel ?? "gpt-5",
          phmId: askQuestionData.isNotEmpty ? askQuestionData.last.phmId : null,
          isEdit: isRegenerate ? "1" : "0",
          filterType: styleName,
          cancelToken: cancelToken,
        )
        .handler(
          apiState,
          isLoading: false,
          onSuccess: (value) {
            if (value.responseCode == 10) {
              askQuestionData.removeLast();
              utils.showToast(message: value.responseMsg!);
            } else if (value.responseCode == 1) {
              updateChatLimit();
              askQuestionData.last = value.data!;
              getStorageData.saveSend(value: false);
              getStorageData.saveListening(value: false);
            } else if (value.responseCode == 0) {
              askQuestionData.removeLast();

              utils.showToast(message: value.responseMsg!);
            } else if (value.responseCode == 26) {
              askQuestionData.removeLast();

              updateDialog(value.responseMsg);
            } else if (value.responseCode == 5) {
              askQuestionData.removeLast();

              Global.isVibrate = true;
              Global.vibrate();

              PhmIdModelData data = PhmIdModelData(question: question, isUpgraded: true);
              askQuestionData.add(data);
            } else {
              askQuestionData.removeLast();

              utils.showToast(message: value.responseMsg!);
            }
            scrollToEnd();
            askQuestionData.refresh();
          },
          onFailed: (value) {
            askQuestionData.removeLast();
          },
        );

    //   final data = await APIFunction().apiCall(
    //     apiName: Constants.imageGeneration,
    //     params: formData,
    //     isLoading: false,
    //     token: getStorageData.readString(getStorageData.token),
    //   );

    //   PhmIdModel model = PhmIdModel.fromJson(data);
    // } catch (e) {
    //   printAction("eeeeeeeeeee $e");

    //   printAction("askQuestionData ${askQuestionData.length}");
    //   askQuestionData.removeLast();
    // }
  }
}

class SizeModel {
  String size;
  String ratio;
  String image;
  double height;
  double width;

  SizeModel({
    required this.size,
    required this.ratio,
    required this.image,
    required this.height,
    required this.width,
  });
}

Widget imageGenerationLoadingImage() {
  return Container(
    width: double.infinity,
    height: Get.size.width / 1.3,
    color: AppColors().darkAndWhite,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          backgroundColor: AppColors().pb,
          color: AppColors().pp,
          strokeWidth: 1,
        ),
        SizedBox(height: 20.px),
        AppText(
          'Image Generation in Progress...',
          color: AppColors().whiteAndDark,
          fontSize: 16.px,
        ),
      ],
    ),
  );
}
