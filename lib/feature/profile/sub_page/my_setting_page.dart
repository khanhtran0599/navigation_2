import 'package:flutter/material.dart';

/// [MySettingPage] cho phép người dùng cấu hình các tùy chọn trong ứng dụng.
/// Đây là trang con (sub-page) của Profile.
class MySettingPage extends StatefulWidget {
  const MySettingPage({super.key});

  @override
  State<MySettingPage> createState() => _MySettingPageState();
}

class _MySettingPageState extends State<MySettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Setting Page")),
    );
  }
}
