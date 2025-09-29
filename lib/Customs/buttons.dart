import 'package:flutter/material.dart';

import '../app/helper/font_family.dart';
import '../main.dart';

class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.type = ButtonThemeType.primary,
  });

  final VoidCallback? onPressed;

  final Widget child;

  final ButtonThemeType type;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  @override
  Widget build(BuildContext context) {
    final style = switch (widget.type) {
      ButtonThemeType.primary => AppButtonTheme.of(context).primary,
      ButtonThemeType.secondary => AppButtonTheme.of(context).secondary,
    };

    return ListenableBuilder(
      listenable: statesController,
      builder: (context, child) {
        return BoundEffectByWidgetState(
          state: statesController.value,
          child: child!,
        );
      },
      child: ElevatedButton(
        onPressed: widget.onPressed,
        statesController: statesController,
        style: style,
        child: DefaultTextStyle(
          style: style.textStyle!.resolve({WidgetState.selected})!,
          child: widget.child,
        ),
      ),
    );
  }

  final WidgetStatesController statesController = WidgetStatesController();
}

enum ButtonThemeType { primary, secondary }

class AppButtonTheme extends ThemeExtension<AppButtonTheme> {
  const AppButtonTheme._({required this.secondary});

  const AppButtonTheme.light({
    this.secondary = const ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(KColors.greyButton),
      fixedSize: WidgetStatePropertyAll(Size.fromHeight(52)),
      textStyle: WidgetStatePropertyAll(
        Helvetica(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: Colors.black,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
  });

  const AppButtonTheme.dark({
    this.secondary = const ButtonStyle(
      backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 86, 86, 86)),
      fixedSize: WidgetStatePropertyAll(Size.fromHeight(56)),
      textStyle: WidgetStatePropertyAll(
        Helvetica(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),
  });

  final ButtonStyle primary = const ButtonStyle(
    backgroundColor: WidgetStatePropertyAll(KColors.cyan),
    fixedSize: WidgetStatePropertyAll(Size.fromHeight(56)),
    textStyle: WidgetStatePropertyAll(
      Helvetica(fontWeight: FontWeight.w700, fontSize: 14, color: Colors.white),
    ),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
  );

  final ButtonStyle secondary;

  static AppButtonTheme of(BuildContext context) {
    return Theme.of(context).extension<AppButtonTheme>()!;
  }

  @override
  ThemeExtension<AppButtonTheme> copyWith() {
    return this;
  }

  @override
  ThemeExtension<AppButtonTheme> lerp(
    covariant ThemeExtension<AppButtonTheme>? other,
    double t,
  ) {
    if (other is! AppButtonTheme) {
      return this;
    }
    return AppButtonTheme._(
      secondary: ButtonStyle.lerp(secondary, other.secondary, t)!,
    );
  }
}

class BoundEffectByWidgetState extends ImplicitlyAnimatedWidget {
  const BoundEffectByWidgetState({
    super.key,
    required this.state,
    required this.child,
    super.duration = Durations.short4,
    super.curve = Curves.decelerate,
  });

  final Set<WidgetState> state;

  final Widget child;

  @override
  AnimatedWidgetBaseState<BoundEffectByWidgetState> createState() =>
      _BoundEffectByWidgetStateState();
}

class _BoundEffectByWidgetStateState
    extends AnimatedWidgetBaseState<BoundEffectByWidgetState> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: (_tween?.evaluate(animation) ?? _value),
      child: widget.child,
    );
  }

  double get _value {
    if (widget.state.contains(WidgetState.pressed)) return .99;

    return 1.0;
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _tween =
        visitor(
              _tween,
              _value,
              (targetValue) => Tween<double>(begin: targetValue),
            )
            as Tween<double>?;
  }

  Tween<double>? _tween;
}
