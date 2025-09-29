import 'package:chatsy/app/common_widget/custom_image_view.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/app/helper/font_family.dart';
import 'package:chatsy/main.dart';

import '../../gen/assets.gen.dart';

class _SuffixIcon extends StatelessWidget {
  const _SuffixIcon({required this.showing});

  final RxBool showing;

  @override
  Widget build(BuildContext context) {
    /// If you have to change the suffixIcon widget so you must have to be change you icon here.
    return Center(
      child: GestureDetector(
        onTap: showing.toggle,
        child: ImageView(
          showing.value ? Assets.svg.icEye : Assets.svg.icEyeSlash,
        ),
      ),
    );
  }
}

class TextFormFieldProxy extends InheritedWidget {
  const TextFormFieldProxy({
    super.key,
    required super.child,
    required this.decorationTheme,
  });

  final InputDecorationTheme decorationTheme;

  @override
  bool updateShouldNotify(TextFormFieldProxy oldWidget) {
    return decorationTheme != oldWidget.decorationTheme;
  }
}

class TextInputField extends TextFormField {
  TextInputField({
    required BuildContext context,
    super.focusNode,
    super.key,
    super.initialValue,
    required InputType type,
    required String? hintLabel,
    required super.controller,
    super.onTap,
    super.textInputAction = TextInputAction.next,
    super.maxLines,
    super.minLines,
    super.autovalidateMode = AutovalidateMode.onUnfocus,
    super.validator,
    super.enabled,
    super.readOnly,
    super.expands,
    TextCapitalization? textCapitalization,
    RxBool? obscureText,
    super.obscuringCharacter,
    TextInputType? keyboardType,
    Iterable<String>? autoFillHints,
    Widget? suffixIcon,
    Widget? prefixIcon,
    List<TextInputFormatter>? overrideInputFormatters,
    List<TextInputFormatter>? inputFormatters,
    ThemeType themeType = ThemeType.bordered,
  }) : assert(
         type != InputType.multiline ||
             textInputAction == TextInputAction.newline,
         'Make textInputAction = TextInputAction.newline',
       ),
       assert(
         (type != InputType.password &&
                 type != InputType.newPassword &&
                 type != InputType.confirmPassword) ||
             obscureText != null,
         'Make sure your providing obscureText and Wrap Obx on TextInputField',
       ),
       super(
         keyboardType:
             keyboardType ??
             switch (type) {
               InputType.name => TextInputType.text,
               InputType.text => TextInputType.text,
               InputType.email => TextInputType.emailAddress,
               InputType.password => TextInputType.visiblePassword,
               InputType.confirmPassword => TextInputType.visiblePassword,
               InputType.newPassword => TextInputType.visiblePassword,
               InputType.phoneNumber => TextInputType.phone,
               InputType.digits => TextInputType.number,
               InputType.decimalDigits => const TextInputType.numberWithOptions(
                 decimal: true,
               ),
               InputType.multiline => TextInputType.multiline,
             },
         autofillHints: [
           if (autoFillHints != null) ...autoFillHints,
           switch (type) {
             InputType.name => AutofillHints.name,
             InputType.email => AutofillHints.email,
             InputType.password => AutofillHints.password,
             InputType.confirmPassword => AutofillHints.password,
             InputType.newPassword => AutofillHints.newPassword,
             InputType.phoneNumber => AutofillHints.telephoneNumber,
             _ => '',
           },
         ],
         textCapitalization:
             textCapitalization ??
             switch (type) {
               InputType.name => TextCapitalization.words,
               InputType.email => TextCapitalization.none,
               InputType.multiline => TextCapitalization.sentences,
               _ => TextCapitalization.none,
             },
         inputFormatters:
             overrideInputFormatters ??
             [
               if (inputFormatters != null) ...inputFormatters,
               if (type == InputType.digits)
                 FilteringTextInputFormatter.digitsOnly,
               if (type == InputType.decimalDigits)
                 FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*')),
             ],
         obscureText: obscureText?.value ?? false,
         style: HelveticaStyles.of(context).s14w400,
         decoration: _decoration(
           context: context,
           hintLabel: hintLabel,
           prefixIcon: prefixIcon,
           suffixIcon: suffixIcon,
           obscureText: obscureText,
           themeType: themeType,
         ),
       );

