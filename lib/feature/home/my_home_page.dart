import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// [MyHomePage] là trang chủ chính của ứng dụng.
/// Hiển thị nội dung tổng quan và các phím tắt điều hướng.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: Center(
        child: TextButton(
          onPressed: () {
            // Điều hướng đến trang con của Home
            context.go("/home/subHome");
          },
          child: const Text("Go sub home"),
        ),
      ),
    );
  }
}
