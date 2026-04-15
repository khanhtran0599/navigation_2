import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_2/core/theme/app_text_styles.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profle Page")),
      body: Center(
        child: TextButton(
          onPressed: () {
            context.go("/profile/setting");
          },
          child: Text("Go Setting Page", style: AppTextStyles.h1_bold),
        ),
      ),
    );
  }
}
