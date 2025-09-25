import 'package:cached_network_image/cached_network_image.dart';

import '../../../common_widget/common_container.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/image_path.dart';
import '../../chat_gpt/views/chat_gpt_view.dart';
import '../../purchase/controllers/purchase_controller.dart';

class SelectedView extends StatelessWidget {
  SelectedView({
    super.key,
    required this.onTap,
    required this.data,
    required this.index,
    required this.count,
    this.color,
    this.height,
  });

  void Function()? onTap;
  SubscriptionCarousel data;
  int index;
  RxInt count;
  Color? color;
  double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CommonContainer(
        color: AppColors().bgColor3,
        padding: EdgeInsets.symmetric(vertical: 14.px, horizontal: 12.px),
        isBorder: true,
        child: Row(
          children: [
            if (data.description != null)
              (data.description?.contains("https") ?? true)
                  ? CachedNetworkImage(
                      imageUrl: data.description ?? "",
                      width: height ?? 24.px,
                      height: height ?? 24.px,
                      progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(circle: true),
                      errorWidget: (context, url, uri) => errorWidgetView().paddingAll(8.px),
                    )
                  : Image.asset(data.description!, height: height ?? 24.px, color: color),
            SizedBox(width: 16.px),
            Expanded(child: AppText(data.title ?? "")),
            // AnimCheckBox(
            //   duration: Durations.long4,
            //   selected: (index == count.value),
            // ),
            Container(
              padding: EdgeInsets.all(6.px),
              decoration: BoxDecoration(color: (index == count.value) ? AppColors.primary : Colors.transparent, shape: BoxShape.circle, border: Border.all(color: (index == count.value) ? Colors.transparent : AppColors().borderBottomBar, width: 1)),
              child: (index == count.value) ? Image.asset(ImagePath.trues, height: 8.px) : SizedBox(height: 8.px, width: 8.px),
            ),
          ],
        ),
      ),
    );
  }
}
