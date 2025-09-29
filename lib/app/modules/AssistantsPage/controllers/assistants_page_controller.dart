import 'package:chatsy/Customs/buttons.dart';
import 'package:chatsy/app/Localization/local_language.dart';
import 'package:chatsy/app/common_widget/custom_image_view.dart';
import 'package:chatsy/app/helper/font_family.dart';
import 'package:chatsy/app/modules/home/controllers/ai_assistants_model.dart';
import 'package:chatsy/gen/assets.gen.dart';
import 'package:chatsy/main.dart';
import 'package:chatsy/service/AI%20Assistant/ai_assistant_service.dart';
import 'package:chatsy/service/core/exception.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:gap/gap.dart';

import '../../../../helper/pagination_helper.dart';
import '../../../helper/all_imports.dart';

class AssistantsPageController extends GetxController with PaginationHelper {
  final easyRefreshController = EasyRefreshController(
    controlFinishRefresh: true,
  );

  @override
  Future<void> onInit() async {
    super.onInit();
    getAssistantData();
  }

  @override
  void dispose() {
    removeListenerAndDispose();
    super.dispose();
  }

  final RxList<AssistantData> assistantList = RxList<AssistantData>();

  Future<void> getAssistantData({bool refresh = false}) async {
    var limit = (MediaQuery.sizeOf(Get.context!).height / 25).floor();
    var length = refresh ? 0 : assistantList.length;

    await AiAssistantService()
        .getAssistantData(
          userId: '${getStorageData.readString(getStorageData.userId)}',
          page: '${((length / limit).floor() + 1)}',
          limit: '$limit',
          cancelToken: cancelToken,
        )
        .handler(
          refresh && (apiState.isSuccess && assistantList.isNotEmpty)
              ? null
              : apiState,
          isLoading: false,
          onSuccess: (value) {
            if (value.responseCode != 1) {
              throw Exception(value.responseMsg);
            }

            if (refresh) {
              assistantList.clear();
            }

            assistantList.addAll(value.data);

            end.value = assistantList.length >= (value.totalData ?? 0);
          },
          onFailed: (value) {
            if (assistantList.isNotEmpty) {
              value.showToast();
            }
          },
        );
  }

  @override
  void scrollListener() {
    getAssistantData();
  }

  Future<void> deleteAssistant(String? id, {required int index}) async {
    var value = await Get.dialog(DeleteAssistantConfirmationDialog());
    if (value != true) {
      return;
    }

    AiAssistantService()
        .deleteAssistant(
          userId: '${getStorageData.readString(getStorageData.userId)}',
          assistantId: id,
        )
        .handler(
          apiState,
          onSuccess: (value) {
            if (value.responseCode != 1) {
              throw Exception(value.responseMsg);
            }
            assistantList.removeAt(index);
            value.showToast();
          },
          onFailed: (value) {
            value.showToast();
          },
        );
  }
}

class DeleteAssistantConfirmationDialog extends StatelessWidget {
  const DeleteAssistantConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: TColors.of(context).bg,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            ImageView(
              Assets.images.icDeletePhoto,
              inner: ImageSize(dimension: 60),
            ),
            CenterText(
              Languages.of(context)!.deleteAssistant,

              style: HelveticaStyles.of(context).s20w500,
            ),
            Gap(8),
            CenterText(
              Languages.of(context)!.deleteAssistantDesc,

              style: HelveticaStyles.of(context).s14w400,
            ),
            Row(
              spacing: 16,
              children: [
                Expanded(
                  child: AppButton(
                    onPressed: Get.back,
                    type: ButtonThemeType.secondary,
                    child: CenterText(Languages.of(context)!.no),
                  ),
                ),
                Expanded(
                  child: AppButton(
                    onPressed: () => Get.back(result: true),
                    child: CenterText(Languages.of(context)!.yes),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CenterText extends Text {
  const CenterText(super.data, {super.key, super.style})
    : super(textAlign: TextAlign.center);
}
