import 'package:chatsy/extension.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../helper/all_imports.dart';
import '../helper/font_family.dart';

class CommonTextFiledBottomSheet extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final String? hintText;
  final bool? readOnly;
  final String? prefixIconPath;
  final String? suffixIconPath;
  final String? title;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final TextInputAction? textInputAction;
  Color? textColor;

  final double? bottomLeft;
  final double? bottomRight;
  final double? topLeft;
  final double? topRight;
  final void Function(String)? onChanged;
  final int? maxLine;
  final EdgeInsetsGeometry? padding;
  final bool obscureText;

  final TextAlign? textAlign;
  final Color? fillColor;
  final List<TextInputFormatter>? inputFormatters;

  CommonTextFiledBottomSheet({
    super.key,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.hintStyle,
    this.bottomLeft,
    this.bottomRight,
    this.topLeft,
    this.padding,
    this.textColor,
    this.onChanged,
    this.readOnly,
    this.topRight,
    this.prefixIconPath,
    this.textInputAction,
    this.onTap,
    this.keyboardType,
    this.maxLine,
    this.suffixIconPath,
    this.inputFormatters,
    this.style,
    this.textAlign,
    this.fillColor,
    this.title,
    this.obscureText = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) AppText("$title:"),
        TextFormField(
          onTap: onTap,
          readOnly: readOnly ?? false,
          controller: controller,
          maxLines: maxLine ?? 1,
          textInputAction: textInputAction ?? TextInputAction.done,
          textAlign: textAlign ?? TextAlign.start,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType ?? TextInputType.text,
          textAlignVertical: TextAlignVertical.center,
          obscureText: !obscureText,
          style:
              style ??
              TextStyle(
                fontSize: 14.px,
                fontFamily: FontFamily.helveticaRegular,
                color: textColor ?? AppColors().darkAndWhite,
              ),
          // textInputAction: textInputAction ?? TextInputAction.next,
          decoration: InputDecoration(
            filled: fillColor != null,
            fillColor: fillColor,
            contentPadding: padding ?? EdgeInsets.fromLTRB(15.px, 8.px, 10.px, 8.px),
            prefixIconConstraints: BoxConstraints(maxHeight: 20.px),
            prefixIcon:
                (prefixIconPath != null)
                    ? Padding(
                      padding: EdgeInsets.only(left: 10.px, right: 10.px),
                      child: SvgPicture.asset(prefixIconPath!, color: AppColors().darkAndWhite),
                    )
                    : prefixIcon,
            suffixIconConstraints: BoxConstraints(maxHeight: 30.px),
            suffixIcon:
                (suffixIconPath != null)
                    ? Padding(
                      padding: EdgeInsets.only(right: 10.px, left: 10.px),
                      child: SvgPicture.asset(suffixIconPath!, color: AppColors().grayMix),
                    )
                    : suffixIcon,
            isDense: true,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors().darkAndWhite.changeOpacity(0.08),
                width: 1.px,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(bottomLeft ?? 10.px),
                bottomRight: Radius.circular(bottomRight ?? 10.px),
                topLeft: Radius.circular(topLeft ?? 10.px),
                topRight: Radius.circular(topRight ?? 10.px),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors().darkAndWhite.changeOpacity(0.08),
                width: 1.px,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(bottomLeft ?? 10.px),
                bottomRight: Radius.circular(bottomRight ?? 10.px),
                topLeft: Radius.circular(topLeft ?? 10.px),
                topRight: Radius.circular(topRight ?? 10.px),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors().darkAndWhite.changeOpacity(0.08),
                width: 1.px,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(bottomLeft ?? 10.px),
                bottomRight: Radius.circular(bottomRight ?? 10.px),
                topLeft: Radius.circular(topLeft ?? 10.px),
                topRight: Radius.circular(topRight ?? 10.px),
              ),
            ),
            hintText: hintText ?? "",
            hintStyle:
                hintStyle ??
                TextStyle(
                  fontSize: 14.px,
                  fontFamily: FontFamily.helveticaRegular,
                  color: AppColors().homePageText,
                ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
