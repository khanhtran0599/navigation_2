import 'package:flutter/material.dart';
import 'package:navigation_2/core/theme/app_colors.dart';

/// [MyTextFieldOutLine] là một custom TextField có dạng viền (Outline).
/// Hiện tại đang để trống để người dùng tự triển khai.
class MyTextFieldOutLine extends StatelessWidget {
  const MyTextFieldOutLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/// [MyTextFieldPassword] là một custom TextField dành cho mật khẩu.
/// Có tính năng ẩn/hiện mật khẩu (hiện tại đang để trống).
class MyTextFieldPassword extends StatelessWidget {
  const MyTextFieldPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/// [MyTextFieldPrimary] là TextField chủ đạo được sử dụng trong ứng dụng.
/// Có nền xám nhạt, bo góc và hỗ trợ prefix/suffix icon.
class MyTextFieldPrimary extends StatelessWidget {
  /// Icon hiển thị ở đầu TextField
  final Widget? prefixIcon;

  /// Icon hiển thị ở cuối TextField
  final Widget? suffixIcon;

  /// Văn bản gợi ý khi TextField trống
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
          contentPadding: EdgeInsets.only(left: 16),
          hintText: hinText,
          // Cấu hình prefix icon với padding hợp lý
          prefix: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: prefixIcon,
            ),
          ),
          suffix: suffixIcon,
          // Loại bỏ viền mặc định vì đã sử dụng Container để đổ nền
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
