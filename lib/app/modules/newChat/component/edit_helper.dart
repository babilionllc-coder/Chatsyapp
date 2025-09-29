import 'package:chatsy/app/common_widget/common_screen.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/extension.dart';

import '../../../Localization/local_language.dart';
import '../../../common_widget/comman_text_field.dart';
import '../controllers/new_chat_controller.dart';

class EditHelper extends StatefulWidget {
  const EditHelper({super.key, required this.text});

  final String? text;

  @override
  State<EditHelper> createState() => _EditHelperState();
}

class _EditHelperState extends State<EditHelper> {
  @override
  void initState() {
    // getStorageData.saveSend(value: true);
    // getStorageData.saveListening(value: false);
    newChatController.text = widget.text ?? "";
    printAction("widget.newChatController.text ${newChatController.text}");
    newChatFocusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController newChatController = TextEditingController();
  FocusNode newChatFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      backgroundColor: AppColors().backgroundColor1.changeOpacity(0.7),
      appBarBackGroundColor: AppColors().whiteAndDark,
      title: "${Languages.of(context)!.edit} ${Languages.of(context)!.message}".capitalizeFirst,
      body: Container(
        color: AppColors().backgroundColor1.changeOpacity(0.6),
        child: Padding(
          padding: EdgeInsets.all(20.px),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      chatQuestionAnsView(
                        onTapEdit: (val) {},
                        question: widget.text ?? '',
                        ans: null,
                        isImageScan: null,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.px),
              CommonTextField(
                // color: AppColors().bgColor3,
                focusNode: newChatFocusNode,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                maxLine: 4,
                minLine: 1,
                controller: newChatController,
                hintText: "Ask anything...",
                isMic: true,
                // suffixIcon: Padding(
                //   padding: EdgeInsets.only(right: 10.px),
                //   child: sendMessageView(onTap: () {
                //     HapticFeedback.mediumImpact();
                //     if (!utils.isValidationEmpty(newChatController.text.trim())) {
                //       String text = newChatController.text.trim();
                //       newChatController.clear();
                //       Get.back(result: {HttpUtil.data: text.trim()});
                //     }
                //   }),
                // ),
                onSend: () {
                  String text = newChatController.text.trim();
                  newChatController.clear();
                  Get.back(result: {HttpUtil.data: text.trim()});
                },
                // suffixIconConstraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
