import 'package:chatsy/extension.dart';

import '../helper/all_imports.dart';

class CommonPromptView extends StatelessWidget {
  final String prompt;
  final Widget? prefixIcon;
  final Color? color;
  final Color? bgColor;
  final bool? boxShadow;
  final double? marginRight;

  const CommonPromptView({
    super.key,
    required this.prompt,
    this.prefixIcon,
    this.color,
    this.bgColor,
    this.boxShadow,
    this.marginRight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow:
            boxShadow == false
                ? null
                : [
                  BoxShadow(
                    color: AppColors().darkAndWhite.changeOpacity(0.1),
                    offset: Offset(0, 1),
                    blurRadius: 6.px,
                  ),
                ],
        color: bgColor ?? AppColors().ansColor,
        borderRadius: BorderRadius.circular(60.px),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 12.px),
        child: Row(
          children: [
            if (prefixIcon != null) prefixIcon!,
            AppText(
              prompt.capitalizeFirst ?? "",
              fontSize: 12.px,
              maxLines: 1,
              color: color ?? AppColors().darkAndWhite,
            ),
          ],
        ),
      ),
    ).marginOnly(right: marginRight ?? 5.px, top: 5.px, bottom: 5.px, left: 5.px);
  }
}
