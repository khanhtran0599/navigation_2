import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_2/core/theme/app_text_styles.dart';

/// [MyProfilePage] hiển thị thông tin cá nhân của người dùng.
/// Đây là một nhánh chính trong Bottom Navigation Bar, cho phép quản lý tài khoản và truy cập cài đặt.
class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"), // Tiêu đề trang Cá nhân
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            // Điều hướng sâu vào trang cài đặt (sub-route của nhánh profile)
            context.go("/profile/setting");
          },
          child: Text("Go Setting Page", style: AppTextStyles.h1_bold),
        ),
      ),
    );
  }
}
