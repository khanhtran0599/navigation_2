import 'package:flutter/animation.dart';

/// [AppColors] định nghĩa bảng màu (Palette) chính cho toàn bộ ứng dụng.
/// Giúp quản lý màu sắc tập trung và dễ dàng thay đổi giao diện (re-branding).
class AppColors {
  // --- Nhóm màu nền (Background) ---
  static final Color base = const Color(0xff161616);
  static final Color white = const Color(0xffffffff);
  static final Color lightGrey = const Color(0xffAEAEB2);
  static final Color lightGreyF2 = const Color(0xffF2F2F2);

  static final Color lightGreyF0 = const Color(0xffF0F0F0);

  static final Color lightGreyA1 = const Color(0xffA1A1A1);

  static final Color greyB0 = const Color(0xffB0B0B0);

  // --- Nhóm màu thương hiệu (Brand Colors) ---
  static final Color primary = const Color(0xffFE8F4B);
  static final Color secondary = const Color(0xffFB724C);

  // --- Nhóm màu trạng thái (Action/Status Colors) ---
  static final Color errorColor = const Color(0xffFB724C);
  static final Color successColor = const Color(0xffFB724C);

  // --- Nhóm màu chữ (Text Colors) ---
  static final Color lightText = const Color(0xffFB724C);
}
