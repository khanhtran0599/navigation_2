import 'package:equatable/equatable.dart';
import 'package:navigation_2/feature/moment/domain/entities/comment_entity.dart';

/// [CommentState] là lớp cơ sở (base class) cho tất cả các trạng thái của comment.
/// Kế thừa [Equatable] để tối ưu hóa việc build lại UI khi trạng thái không thay đổi.
abstract class CommentState extends Equatable {
  const CommentState();
  @override
  List<Object> get props => [];
}

/// [CommentInitial] là trạng thái khởi tạo mặc định ban đầu của BLoC.
class CommentInitial extends CommentState {}

/// [CommentLoading] là trạng thái khi đang gọi API hoặc xử lý dữ liệu để lấy danh sách comment.
class CommentLoading extends CommentState {}

/// [CommentLoaded] là trạng thái khi đã lấy danh sách comment thành công.
class CommentLoaded extends CommentState {
  /// Danh sách các comment nhận được từ API/Local
  final List<CommentEntity> comments;

  const CommentLoaded({required this.comments});
  @override
  List<Object> get props => [comments]; // Sửa lỗi props để Equatable so sánh đúng
}

/// [CommentError] là trạng thái khi có lỗi xảy ra (ví dụ: lỗi mạng, lỗi parse dữ liệu).
class CommentError extends CommentState {
  /// Thông báo lỗi chi tiết
  final String message;

  const CommentError({required this.message});
  @override
  List<Object> get props => [message]; // Sửa lỗi props để Equatable so sánh đúng
}
