import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/main.dart';

class FontFamily {
  static const helveticaBold = "Helvetica-Bold";
  static const helveticaLight = "Helvetica-Light";
  static const helveticaRegular = "Helvetica-Regular";
}

const _helveticaAdvancedMethod = "Helvetica-Advanced-Method";

class Helvetica extends TextStyle {
  const Helvetica({super.fontSize, super.color, super.fontWeight})
    : super(fontFamily: _helveticaAdvancedMethod);
}

class HelveticaStyles extends ThemeExtension<HelveticaStyles> {
  HelveticaStyles._({
    /// 20
    required this.s20w500,
    required this.s20w700,

    /// 16
    required this.s16w500,

    /// 14
    required this.s14w400,
    required this.s14w400Grey,
    required this.s14w700,

    /// 12
    required this.s12w400,
    required this.s12w400Grey,
  });

  /// 20
  final TextStyle s20w500;
  final TextStyle s20w700;

  /// 16
  final TextStyle s16w500;

  /// 14
  final TextStyle s14w400;
  final TextStyle s14w400White = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );
  final TextStyle s14w400Grey;
  final TextStyle s14w700;

  /// 12
  final TextStyle s12w400;
  final TextStyle s12w400Grey;

  HelveticaStyles.light({
    /// 20
    this.s20w500 = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    this.s20w700 = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),

    /// 16
    this.s16w500 = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),

    /// 14
    this.s14w400 = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),

    this.s14w400Grey = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: KColors.textGrey,
    ),
    this.s14w700 = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),

    /// 12
    this.s12w400 = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    this.s12w400Grey = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: KColors.textGrey,
    ),
  });

  HelveticaStyles.dark({
    /// 20
    this.s20w500 = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),
    this.s20w700 = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),

    /// 16
    this.s16w500 = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),

    /// 14
    this.s14w400 = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),

    this.s14w400Grey = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: KColors.textGrey,
    ),
    this.s14w700 = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),

    /// 12
    this.s12w400 = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
    this.s12w400Grey = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: KColors.textGrey,
    ),
  });

  static HelveticaStyles of(BuildContext context) =>
      Theme.of(context).extension<HelveticaStyles>()!;

  @override
  ThemeExtension<HelveticaStyles> copyWith() {
    return this;
  }

  @override
  ThemeExtension<HelveticaStyles> lerp(
    covariant ThemeExtension<HelveticaStyles>? other,
    double t,
  ) {
    if (other is HelveticaStyles) {
      return HelveticaStyles._(
        s20w500: s20w500.lerp(other.s20w500, t)!,
        s20w700: s20w700.lerp(other.s20w700, t)!,
        s16w500: s16w500.lerp(other.s16w500, t)!,
        s14w400Grey: s14w400Grey.lerp(other.s14w400Grey, t)!,
        s14w700: s14w700.lerp(other.s14w700, t)!,
        s14w400: s14w400.lerp(other.s14w400, t)!,
        s12w400: s12w400.lerp(other.s12w400, t)!,
        s12w400Grey: s12w400Grey.lerp(other.s12w400Grey, t)!,
      );
    }

    return this;
  }
}

extension TextStyleX on TextStyle {
  TextStyle? lerp(TextStyle? other, double t) {
    if (other == null) return this;
    return TextStyle.lerp(this, other, t);
  }
}
