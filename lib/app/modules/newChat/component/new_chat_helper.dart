import 'package:chatsy/app/common_widget/common_show_model_bottom_sheet.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/helper/image_path.dart';
import 'package:chatsy/app/modules/newChat/component/selectText.dart';
import 'package:chatsy/extension.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

import '../../../Localization/local_language.dart';
import '../../../routes/app_pages.dart';

class NewChatHelper extends StatefulWidget {
  NewChatHelper({
    super.key,
    required this.text,
    required this.imageView,
    this.isEdit,
    required this.isQuestion,
  });

  final String text;
  final bool isQuestion;
  bool? isEdit = false;
  Widget? imageView;

  @override
  State<NewChatHelper> createState() => _NewChatHelperState();
}

class _NewChatHelperState extends State<NewChatHelper> {
  List<ChatSelectItem> chatSelectItem = [];

  @override
  Widget build(BuildContext context) {
    printAction("================widget======================${widget.isEdit}");
    chatSelectItem = [
      ChatSelectItem(Languages.of(context)!.copy, ImagePath.copy, false, 1),
      ChatSelectItem(Languages.of(context)!.selectText, ImagePath.select, true, 1),
      if ((widget.isQuestion) && (widget.isEdit ?? false))
        ChatSelectItem(Languages.of(context)!.edit, ImagePath.editSvg, true, 1),
      ChatSelectItem(Languages.of(context)!.readLoud, ImagePath.read, true, 1),
      if (!widget.isQuestion)
        ChatSelectItem(
          Languages.of(context)!.share.capitalizeFirst.toString(),
          ImagePath.share,
          true,
          8,
        ),
      if ((!widget.isQuestion) && (widget.isEdit ?? false))
        ChatSelectItem(Languages.of(context)!.regenerateResponse, ImagePath.regenerate, true, 8),
      if ((!widget.isQuestion) &&
          (widget.isEdit ?? false) &&
          (!utils.isValidationEmpty(widget.text)))
        ChatSelectItem(
          Languages.of(context)!.report.capitalizeFirst.toString(),
          ImagePath.report,
          true,
          8,
        ),
    ];
    return Scaffold(
      backgroundColor: AppColors().backgroundColor1.changeOpacity(0.8),
      body: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Container(
          color: AppColors().backgroundColor1.changeOpacity(0.8),
          child: Padding(
            padding: EdgeInsets.all(20.px),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.imageView ??
                        Image.asset(
                          (isLight) ? ImagePath.darkLogo : ImagePath.logo,
                          height: 25.px,
                          width: 25.px,
                        ),
                    SizedBox(width: 8.px),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: widget.isQuestion ? 6.px : 0),
                            constraints: BoxConstraints(maxHeight: 250.px),
                            decoration: BoxDecoration(
                              color: widget.isQuestion ? AppColors.question : AppColors().ansColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.changeOpacity(0.5),
                                  spreadRadius: 0.5,
                                  blurRadius: 10,
                                  offset: Offset(2, 2),
                                ),
                              ],
                              borderRadius: BorderRadius.all(Radius.circular(10.px)),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 7.px, horizontal: 14.px),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  (widget.isQuestion)
                                      ? SelectionArea(
                                        child: AppText(
                                          widget.text,
                                          fontSize: 12.px,
                                          color: widget.isQuestion ? AppColors.white : null,
                                        ),
                                      )
                                      : CommonMarkDownText(text: widget.text, selectText: true),
                                  SizedBox(height: 2.px),
                                ],
                              ),
                            ),
                          ),
                          if (widget.isQuestion)
                            SvgPicture.asset(ImagePath.arrowChat, width: 12.px, height: 12.px),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.px),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Container(
                    margin: EdgeInsets.only(left: 35.px),
                    constraints: BoxConstraints(maxWidth: 70.w),
                    decoration: BoxDecoration(
                      color: AppColors().whiteAndDark,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.changeOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(10.px)),
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: chatSelectItem.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            if (chatSelectItem[index].isShowDivider)
                              Divider(
                                height: chatSelectItem[index].dividerHeight,
                                thickness: chatSelectItem[index].dividerHeight,
                                color: AppColors().darkAndWhite.changeOpacity(0.1),
                              ),
                            GestureDetector(
                              onTap: () {
                                if (chatSelectItem[index].title == Languages.of(context)!.copy) {
                                  Clipboard.setData(ClipboardData(text: widget.text));
                                  Utils().showToast(message: "Text copied");
                                  Get.back();
                                } else if (chatSelectItem[index].title ==
                                    Languages.of(context)!.selectText) {
                                  Get.back();
                                  CommonShowModelBottomSheet(
                                    child: SelectTextView(
                                      askData: widget.text,
                                      isQuestion: widget.isQuestion,
                                    ),
                                  );

                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(builder: (context) => SelectTextView(askData: widget.text)),
                                  // );
                                } else if (chatSelectItem[index].title ==
                                        Languages.of(context)!.edit ||
                                    chatSelectItem[index].title ==
                                        Languages.of(context)!.readLoud ||
                                    chatSelectItem[index].title ==
                                        Languages.of(context)!.regenerateResponse) {
                                  Get.back(
                                    result: {
                                      HttpUtil.data: widget.text,
                                      HttpUtil.type: chatSelectItem[index].title,
                                    },
                                  );
                                } else if (chatSelectItem[index].title.toLowerCase() ==
                                    Languages.of(context)!.share.toLowerCase()) {
                                  Share.share(widget.text);
                                } else if (chatSelectItem[index].title.toLowerCase() ==
                                    Languages.of(context)!.report.toLowerCase()) {
                                  Get.back();
                                  Get.toNamed(Routes.REASON, arguments: {'reason': widget.text});
                                }
                              },
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AppText(
                                      chatSelectItem[index].title,
                                      fontSize: 16.px,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                  SvgPicture.asset(
                                    chatSelectItem[index].icon,
                                    height: 18.px,
                                    width: 18.px,
                                    color: AppColors().darkAndWhite,
                                  ),
                                ],
                              ),
                            ).paddingSymmetric(horizontal: 16.px, vertical: 10.px),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChatSelectItem {
  final String title;
  final String icon;
  final bool isShowDivider;
  final double dividerHeight;
  final IconData? iconData;

  ChatSelectItem(this.title, this.icon, this.isShowDivider, this.dividerHeight, {this.iconData});
}
