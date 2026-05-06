import 'package:flutter/material.dart';

/// [DetailPostPage] là trang hiển thị thông tin chi tiết của một bài đăng cụ thể.
class DetailPostPage extends StatefulWidget {
  /// Mã ID của bài đăng cần xem chi tiết, được truyền vào từ màn hình trước
  final int postID;
  const DetailPostPage({super.key, required this.postID});

  @override
  State<DetailPostPage> createState() => _DetailPostPageState();
}

class _DetailPostPageState extends State<DetailPostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Hiển thị tiêu đề kèm ID bài đăng để nhận biết
        title: Text("Chi tiết bài đăng: ${widget.postID}"),
      ),
      body: Center(
        child: Text("Nội dung chi tiết cho bài đăng ID = ${widget.postID}"),
      ),
    );
  }
}
