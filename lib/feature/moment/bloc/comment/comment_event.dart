import 'package:equatable/equatable.dart';
import 'package:navigation_2/feature/moment/domain/entities/comment_entity.dart';
import 'package:navigation_2/feature/moment/domain/usecases/get_comment_usecase.dart';

/// [CommentEvent] là lớp cơ sở (base class) cho tất cả các sự kiện liên quan đến comment.
/// Kế thừa [Equatable] để hỗ trợ so sánh đối tượng dễ dàng trong BLoC.
abstract class CommentEvent extends Equatable {
  const CommentEvent();
  @override
  List<Object> get props => [];
}

/// Sự kiện [GetComment] được gọi khi cần lấy danh sách các comment (ví dụ: khi mở trang).
class GetComment extends CommentEvent {
  final CommentParam param;

  const GetComment({required this.param});
   @override
  List<Object> get props => [param];
}

/// Sự kiện [CreateComment] được gọi khi người dùng muốn tạo một comment mới.
/// Yêu cầu đầu vào là một đối tượng [CommentEntity].
class CreateComment extends CommentEvent {
  /// Thông tin comment cần tạo
  final CommentEntity comment;

  const CreateComment({required this.comment});
  @override
  List<Object> get props => [comment];
}

/// Sự kiện [DeleteComment] được gọi khi người dùng muốn xóa một comment.
/// Yêu cầu đầu vào là ID của comment đó.
class DeleteComment extends CommentEvent {
  /// Mã định danh của comment cần xóa
  final int commentId;

  const DeleteComment({required this.commentId});
  @override
  List<Object> get props => [commentId];
}
