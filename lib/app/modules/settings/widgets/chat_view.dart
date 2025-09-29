import 'package:chatsy/app/modules/chat_gpt/views/chat_gpt_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../helper/all_imports.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../home/controllers/user_profile_model.dart';

class ChatViewType extends StatefulWidget {
  const ChatViewType({super.key});

  @override
  State<ChatViewType> createState() => _ChatViewTypeState();
}

class _ChatViewTypeState extends State<ChatViewType> {
  BottomNavigationController get bottomNavigationController =>
      Get.find<BottomNavigationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Rx<ToolsModel?> data;

      if (bottomNavigationController.selectAiModelList.isEmpty) {
        data = null.obs;
      } else {
        int index = 0;

        if ((getStorageData.containKey(getStorageData.selectModelIndex))) {
          index = int.parse(getStorageData.readString(getStorageData.selectModelIndex) ?? "0");
        }

        data = bottomNavigationController.selectAiModelList[index].obs;
      }

      if (data.value == null) {
        return const SizedBox();
      }

      return Padding(
        padding: EdgeInsets.only(right: 10.px, bottom: 5.px, top: 5.px),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.px, vertical: 5.px),
          decoration: const BoxDecoration(
            // color: AppColors().darkAndWhite.changeOpacity(0.05),
            // border: Border.all(color: AppColors().darkAndWhite.changeOpacity(0.4)),
            // borderRadius: BorderRadius.circular(20.px),
          ),
          child: Row(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: data.value?.logo ?? "${Constants.imageBaseUrl}ai_model/chat_gpt.png",
                  height: 20.px,
                  width: 20.px,
                  progressIndicatorBuilder:
                      (context, url, progress) => progressIndicatorView(circle: true),
                  errorWidget: (context, url, uri) => errorWidgetView().paddingAll(8.px),
                ),
              ),
              SizedBox(width: 5.px),
              AppText(data.value?.name ?? "", fontSize: 14.px, color: AppColors().darkAndWhite),
              Icon(Icons.keyboard_arrow_down, color: AppColors().darkAndWhite, size: 18.px),
            ],
          ),
        ),
      );
    });
  }
}
