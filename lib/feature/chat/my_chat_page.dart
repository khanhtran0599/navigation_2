import 'package:flutter/material.dart';

/// [MyChatPage] hiển thị danh sách các cuộc hội thoại và tin nhắn của người dùng.
/// Đây là một nhánh chính trong Bottom Navigation Bar.
class MyChatPage extends StatefulWidget {

  const MyChatPage({super.key});

  @override
  State<MyChatPage> createState() => _MyChatPageState();
}

class _MyChatPageState extends State<MyChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat Page")),
    );
  }
}