import 'package:flutter/material.dart';

/// [MyPlaceDogWalkDetailPage] là trang hiển thị thông tin chi tiết của một địa điểm dắt chó đi dạo.
/// Trang này là một "sub-page" trong nhánh điều hướng Home, thể hiện cách GoRouter quản lý path parameters.
class MyPlaceDogWalkDetailPage extends StatefulWidget {
  /// Mã ID của địa điểm được truyền từ URL (ví dụ: /home/myDetail/1)
  final String id;

  const MyPlaceDogWalkDetailPage({super.key, required this.id});

  @override
  State<MyPlaceDogWalkDetailPage> createState() =>
      _MyPlaceDogWalkDetailPageState();
}

class _MyPlaceDogWalkDetailPageState extends State<MyPlaceDogWalkDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chi tiết: ${widget.id}"), // Hiển thị ID để kiểm tra tham số điều hướng
      ),
      body: Center(
        child: Text("Thông tin chi tiết cho địa điểm có ID: ${widget.id}"),
      ),
    );
  }
}
