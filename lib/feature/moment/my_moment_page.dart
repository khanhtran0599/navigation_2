import 'package:flutter/material.dart';

/// [MyMomentPage] hiển thị các khoảnh khắc, bài đăng của người dùng và bạn bè.
/// Đây là một nhánh chính trong Bottom Navigation Bar để xem các tin đăng mới nhất.
class MyMomentPage extends StatefulWidget {
  const MyMomentPage({super.key});

  @override
  State<MyMomentPage> createState() => _MyMomentPageState();
}

class _MyMomentPageState extends State<MyMomentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Moments Page")),
    );
  }
}