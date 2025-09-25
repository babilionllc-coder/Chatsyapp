import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';

import '../helper/all_imports.dart';
import '../modules/chat_gpt/views/chat_gpt_view.dart';

class CommonQuestionView extends StatelessWidget {
  final String? questionIcon;
  final String? question;

  final String? answerImageUrl;
  final String? ansTitle;
  final String? ansSubTitle;

  const CommonQuestionView({
    super.key,
    this.questionIcon,
    this.question,
    this.answerImageUrl = "",
    this.ansTitle = "",
    this.ansSubTitle = "",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ((questionIcon ?? "").isURL)
                ? ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: questionIcon ?? "",
                      fit: BoxFit.cover,
                      width: 25.px,
                      height: 25.px,
                      progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(circle: true),
                      errorWidget: (context, url, uri) => errorWidgetView(),
                    ),
                  )
                : (utils.isValidationEmpty(questionIcon))
                    ? const SizedBox()
                    : SvgPicture.asset(questionIcon ?? "", height: 25.px, width: 25.px),
            SizedBox(
              width: 8.px,
            ),
            Expanded(
              child: Container(
                // width: double.infinity,
                decoration: BoxDecoration(color: AppColors().ansColor, borderRadius: BorderRadius.all(Radius.circular(10.px))),
                padding: EdgeInsets.symmetric(vertical: 7.px, horizontal: 12.px),
                child: AppText(
                  question ?? "",
                  fontSize: 14.px,
                ),
              ),
            )
          ],
        ).marginOnly(bottom: 8.px),
        if (ansTitle != "" && answerImageUrl != "")
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: 28.px,
              ),
              Expanded(
                child: Container(
                  alignment: AlignmentDirectional.centerStart,
                  // width: double.infinity,
                  margin: EdgeInsets.only(left: 6.px),
                  decoration: BoxDecoration(color: AppColors().ansColor, borderRadius: BorderRadius.all(Radius.circular(10.px))),
                  padding: EdgeInsets.symmetric(vertical: 7.px, horizontal: 12.px),
                  child: Row(
                    children: [
                      (answerImageUrl == "" || answerImageUrl!.startsWith("https"))
                          ? Container(
                              width: 32.px,
                              height: 32.px,
                              padding: EdgeInsets.all(8.px),
                              decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.white),
                              child: CachedNetworkImage(
                                imageUrl: answerImageUrl ?? "",
                                fit: BoxFit.cover,
                                progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(circle: true),
                                errorWidget: (context, url, uri) => errorWidgetView(),
                              ),
                            )
                          : SvgPicture.asset(answerImageUrl ?? "", height: 32.px, width: 32.px),
                      SizedBox(
                        width: 8.px,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              ansTitle ?? "",
                              fontSize: 12.px,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                            AppText(
                              ansSubTitle ?? "",
                              fontSize: 12.px,
                              color: AppColors.docSize,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
      ],
    );
  }
}
