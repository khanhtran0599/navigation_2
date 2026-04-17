import 'package:flutter/material.dart';
import 'package:navigation_2/core/theme/app_colors.dart';

class MyButtonWithIcon extends StatelessWidget {
  const MyButtonWithIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyButtonPrimary extends StatelessWidget {
  final String title;
  final Widget? icon;
  final bool isFullWidth;

  final double? paddingHorizontal;
  final VoidCallback onPress;

  const MyButtonPrimary({
    super.key,
    required this.title,
    this.icon,
    this.isFullWidth = false,
    required this.onPress,
    this.paddingHorizontal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.secondary, AppColors.primary],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: ElevatedButton.icon(
        onPressed: onPress,
        icon: icon,
        label: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.white,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal ?? 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(14),
          ),
        ),
      ),
    );
  }
}

class MyButtonOutline extends StatelessWidget {
  const MyButtonOutline({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyButtonBase extends StatelessWidget {
  final String title;
  final double fontSize;

  final double paddingHorizontal;
  final Widget? icon;
  final bool isFullWidth;
  final VoidCallback onPress;

  const MyButtonBase({
    super.key,
    required this.title,
    this.icon,
    this.isFullWidth = false,
    required this.onPress,
    this.fontSize = 14,
    this.paddingHorizontal = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFullWidth ? double.infinity : null,

      decoration: BoxDecoration(
        color: AppColors.base,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ElevatedButton.icon(
        iconAlignment: IconAlignment.end,
        icon: icon,
        onPressed: onPress,

        label: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
          foregroundColor: AppColors.white,
          backgroundColor: AppColors.base,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(14),
          ),
        ),
      ),
    );
  }
}

class MyButtonGrey extends StatelessWidget {
  final String title;
  final Widget? icon;
  final bool isFullWidth;
  final VoidCallback onPress;
  const MyButtonGrey({
    super.key,
    required this.title,
    this.icon,
    this.isFullWidth = false,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isFullWidth ? double.infinity : null,

      decoration: BoxDecoration(
        color: AppColors.lightGreyA1,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ElevatedButton.icon(
        iconAlignment: IconAlignment.end,
        icon: icon,
        onPressed: onPress,
        label: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.greyB0,
          backgroundColor: AppColors.lightGreyA1,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(14),
          ),
        ),
      ),
    );
  }
}
