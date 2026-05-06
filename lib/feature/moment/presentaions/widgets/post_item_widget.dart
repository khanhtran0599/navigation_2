import 'package:flutter/material.dart';
import 'package:navigation_2/feature/moment/domain/entities/post_entity.dart';

/// [PostItemWidget] hiển thị thông tin tóm tắt của một bài đăng trong danh sách.
/// Widget này sử dụng [Card] và [ListTile] để trình bày dữ liệu.
class PostItemWidget extends StatelessWidget {
  /// Thực thể chứa dữ liệu của bài đăng cần hiển thị
  final PostEntity post;

  /// Sự kiện được kích hoạt khi người dùng nhấn vào bài đăng
  final VoidCallback onTap;

  const PostItemWidget({super.key, required this.post, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: onTap,
        // Hiển thị ID của bài đăng ở vị trí leading (bên trái)
        leading: Text(post.id.toString()),
        // Hiển thị tiêu đề bài đăng
        title: Text(post.title),
        // Hiển thị nội dung tóm tắt của bài đăng
        subtitle: Text(post.body),
      ),
    );
  }
}
