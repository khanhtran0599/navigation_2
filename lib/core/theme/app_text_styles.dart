// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:navigation_2/core/theme/app_colors.dart';

/// [AppTextStyles] quản lý các kiểu chữ (typography) thống nhất cho ứng dụng.
class AppTextStyles {
  // Kiểu chữ tiêu đề chính
  static final TextStyle h1 = TextStyle(color: AppColors.base, fontSize: 24);

  // Kiểu chữ tiêu đề chính (Bold)
  static final TextStyle h1_bold = TextStyle(
    color: AppColors.base,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle h2 = TextStyle(
    color: AppColors.base,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle body = TextStyle(
    color: AppColors.base,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static TextStyle coppyWidth({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      color: color ?? AppColors.base,
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight ?? FontWeight.normal,
    );
  }
}
