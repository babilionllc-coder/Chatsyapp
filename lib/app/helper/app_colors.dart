import 'package:chatsy/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

RxBool? _isLight;
bool get isLight => _isLight!.value;
set isLight(bool value) {
  if (_isLight == null) {
    _isLight = RxBool(value);
  } else {
    _isLight?.value = value;
  }
}

class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF3CDAD3);
  static const Color primaryLight = Color(0xFFE2FAF9);
  static const Color primaryDark = Color(0xFF2BC4BD);
  static const Color primaryGradient = Color(0xFF4AE8E0);
  static const Color black = Color(0xFF000000);
  static const Color black08 = Color(0x14000000);
  static const Color red = Color(0xfffff5844);
  static const Color grey1 = Color(0xFFA7A7A7);
  static const Color grey2 = Color(0xFF828282);
  static const Color green = Color(0xFF2CB964);
  static const Color lightWhite = Color(0xFFF4F5FA);
  static const Color yellow = Color(0xFFFFFF00);
  static const Color blue = Color(0xFF0000FF);
  static const Color transparent = Color(0x00000000);
  static const Color introBackGround = Color(0xFF031110);
  static const Color introBlackColor = Color(0xFF082B29);
  static const Color blackColorIntro = Color(0xFF030215);
  static const Color lightImageColor = Color(0xFF3BDBD4);
  static const Color question1 = Color(0xFFF6F5F9);
  static const Color bottomColor = Color(0xFF1D1F1E);
  static const Color gray = Color(0xFF7B777E);
  static const Color grayLight = Color(0xFFEBEBEB);
  static const Color grayLightIntro = Color(0xFFBEBEBE);
  static const Color bottomTextColor = Color(0xFF151624);
  static const Color bottomTextColorHint = Color(0x4D151624);
  static const Color tebBartTextColor = Color(0xFF8A8A8A);
  static const Color toolColor2 = Color(0xFF5ED8FF);
  static const Color toolColor3 = Color(0xFF007BD4);
  static const Color greyLight3 = Color(0xFF666666);
  static const Color greyLight4 = Color(0xFFDEDEDE);
  static Color grey = Color(0XFFE0E0E2);
  
  // New modern colors for better UI
  static const Color accent = Color(0xFF6C5CE7);
  static const Color accentLight = Color(0xFFE8E4FF);
  static const Color success = Color(0xFF00B894);
  static const Color warning = Color(0xFFFDCB6E);
  static const Color error = Color(0xFFE17055);
  static const Color info = Color(0xFF74B9FF);
  static const Color surface = Color(0xFFF8F9FA);
  static const Color surfaceDark = Color(0xFF2D3436);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardBackgroundDark = Color(0xFF2D3436);
  static const Color shadow = Color(0x1A000000);
  static const Color shadowDark = Color(0x1AFFFFFF);

  static Color answer = Color(0XFFF6F5F9);
  static Color docSize = Color(0XFFA4A4A4);

  static Color borderColors3 =
      isLight ? const Color(0xFFE2E3E5) : const Color(0xFF333534);

  static Color question = const Color(0XFF0C7C77);

  Color homePageText =
      isLight ? const Color(0xfff7b777e) : const Color(0xffBABBBA);
  Color borderColor2 =
      isLight ? const Color(0xFFF0F1F3) : const Color(0xFF333534);
  Color grayColorMix =
      isLight ? const Color(0xfffb3b3b3) : const Color(0xFFFFFFFF);
  Color whiteLightBlack =
      isLight ? const Color(0xFFffffff) : const Color(0xff292B2A);
  Color closeColor =
      isLight ? const Color(0xffF8F9FC) : const Color(0xFF242625);
  Color dialogText2 =
      isLight ? const Color(0xfff030215) : const Color(0xffBABBBA);
  Color lightTextColor =
      isLight ? const Color(0xFF4B4B4B) : const Color(0xFFC4C4C4);
  Color conColor2 = isLight ? const Color(0x0fffffff) : const Color(0xff191C1A);
  Color conColor = isLight ? const Color(0xFFF8F9FC) : const Color(0xff191C1A);
  Color dialogText3 =
      !isLight ? const Color(0xFFFFFFFF) : const Color(0xff6F6F6F);
  Color backgroundColor1 =
      isLight ? const Color(0xFFFFFFFF) : const Color(0xFF222423);
  Color lightThemWhite =
      isLight ? const Color(0xFFffffff) : const Color(0xFF2D303C);

  Color borderBottomBar =
      isLight ? const Color(0xffC5C5C5) : const Color(0xFF333438);
  Color lightBottomBar =
      isLight ? const Color(0xFFFFFFFF) : const Color(0xFF333438);

  Color bgColor = isLight ? const Color(0xFFF4F5F9) : const Color(0xff292B2A);
  Color introDarkAndWhite =
      isLight ? Color(0xFF030215) : const Color(0xFFffffff);
  Color darkAndWhite = isLight ? Color(0xFF000000) : const Color(0xFFffffff);
  Color whiteAndDark =
      isLight ? const Color(0xFFFFFFFF) : const Color(0xff333438);
  Color ansColor = isLight ? const Color(0XFFF6F5F9) : const Color(0xff333438);
  Color darkGray = isLight ? const Color(0xFF7B777E) : const Color(0xFFFFFFFF);
  Color darkWhiteAndBlack2 =
      !isLight ? const Color(0xFFF8F8FB) : const Color(0xFF232126);
  Color bgColor3 = isLight ? const Color(0xFFFAFAFA) : const Color(0xff292B2A);
  Color containerBlack = isLight ? AppColors.white : Color(0xFF313332);
  Color grayMix = isLight ? const Color(0xFFA4A4A4) : AppColors.white;
  Color lightGray = isLight ? AppColors.greyLight3 : AppColors.white;
  Color grayMix2 = isLight ? const Color(0xFFDADFE3) : AppColors.white;
  Color grayColor = isLight ? const Color(0xFF868589) : AppColors.white;
  Color lightWithe =
      isLight ? const Color(0xFFF3F2F7) : AppColors.black.changeOpacity(0.5);

  Color pp = isLight ? const Color(0xff6F6F6F) : AppColors.white;
  Color pb = isLight ? const Color(0xffffffff) : AppColors.black;
}
