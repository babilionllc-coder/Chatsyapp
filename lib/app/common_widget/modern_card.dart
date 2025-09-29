import 'package:flutter/material.dart';
import 'package:chatsy/app/helper/app_colors.dart';
import 'package:chatsy/extension.dart';

class ModernCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final double? borderRadius;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;
  final bool isGradient;
  final List<Color>? gradientColors;
  final double? elevation;

  const ModernCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderRadius,
    this.boxShadow,
    this.onTap,
    this.isGradient = false,
    this.gradientColors,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    Widget cardContent = Container(
      padding: padding ?? EdgeInsets.all(16.px),
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? (isLight ? AppColors.cardBackground : AppColors.cardBackgroundDark),
        borderRadius: BorderRadius.circular(borderRadius ?? 16.px),
        boxShadow: boxShadow ?? [
          BoxShadow(
            color: isLight ? AppColors.shadow : AppColors.shadowDark,
            blurRadius: 8.px,
            offset: Offset(0, 2.px),
            spreadRadius: 0,
          ),
        ],
        gradient: isGradient ? LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors ?? [AppColors.primary, AppColors.primaryGradient],
        ) : null,
      ),
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: cardContent,
      );
    }

    return cardContent;
  }
}

class GradientCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final List<Color>? colors;
  final double? borderRadius;
  final VoidCallback? onTap;

  const GradientCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.colors,
    this.borderRadius,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      onTap: onTap,
      isGradient: true,
      gradientColors: colors ?? [AppColors.primary, AppColors.primaryGradient],
      child: child,
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? icon;
  final VoidCallback? onTap;
  final bool isPremium;
  final Color? iconColor;

  const FeatureCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon,
    this.onTap,
    this.isPremium = false,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Container(
                  padding: EdgeInsets.all(12.px),
                  decoration: BoxDecoration(
                    color: (iconColor ?? AppColors.primary).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.px),
                  ),
                  child: Icon(
                    Icons.extension,
                    color: iconColor ?? AppColors.primary,
                    size: 24.px,
                  ),
                ),
                SizedBox(width: 12.px),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16.px,
                        fontWeight: FontWeight.w600,
                        color: isLight ? AppColors.black : AppColors.white,
                      ),
                    ),
                    SizedBox(height: 4.px),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14.px,
                        color: AppColors.grey1,
                      ),
                    ),
                  ],
                ),
              ),
              if (isPremium)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 4.px),
                  decoration: BoxDecoration(
                    color: AppColors.warning,
                    borderRadius: BorderRadius.circular(12.px),
                  ),
                  child: Text(
                    'PRO',
                    style: TextStyle(
                      fontSize: 10.px,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

