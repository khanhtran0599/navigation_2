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
}
