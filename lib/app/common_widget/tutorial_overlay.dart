import 'package:flutter/material.dart';
import '../helper/all_imports.dart';
import '../modules/tutorial/views/tutorial_view.dart';

class TutorialOverlay extends StatelessWidget {
  final Widget child;
  
  const TutorialOverlay({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        // Tutorial overlay will be shown on top when needed
        TutorialView(),
      ],
    );
  }
}

// Tutorial Helper Functions
class TutorialHelper {
  // Show tutorial for first-time users
  static void showTutorialIfNeeded() {
    final controller = Get.find<TutorialController>();
    if (controller.isFirstTimeUser.value) {
      controller.startTutorial();
    }
  }
  
  // Show What's New for returning users
  static void showWhatsNewIfNeeded() {
    final controller = Get.find<TutorialController>();
    if (controller.showWhatsNew.value) {
      controller.showWhatsNewDialog();
    }
  }
  
  // Check if user should see tutorial
  static bool shouldShowTutorial() {
    final controller = Get.find<TutorialController>();
    return controller.isFirstTimeUser.value;
  }
  
  // Check if user should see What's New
  static bool shouldShowWhatsNew() {
    final controller = Get.find<TutorialController>();
    return controller.showWhatsNew.value;
  }
  
  // Mark feature as seen
  static void markFeatureAsSeen(String featureId) {
    final controller = Get.find<TutorialController>();
    controller.markFeatureAsSeen(featureId);
  }
  
  // Reset tutorial (for testing)
  static void resetTutorial() {
    final controller = Get.find<TutorialController>();
    controller.resetTutorial();
  }
}

// Tutorial Step Indicator
class TutorialStepIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final Color activeColor;
  final Color inactiveColor;
  
  const TutorialStepIndicator({
    Key? key,
    required this.currentStep,
    required this.totalSteps,
    this.activeColor = AppColors.primary,
    this.inactiveColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.px),
          width: index == currentStep ? 24.px : 8.px,
          height: 8.px,
          decoration: BoxDecoration(
            color: index <= currentStep ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(4.px),
          ),
        );
      }),
    );
  }
}

// Feature Badge Widget
class FeatureBadge extends StatelessWidget {
  final String text;
  final Color color;
  final IconData? icon;
  
  const FeatureBadge({
    Key? key,
    required this.text,
    this.color = AppColors.success,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 4.px),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.px),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 12.px,
              color: Colors.white,
            ),
            SizedBox(width: 4.px),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 10.px,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Tutorial Tooltip
class TutorialTooltip extends StatelessWidget {
  final String message;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;
  final Color textColor;
  
  const TutorialTooltip({
    Key? key,
    required this.message,
    required this.child,
    this.padding,
    this.backgroundColor = Colors.black87,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      padding: padding ?? EdgeInsets.all(12.px),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.px),
      ),
      textStyle: TextStyle(
        color: textColor,
        fontSize: 14.px,
      ),
      child: child,
    );
  }
}
