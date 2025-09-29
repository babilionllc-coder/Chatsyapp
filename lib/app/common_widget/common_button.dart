import '../helper/all_imports.dart';
import '../helper/font_family.dart';

class CommonButton extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String? title;
  final double? borderRadius;
  final double? verticalPadding;
  final double? fontSize;
  final Color? buttonColor;
  final bool? isBorder;
  final Color? borderColor;
  final double? borderWidth;
  final Color? textColor;
  final double? textSize;
  final FontWeight? textWeight;
  final Gradient? gradient;
  final Widget? child;

  const CommonButton({
    super.key,
    required this.onTap,
    this.title,
    this.borderRadius,
    this.fontSize,
    this.buttonColor,
    this.verticalPadding,
    this.isBorder = false,
    this.borderColor,
    this.borderWidth = 1,
    this.textColor,
    this.textSize,
    this.child,
    this.textWeight,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return BounceGesture(
      onPressed: onTap,

      // style: ButtonStyle(
      //   padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.only(top: verticalPadding ?? 18.px, bottom: ((verticalPadding ?? 18.px) - 3))),
      //   foregroundColor: MaterialStateProperty.all<Color>(buttonColor ?? AppColors.primary),
      //   backgroundColor: MaterialStateProperty.all<Color>(buttonColor ?? AppColors.primary),
      //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 10.px), side: BorderSide(color: Colors.transparent))),
      // ),
      child: Container(
        padding: EdgeInsets.only(
          top: verticalPadding ?? 18.px,
          bottom: ((verticalPadding ?? 18.px) - 3),
        ),
        decoration: BoxDecoration(
          color: buttonColor ?? AppColors.primary,
          borderRadius: BorderRadius.circular(borderRadius ?? 10.px),
          // border: Border.all(color: isBorder == true ? borderColor ?? AppColors.primary : Colors.transparent, width: borderWidth ?? 1),
        ),
        child:
            child ??
            Center(
              child: AppText(
                title ?? "",
                fontFamily: FontFamily.helveticaBold,
                fontSize: fontSize ?? 16.px,
                color: textColor ?? AppColors.white,
              ),
            ),
      ),
    );
  }
}

class BounceGesture extends StatefulWidget {
  const BounceGesture({super.key, required this.onPressed, required this.child});

  final VoidCallback? onPressed;

  final Widget child;

  @override
  State<BounceGesture> createState() => _BounceGestureState();
}

class _BounceGestureState extends State<BounceGesture> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      onTapCancel: _onTapCancel,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: ScaleTransition(
        scale: Tween(begin: .4, end: 1.0).animate(_curves),
        child: widget.child,
      ),
    );
  }

  void _onTap() {
    widget.onPressed?.call();
    _controller.reverse().then((_) {
      _controller.forward();
    });
  }

  void _onTapUp(TapUpDetails details) {
    _controller.forward();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.reverse();
  }

  void _onTapCancel() {
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  late final Animation<double> _curves = CurvedAnimation(
    parent: _controller,
    curve: Curves.decelerate,
    // reverseCurve: Curves.decelerate,
  );

  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
    value: 1.0,
    upperBound: 1.0,
    lowerBound: .85,
  );

  late var devicePixelRatio = MediaQuery.devicePixelRatioOf(context);
}
