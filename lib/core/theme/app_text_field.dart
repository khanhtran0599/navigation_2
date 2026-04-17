import 'package:flutter/material.dart';
import 'package:navigation_2/core/theme/app_colors.dart';

class MyTextFieldOutLine extends StatelessWidget {
  const MyTextFieldOutLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyTextFieldPassword extends StatelessWidget {
  const MyTextFieldPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyTextFieldPrimary extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hinText;

  const MyTextFieldPrimary({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.hinText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGreyF0,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hinText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
