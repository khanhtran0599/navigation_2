import 'package:equatable/equatable.dart';
import 'package:navigation_2/feature/moment/domain/entities/post_entity.dart';

/// [PostState] là lớp cơ sở (base class) cho tất cả các trạng thái của bài đăng.
/// Kế thừa [Equatable] để tối ưu hóa việc build lại UI khi trạng thái không thay đổi.
abstract class PostState extends Equatable {
  const PostState();
  @override
  List<Object> get props => [];
}

/// [PostInitial] là trạng thái khởi tạo mặc định ban đầu của BLoC.
class PostInitial extends PostState {}

/// [PostLoading] là trạng thái khi đang gọi API hoặc xử lý dữ liệu để lấy danh sách bài đăng.
class PostLoading extends PostState {}

/// [PostLoaded] là trạng thái khi đã lấy danh sách bài đăng thành công.
class PostLoaded extends PostState {
  /// Danh sách các bài đăng nhận được từ API/Local
  final List<PostEntity> posts;

  const PostLoaded({required this.posts});
  @override
  List<Object> get props => [posts]; // Sửa lỗi props để Equatable so sánh đúng
}

/// [PostError] là trạng thái khi có lỗi xảy ra (ví dụ: lỗi mạng, lỗi parse dữ liệu).
class PostError extends PostState {
  /// Thông báo lỗi chi tiết
  final String message;

  const PostError({required this.message});
  @override
  List<Object> get props => [message]; // Sửa lỗi props để Equatable so sánh đúng
}
