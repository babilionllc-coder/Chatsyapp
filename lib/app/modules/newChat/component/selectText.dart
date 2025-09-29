import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/helper/font_family.dart';
import 'package:chatsy/extension.dart';

import '../../../Localization/local_language.dart';

class SelectTextView extends StatelessWidget {
  const SelectTextView({super.key, required this.askData, required this.isQuestion});

  final String askData;
  final bool isQuestion;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.px),
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            /*Row(
              children: [
                GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.close,
                      size: 40.px,
                      color: isLight ? AppColors.blackIntro : Colors.white,
                    )),
                SizedBox(
                  width: 10.px,
                ),
                AppText(
                  Languages.of(context)!.selectText,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.px,
                  color: isLight ? AppColors.blackIntro : Colors.white,
                ),
              ],
            ),*/
            SizedBox(height: 20.px),
            Center(
              child: AppText(
                Languages.of(context)!.selectText,
                fontSize: 18.px,
                color: isLight ? AppColors.blackColorIntro : Colors.white,
                fontFamily: FontFamily.helveticaBold,
              ),
            ),
            SizedBox(height: 20.px),
            TextSelectionTheme(
              data: TextSelectionThemeData(
                selectionColor: AppColors.toolColor2.changeOpacity(0.5),
                selectionHandleColor: Colors.blue,
              ),
              child: SelectionArea(
                child:
                    isQuestion
                        ? AppText(askData, fontSize: 16.px)
                        : CommonMarkDownText(text: askData),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
