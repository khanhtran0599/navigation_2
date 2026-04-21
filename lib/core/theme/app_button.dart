import 'package:flutter/material.dart';
import 'package:navigation_2/core/theme/app_colors.dart';

/// [MyButtonWithIcon] là Button kết hợp với Icon.
/// Hiện tại đang để trống để người dùng tự triển khai.
class MyButtonWithIcon extends StatelessWidget {
  const MyButtonWithIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/// [MyButtonPrimary] là nút bấm chính với màu nền Gradient thương hiệu.
class MyButtonPrimary extends StatelessWidget {
  /// Nội dung hiển thị trên nút
  final String title;

  /// Icon hiển thị bên cạnh chữ
  final Widget? icon;

  /// Nếu true, nút sẽ chiếm toàn bộ chiều ngang khả dụng
  final bool isFullWidth;

  /// Khoảng đệm ngang bên trong nút
  final double? paddingHorizontal;

  /// Hàm callback khi nhấn nút
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
        // Màu Gradient đặc trưng của app
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
          backgroundColor: Colors.transparent, // Làm trong suốt để thấy Gradient của Container
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

/// [MyButtonOutline] là nút bấm có viền.
/// Hiện tại đang để trống để người dùng tự triển khai.
class MyButtonOutline extends StatelessWidget {
  const MyButtonOutline({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

/// [MyButtonBase] là nút bấm cơ bản với màu nền tối (Base color).
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
        iconAlignment: IconAlignment.end, // Đặt icon ở cuối text
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

/// [MyButtonGrey] là nút bấm có màu xám, thường dùng cho các tác vụ phụ hoặc trạng thái vô hiệu hóa nhẹ.
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
