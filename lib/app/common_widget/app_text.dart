import 'package:chatsy/app/helper/font_family.dart';
import 'package:chatsy/extension.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../helper/all_imports.dart';
import '../modules/chat_gpt/views/chat_gpt_view.dart';

class AppText extends StatelessWidget {
  final String text;
  final String? fontFamily;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final double? letterSpacing;
  final double? height;
  final Paint? foreground;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextDecoration? decoration;

  const AppText(
    this.text, {
    super.key,
    this.fontFamily,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.height,
    this.textAlign,
    this.letterSpacing,
    this.overflow,
    this.decoration,
    this.foreground,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      overflow: maxLines == null ? TextOverflow.visible : TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyle(
        height: height,
        foreground: foreground,
        decoration: decoration,
        fontSize: fontSize ?? 16.px,
        letterSpacing: letterSpacing,
        color: color ?? AppColors().darkAndWhite,
        fontWeight: fontWeight,
        decorationColor: color ?? AppColors().darkAndWhite,
        fontFamily: fontFamily ?? FontFamily.helveticaRegular,
      ),
    );
  }
}

class AppRichText extends StatelessWidget {
  final String? firstText;
  final String? secondText;
  final String? thirdText;
  final String? fourthText;
  final double? height;
  final String? firstTextFontFamily;
  final String? secondTextFontFamily;
  final String? thirdTextFontFamily;
  final String? fourthTextFontFamily;
  final FontWeight? firstFontWeight;
  final FontWeight? secondFontWeight;
  final FontWeight? thirdFontWeight;
  final FontWeight? fourthFontWeight;
  final TextDecoration? firstDecoration;
  final TextDecoration? secondDecoration;
  final TextDecoration? thirdDecoration;
  final TextDecoration? fourthDecoration;
  final Color? firstTextColor;
  final Color? secondTextColor;
  final Color? thirdTextColor;
  final TextAlign? textAlign;
  final double? fontSize;
  final double? firstFontSize;
  final double? secondFontSize;
  final double? thirdFontSize;
  final double? fourthFontSize;
  final Function()? onTap;
  final Function()? forthOnTap;
  final Function()? firstOnTap;
  final Function()? thirdOnTap;

  const AppRichText({
    super.key,
    this.firstText,
    this.secondText,
    this.onTap,
    this.forthOnTap,
    this.thirdText,
    this.fourthText,
    this.firstTextColor,
    this.secondTextColor,
    this.thirdTextColor,
    this.fontSize,
    this.firstTextFontFamily,
    this.firstFontWeight,
    this.fourthFontWeight,
    this.secondFontWeight,
    this.thirdFontWeight,
    this.height,
    this.textAlign,
    this.fourthTextFontFamily,
    this.secondTextFontFamily,
    this.thirdTextFontFamily,
    this.firstDecoration,
    this.secondDecoration,
    this.thirdDecoration,
    this.firstOnTap,
    this.thirdOnTap,
    this.fourthDecoration,
    this.firstFontSize,
    this.secondFontSize,
    this.thirdFontSize,
    this.fourthFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign ?? TextAlign.center,
      overflow: TextOverflow.visible,
      text: TextSpan(
        text: firstText!,
        recognizer: TapGestureRecognizer()..onTap = firstOnTap,
        style: TextStyle(
          fontSize: firstFontSize ?? 18.px,
          height: 1.2,
          color: firstTextColor ?? AppColors.black,
          fontFamily: firstTextFontFamily ?? FontFamily.helveticaRegular,
          fontWeight: FontWeight.w400,
          decoration: firstDecoration,
        ),
        children: [
          TextSpan(
            text: secondText!,
            recognizer: TapGestureRecognizer()..onTap = onTap,
            style: TextStyle(
              fontSize: secondFontSize ?? 18.px,
              color: secondTextColor ?? AppColors.white,
              fontFamily: secondTextFontFamily ?? FontFamily.helveticaRegular,
              fontWeight: firstFontWeight ?? FontWeight.w500,
              decoration: secondDecoration,
              decorationColor: AppColors.white,
            ),
          ),
          TextSpan(
            text: thirdText ?? "",
            recognizer: TapGestureRecognizer()..onTap = thirdOnTap,
            style: TextStyle(
              fontSize: thirdFontSize ?? 18.px,
              color: thirdTextColor ?? AppColors.black,
              fontFamily: thirdTextFontFamily ?? FontFamily.helveticaRegular,
              fontWeight: firstFontWeight ?? FontWeight.w500,
              decoration: thirdDecoration,
            ),
          ),
          TextSpan(
            text: fourthText ?? "",
            recognizer: TapGestureRecognizer()..onTap = forthOnTap,
            style: TextStyle(
              fontSize: fourthFontSize ?? 18.px,
              color: secondTextColor ?? AppColors.white,
              fontFamily: secondTextFontFamily ?? FontFamily.helveticaRegular,
              fontWeight: secondFontWeight ?? FontWeight.w500,
              decoration: secondDecoration,
            ),
          ),
        ],
      ),
    );
  }
}

class CommonTextStyle {
  static TextStyle markDownTextColor = TextStyle(color: AppColors().darkAndWhite);
}

class CommonMarkDownText extends StatelessWidget {
  final String text;
  final bool? selectText;

  const CommonMarkDownText({super.key, required this.text, this.selectText});