  static InputDecoration _decoration({
    String? hintLabel,
    Widget? prefixIcon,
    Widget? suffixIcon,
    RxBool? obscureText,
    required BuildContext context,
    required ThemeType themeType,
  }) {
    InputDecorationTheme? decorationTheme = switch (themeType) {
      ThemeType.bordered =>
        Theme.of(context).extension<TextFieldThemes>()?.borderedDecorationTheme,
      ThemeType.transparent =>
        Theme.of(
          context,
        ).extension<TextFieldThemes>()?.transparentDecorationTheme,
    };

    var decoration = InputDecoration(
      hintText: hintLabel,
      prefixIcon:
          prefixIcon is ImageView ? Center(child: prefixIcon) : prefixIcon,
      prefixIconConstraints: BoxConstraints.tight(const Size.square(50)),
      suffixIconConstraints: BoxConstraints.tight(const Size.square(50)),
      suffixIcon: _suffixIcon(suffixIcon, obscureText),
    );

    if (decorationTheme != null) {
      return decoration.applyDefaults(decorationTheme);
    }

    return decoration;
  }

  static Widget? _suffixIcon(Widget? suffixIcon, RxBool? obscureText) {
    if (suffixIcon is ImageView) {
      return Center(child: suffixIcon);
    }

    return suffixIcon ??
        (obscureText == null ? null : _SuffixIcon(showing: obscureText));
  }
}

enum ThemeType { bordered, transparent }

enum InputType {
  name,
  text,
  email,
  password,
  confirmPassword,
  newPassword,
  phoneNumber,
  digits,
  decimalDigits,
  multiline,
}

class TextFieldThemes extends ThemeExtension<TextFieldThemes> {
  TextFieldThemes._({
    required this.borderedDecorationTheme,
    required this.transparentDecorationTheme,
  });

  final InputDecorationTheme borderedDecorationTheme;
  final InputDecorationTheme transparentDecorationTheme;

  static const _borderRadius = BorderRadius.all(Radius.circular(10));

  TextFieldThemes.light({
    this.transparentDecorationTheme = const InputDecorationTheme(
      isCollapsed: true,
      hintStyle: Helvetica(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: KColors.textGrey,
      ),
      errorStyle: _errorStyle,
      border: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
    ),
    this.borderedDecorationTheme = const InputDecorationTheme(
      constraints: BoxConstraints(minHeight: 52),
      contentPadding: EdgeInsets.all(16),
      hintStyle: Helvetica(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: KColors.textGrey,
      ),
      border: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.08)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.08)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      errorStyle: _errorStyle,
      enabledBorder: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.08)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: BorderSide(color: Color.fromRGBO(0, 0, 0, 0.08)),
      ),
    ),
  });

  static const _errorStyle = Helvetica(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: Colors.redAccent,
  );

  TextFieldThemes.dark({
    this.transparentDecorationTheme = const InputDecorationTheme(
      isCollapsed: true,
      hintStyle: Helvetica(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: KColors.textGrey,
      ),
      border: InputBorder.none,
      errorStyle: _errorStyle,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
    ),
    this.borderedDecorationTheme = const InputDecorationTheme(
      constraints: BoxConstraints(minHeight: 52),
      contentPadding: EdgeInsets.all(16),
      hintStyle: Helvetica(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: KColors.textGrey,
      ),
      border: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.5)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: BorderSide(color: Colors.redAccent),
      ),
      errorStyle: _errorStyle,
      enabledBorder: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.5)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: _borderRadius,
        borderSide: BorderSide(color: Color.fromRGBO(255, 255, 255, 0.5)),
      ),
    ),
  });

  @override
  TextFieldThemes copyWith({TextStyle? hintStyle}) {
    return this;
  }

  @override
  ThemeExtension<TextFieldThemes> lerp(
    covariant ThemeExtension<TextFieldThemes>? other,
    double t,
  ) {
    if (other is! TextFieldThemes) {
      return this;
    }

    return TextFieldThemes._(
      borderedDecorationTheme: borderedDecorationTheme.lerp(
        other.borderedDecorationTheme,
        t,
      ),
      transparentDecorationTheme: transparentDecorationTheme.lerp(
        other.transparentDecorationTheme,
        t,
      ),
    );
  }

  static TextFieldThemes of(BuildContext context) {
    return Theme.of(context).extension<TextFieldThemes>()!;
  }
}

