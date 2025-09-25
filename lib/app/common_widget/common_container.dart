import 'package:chatsy/extension.dart';

import '../helper/all_imports.dart';

class CommonContainer extends StatelessWidget {
  const CommonContainer({
    super.key,
    this.radius,
    this.height,
    this.isBorderRadiusBottom = false,
    this.width,
    this.child,
    this.padding,
    this.margin,
    this.constraints,
    this.color,
    this.border,
    this.isBorder = false,
    this.isIntro = false,
    this.alignment,
  });

  final double? radius;
  final double? height;
  final double? width;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final BoxBorder? border;
  final BoxConstraints? constraints;
  final bool isBorderRadiusBottom;
  final bool isBorder;
  final bool isIntro;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      constraints: constraints,
      padding: padding,
      alignment: alignment,
      height: height,
      width: width,
      decoration: BoxDecoration(
        boxShadow:
            (isIntro)
                ? [
                  BoxShadow(
                    color: Color(0x7A3BDBD4).changeOpacity(0.5),
                    blurRadius: 9,
                    spreadRadius: 0,
                  ),
                ]
                : [],
        border:
            (isBorderRadiusBottom)
                ? Border(
                  bottom: BorderSide(
                    color: AppColors().borderBottomBar,
                    width: 0.5,
                    style: BorderStyle.solid,
                  ),
                )
                : isBorder
                ? border ??
                    Border.all(
                      color: (isIntro) ? AppColors.lightImageColor : AppColors().borderBottomBar,
                      width: 0.5,
                    )
                : null,
        color: color ?? Colors.transparent,
        borderRadius: !isBorderRadiusBottom ? BorderRadius.circular(radius ?? 15.px) : null,
      ),
      child: child,
    );
  }
}
