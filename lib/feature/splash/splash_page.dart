import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_2/core/constants/icon_asset_url.dart';
import 'package:navigation_2/core/theme/app_text_styles.dart';

/// [MySplashPage] là màn hình chờ khi khởi động ứng dụng.
/// Thường dùng để hiển thị logo và thực hiện các tác vụ khởi tạo (load data, check login).
class MySplashPage extends StatefulWidget {
  const MySplashPage({super.key});

  @override
  State<MySplashPage> createState() => _MySplashPageState();
}

class _MySplashPageState extends State<MySplashPage> {
  @override
  void initState() {
    // Giả lập quá trình tải dữ liệu hoặc kiểm tra trạng thái đăng nhập (ví dụ: token, session)
    Future.delayed(const Duration(seconds: 3), () {
      // Sau 3 giây, điều hướng sang màn hình Home
      // Sử dụng context.go để thay thế hoàn toàn stack hiện tại, tránh người dùng quay lại màn hình splash
      if (mounted) {
        context.go("/home");
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Đảm bảo nền trắng sạch sẽ cho splash
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Hiển thị logo ứng dụng kết hợp cả PNG (icon) và SVG (text logo)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(AppIconUrl.iconAppPng, width: 40),
                const SizedBox(width: 10),
                SvgPicture.asset(AppIconUrl.iconApp),
              ],
            ),
            const SizedBox(height: 20),
            // Thông điệp chào mừng hoặc tên ứng dụng
            Text("Chào mừng bạn!", style: AppTextStyles.h1Bold),
          ],
        ),
      ),
    );
  }
}
