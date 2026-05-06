import 'package:equatable/equatable.dart';
import 'package:navigation_2/feature/moment/domain/entities/post_entity.dart';

/// [PostEvent] là lớp cơ sở (base class) cho tất cả các sự kiện liên quan đến bài đăng.
/// Kế thừa [Equatable] để hỗ trợ so sánh đối tượng dễ dàng trong BLoC.
abstract class PostEvent extends Equatable {
  const PostEvent();
  @override
  List<Object> get props => [];
}

/// Sự kiện [GetPost] được gọi khi cần lấy danh sách các bài đăng (ví dụ: khi mở trang).
class GetPost extends PostEvent {}

/// Sự kiện [CreatePost] được gọi khi người dùng muốn tạo một bài đăng mới.
/// Yêu cầu đầu vào là một đối tượng [PostEntity].
class CreatePost extends PostEvent {
  /// Thông tin bài đăng cần tạo
  final PostEntity post;

  const CreatePost({required this.post});
  @override
  List<Object> get props => [post];
}

/// Sự kiện [DeletePost] được gọi khi người dùng muốn xóa một bài đăng.
/// Yêu cầu đầu vào là ID của bài đăng đó.
class DeletePost extends PostEvent {
  /// Mã định danh của bài đăng cần xóa
  final int postId;

  const DeletePost({required this.postId});
  @override
  List<Object> get props => [postId];
}