class TextFieldThemeProxy extends InheritedWidget {
  const TextFieldThemeProxy({
    super.key,
    required super.child,
    required this.decorationTheme,
  });

  final InputDecorationTheme decorationTheme;

  @override
  bool updateShouldNotify(TextFieldThemeProxy oldWidget) {
    return decorationTheme != oldWidget.decorationTheme;
  }
}

extension on InputDecorationTheme {
  InputDecorationTheme lerp(InputDecorationTheme? other, double t) {
    if (other == null) {
      return this;
    }

    return InputDecorationTheme(
      labelStyle: labelStyle?.lerp(other.labelStyle, t),
      floatingLabelStyle: floatingLabelStyle?.lerp(other.floatingLabelStyle, t),
      helperStyle: helperStyle?.lerp(other.helperStyle, t),
      helperMaxLines: helperMaxLines,
      hintStyle: hintStyle?.lerp(other.hintStyle, t),
      hintFadeDuration: t < .5 ? hintFadeDuration : other.hintFadeDuration,
      errorStyle: errorStyle?.lerp(other.errorStyle, t),
      errorMaxLines: t < .5 ? errorMaxLines : other.errorMaxLines,
      floatingLabelBehavior:
          t < .5 ? floatingLabelBehavior : other.floatingLabelBehavior,
      floatingLabelAlignment:
          t < .5 ? floatingLabelAlignment : other.floatingLabelAlignment,
      isDense: t < .5 ? isDense : other.isDense,
      contentPadding: t < .5 ? contentPadding : other.contentPadding,
      isCollapsed: t < .5 ? isCollapsed : other.isCollapsed,
      iconColor: Color.lerp(iconColor, other.iconColor, t),
      prefixStyle: prefixStyle?.lerp(other.prefixStyle, t),
      prefixIconColor: Color.lerp(prefixIconColor, other.prefixIconColor, t),
      prefixIconConstraints:
          t < .5 ? prefixIconConstraints : other.prefixIconConstraints,
      suffixStyle: suffixStyle?.lerp(other.suffixStyle, t),
      suffixIconColor: Color.lerp(suffixIconColor, other.suffixIconColor, t),
      suffixIconConstraints:
          t < .5 ? suffixIconConstraints : other.suffixIconConstraints,
      counterStyle: counterStyle?.lerp(other.counterStyle, t),
      filled: t < .5 ? filled : other.filled,
      fillColor: Color.lerp(fillColor, other.fillColor, t),
      activeIndicatorBorder:
          t < .5 ? activeIndicatorBorder : other.activeIndicatorBorder,
      outlineBorder: t < .5 ? outlineBorder : other.outlineBorder,
      focusColor: Color.lerp(focusColor, other.focusColor, t),
      hoverColor: Color.lerp(hoverColor, other.hoverColor, t),
      errorBorder: t < .5 ? errorBorder : other.errorBorder,
      focusedBorder: t < .5 ? focusedBorder : other.focusedBorder,
      focusedErrorBorder:
          t < .5 ? focusedErrorBorder : other.focusedErrorBorder,
      disabledBorder: t < .5 ? disabledBorder : other.disabledBorder,
      enabledBorder: t < .5 ? enabledBorder : other.enabledBorder,
      border: t < .5 ? border : other.border,
      alignLabelWithHint:
          t < .5 ? alignLabelWithHint : other.alignLabelWithHint,
      constraints: t < .5 ? constraints : other.constraints,
    );
  }
}
