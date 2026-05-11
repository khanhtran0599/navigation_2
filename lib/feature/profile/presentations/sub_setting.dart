import 'package:flutter/material.dart';
import 'package:navigation_2/core/theme/app_text_styles.dart';

class MySettingPage extends StatefulWidget {
  const MySettingPage({super.key});

  @override
  State<MySettingPage> createState() => _MySettingPageState();
}

class _MySettingPageState extends State<MySettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"), // Tiêu đề trang Cá nhân
      ),
      body: Center(
        child: TextButton(
          onPressed: () {},
          child: Text("Setting Page", style: AppTextStyles.h1Bold),
        ),
      ),
    );
  }
}
