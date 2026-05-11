import 'package:equatable/equatable.dart';

/// Các sự kiện (Event) liên quan đến trạng thái đăng nhập chung của toàn ứng dụng.
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

/// Sự kiện được gọi khi ứng dụng vừa mới khởi động (để kiểm tra xem user đã đăng nhập trước đó chưa).
class AppStarted extends AuthEvent {}

/// Sự kiện được gọi sau khi user đăng nhập thành công.
class LoggedIn extends AuthEvent {}

/// Sự kiện được gọi khi user bấm nút Đăng xuất.
class LoggedOut extends AuthEvent {}
