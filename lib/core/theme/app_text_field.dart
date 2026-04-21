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
    return TextField(
      // Căn chỉnh văn bản nhập vào theo chiều dọc cho chuẩn với icon
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: hinText,
        hintStyle: const TextStyle(color: Colors.grey),
        filled: true,
        fillColor: AppColors.lightGreyF0, // Màu xám nhạt của bạn
        // Sử dụng prefixIcon để icon luôn căn giữa chuẩn xác
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: prefixIcon,
              )
            : null,

        // Giới hạn kích thước để prefixIcon không chiếm quá nhiều chỗ
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),

        suffixIcon: suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: suffixIcon,
              )
            : null,

        suffixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),

        // Bo góc và bỏ viền
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    );
  }
}