  List<String> extractDomains(String markdown) {
    final linkPattern = RegExp(r'\[([^\]]+)\]\((https?:\/\/[^\)]+)\)');
    final matches = linkPattern.allMatches(markdown);
    return matches
        .map((match) {
          final url = match.group(2);
          return url != null ? Uri.parse(url).host : '';
        })
        .where((domain) => domain.isNotEmpty)
        .toSet()
        .toList(); // toSet to remove duplicates
  }

  String prependFaviconsToLinks(String markdown) {
    final linkPattern = RegExp(r'\[([^\]]+)\]\((https?:\/\/[^\)]+)\)');
    return markdown.replaceAllMapped(linkPattern, (match) {
      final linkText = match.group(1);
      final url = match.group(2);

      if (url == null) return match.group(0)!;

      final domain = Uri.parse(url).host;
      final faviconUrl = 'https://www.google.com/s2/favicons?sz=64&domain=$domain';

      return '![]($faviconUrl) **$domain**  [$linkText]($url)';
    });
  }

  // String prependFaviconsToLinks(String text) {
  //   final urlPattern = RegExp(r'(https?:\/\/[^\s]+)');
  //   final lines = text.split('\n');
  //   final buffer = StringBuffer();
  //
  //   for (final line in lines) {
  //     final match = urlPattern.firstMatch(line);
  //     if (match != null) {
  //       final url = match.group(0)!;
  //       final domain = Uri.parse(url).host;
  //       final faviconUrl = 'https://www.google.com/s2/favicons?sz=64&domain=$domain';
  //
  //       buffer.writeln('![]($faviconUrl)');
  //       buffer.writeln('**$domain**');
  //       buffer.writeln(line.trim());
  //       buffer.writeln(''); // add spacing
  //     }
  //   }
  //
  //   return buffer.toString();
  // }

  @override
  Widget build(BuildContext context) {
    final List<String> domains = extractDomains(text);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MarkdownBody(
          shrinkWrap: true,
          data: prependFaviconsToLinks(text),
          selectable: selectText ?? false,
          onTapText: () {
            debugPrint("Tapped on markdown text");
          },
          onTapLink: (text, href, title) {
            utils.urlLaunch(Uri.parse(href ?? "https://www.google.com"));
          },
          sizedImageBuilder: (config) {
            return CachedNetworkImage(
              imageUrl: config.uri.toString(),
              width: 16,
              height: 16,
              progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(),
              errorWidget: (context, url, uri) => errorWidgetView().paddingAll(2.px),
            );
          },
          // TODO: Check this portion of code
          // imageBuilder: (uri, title, alt) {
          //   return CachedNetworkImage(
          //     imageUrl: uri.toString(),
          //     width: 16,
          //     height: 16,
          //     progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(),
          //     errorWidget: (context, url, uri) => errorWidgetView().paddingAll(2.px),
          //   );
          // },
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(Get.context!)).copyWith(
            p: TextStyle(fontSize: 14.px, color: AppColors().darkAndWhite),
            a: CommonTextStyle.markDownTextColor.copyWith(color: AppColors.primary),
            h1: CommonTextStyle.markDownTextColor,
            h2: CommonTextStyle.markDownTextColor,
            h3: CommonTextStyle.markDownTextColor,
            h4: CommonTextStyle.markDownTextColor,
            h5: CommonTextStyle.markDownTextColor,
            h6: CommonTextStyle.markDownTextColor,
            tableHead: CommonTextStyle.markDownTextColor,
            checkbox: CommonTextStyle.markDownTextColor,
            listBullet: CommonTextStyle.markDownTextColor.copyWith(
              color: (isLight) ? AppColors.blackColorIntro : AppColors.white,
            ),
            blockquote: CommonTextStyle.markDownTextColor,
            img: CommonTextStyle.markDownTextColor,
            code: CommonTextStyle.markDownTextColor.copyWith(
              color: (isLight) ? AppColors.blackColorIntro : AppColors.white,
            ),
            codeblockDecoration: BoxDecoration(
              color: AppColors.white.changeOpacity((isLight) ? 1 : 0.1),
            ),
            em: CommonTextStyle.markDownTextColor,
            del: CommonTextStyle.markDownTextColor,
          ),
        ),
        /* SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: domains.map((domain) {
            final faviconUrl = 'https://www.google.com/s2/favicons?sz=64&domain=$domain';
            return CachedNetworkImage(
              imageUrl: faviconUrl,
              width: 24,
              height: 24,
              progressIndicatorBuilder: (context, url, progress) => CircularProgressIndicator(strokeWidth: 1),
              errorWidget: (context, url, uri) => Icon(Icons.error, size: 20),
            );
          }).toList(),
        )*/
      ],
    );
  }
}

Widget CommonTwoTextView({
  required String firstText,
  required String secondText,
  Color? color,
  String? fontFamily,
}) {
  return Column(
    children: [
      Center(
        child: AppText(
          firstText,
          fontSize: 26.px,
          textAlign: TextAlign.center,
          fontFamily: FontFamily.helveticaBold,
        ),
      ),
      Center(
        child: AppText(
          secondText,
          fontSize: 18.px,
          color: color,
          textAlign: TextAlign.center,
          fontFamily: fontFamily ?? FontFamily.helveticaRegular,
        ),
      ),
    ],
  );
}
