import 'package:chatsy/app/Localization/language_en.dart';
import 'package:chatsy/app/helper/image_path.dart';

import '../../../Localization/local_language.dart';
import '../../../common_widget/common_screen.dart';
import '../../../helper/all_imports.dart';
import '../../purchase/controllers/purchase_controller.dart';
import '../../themePage/views/selected_view.dart';
import '../controllers/language_page_controller.dart';

class LanguagePageView extends GetView<LanguagePageController> {
  const LanguagePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LanguagePageController>(
      init: LanguagePageController(),
      builder: (controller) {
        controller.languageList = [
          SubscriptionCarousel(
            title: LanguageEn().english,
            subTitle: Utils.languageCodeEn,
            description: ImagePath.icEnglish,
          ),
          SubscriptionCarousel(
            title: LanguageEn().spanish,
            subTitle: Utils.languageCodeEs,
            description: ImagePath.icSpanish,
          ),
          SubscriptionCarousel(
            title: LanguageEn().hindi,
            subTitle: Utils.languageCodeHin,
            description: ImagePath.icIndia,
          ),
          SubscriptionCarousel(
            title: LanguageEn().french,
            subTitle: Utils.languageCodeFr,
            description: ImagePath.icFrench,
          ),
          SubscriptionCarousel(
            title: LanguageEn().portuguese,
            subTitle: Utils.languageCodePor,
            description: ImagePath.icPortuguese,
          ),
        ];
        controller.count.value =
            (Utils.languageCodeDefault == Utils.languageCodeEn)
                ? 0
                : (Utils.languageCodeDefault == Utils.languageCodeEs)
                ? 1
                : (Utils.languageCodeDefault == Utils.languageCodeHin)
                ? 2
                : (Utils.languageCodeDefault == Utils.languageCodeFr)
                ? 3
                : 4;

        return Obx(() {
          controller.count.value;
          return CommonScreen(
            backgroundColor: AppColors().backgroundColor1,
            title: Languages.of(context)!.chooseYourLanguage,
            // appbarBackgroundColor: AppColors().backgroundColor1,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 10.px),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.languageList.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 12.px); /*GestureDetector(
                          onTap: () {
                            controller.count.value = index;
                          },
                          child: Column(
                            children: [SizedBox(height: 12.px), Container(height: 2, color: AppColors().borderColor2)],
                          ),
                        );*/
                    },
                    itemBuilder: (context, index) {
                      SubscriptionCarousel data = controller.languageList[index];
                      return SelectedView(
                        onTap: () {
                          HapticFeedback.mediumImpact();

                          controller.count.value = index;
                          controller.changeLanguageAPI(
                            languageCode:
                                controller.languageList[controller.count.value].subTitle ?? "",
                          );
                        },
                        data: data,
                        index: index,
                        count: controller.count,
                      );
                      /*GestureDetector(
                          onTap: () {
                            controller.count.value = index;
                          },
                          child: CommonContainer(
                              radius: 10.px,
                              padding: EdgeInsets.symmetric(horizontal: 17.px, vertical: (data.isSelected) ? 10.px : 17.px),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        AppText(
                                          data.image,
                                        ),
                                        SizedBox(width: 10.px),
                                        Expanded(
                                          child: AppText(
                                            data.title,
                                            color: AppColors().darkAndWhite,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  AnimCheckBox(
                                    duration: Durations.long4,
                                    selected: (controller.count.value == index),
                                  ),
                                  // Container(
                                  //   padding: EdgeInsets.all(4.px),
                                  //   decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: (controller.count.value == index) ? AppColors.primary : AppColors().borderColor2, width: 2)),
                                  //   child: Container(
                                  //     height: 12.px,
                                  //     width: 12.px,
                                  //     decoration: BoxDecoration(
                                  //       shape: BoxShape.circle,
                                  //       color: (controller.count.value == index) ? AppColors.primary : AppColors.transparent,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              )),
                        );*/
                    },
                  ),
                  SizedBox(height: 20.px),
                  // CommonButton(
                  //     onTap: () {
                  //       controller.changeLanguageAPI(languageCode: controller.languageList[controller.count.value].subTitle ?? "");
                  //     },
                  //     title: Languages.of(context)!.save),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}

class AnimCheckBox extends ImplicitlyAnimatedWidget {
  final bool selected;

  const AnimCheckBox({
    super.key,
    this.dimensions = 24.0,
    required this.selected,
    this.decoration,
    required super.duration,
    this.checkedWidget,
    this.padding,
    this.border = true,
  });

  const AnimCheckBox.done({
    required this.selected,
    super.key,
    this.decoration,
    this.dimensions = 24.0,
    required super.duration,
    required this.checkedWidget,
    this.border = false,
    this.padding = EdgeInsets.zero,
  }) : assert(checkedWidget != null);

  final bool border;

  final Decoration? decoration;

  final double dimensions;

  final EdgeInsets? padding;

  final Widget? checkedWidget;

  @override
  AnimatedWidgetBaseState<AnimCheckBox> createState() => _AnimCheckBoxState();
}

class _AnimCheckBoxState extends AnimatedWidgetBaseState<AnimCheckBox> {
  late final parent = CurvedAnimation(parent: animation, curve: Curves.elasticOut);

  @override
  Widget build(BuildContext context) {
    var parent = CurvedAnimation(parent: animation, curve: Curves.elasticOut);
    var animScale = _scale!.animate(parent);
    var color = _color?.evaluate(parent);

    Widget child = ClipOval(
      child: widget.checkedWidget ?? const ColoredBox(color: AppColors.primary),
    );
    if (widget.padding != EdgeInsets.zero) {
      child = Padding(padding: widget.padding ?? EdgeInsets.all(4.px), child: child);
    }

    return SizedBox.square(
      dimension: widget.dimensions.px,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  color != null
                      ? Border.all(color: color, width: 2)
                      : Border.all(color: AppColors().borderColor2, width: 2),
            ),
          ),
          Visibility(
            visible: animScale.value > 0.0,
            child: Transform.scale(scale: _scale!.evaluate(parent), child: child),
          ),
        ],
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _scale =
        visitor(
              _scale,
              widget.selected ? 1.0 : 0.0,
              (targetValue) => Tween<double>(begin: targetValue),
            )
            as Tween<double>?;
    if (widget.border) {
      _color =
          visitor(
                _color,
                widget.selected ? AppColors.primary : AppColors().borderColor2,
                (targetValue) => ColorTween(begin: targetValue),
              )
              as ColorTween?;
    }
  }

  ColorTween? _color;

  Tween<double>? _scale;
}
