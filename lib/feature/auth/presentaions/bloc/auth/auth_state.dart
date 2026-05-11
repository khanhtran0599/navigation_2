import 'package:equatable/equatable.dart';
import 'package:navigation_2/feature/auth/domain/entities/user_entity.dart';

/// Các trạng thái (State) quản lý phiên làm việc của người dùng trong hệ thống.
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

/// Trạng thái ban đầu khi chưa biết rõ người dùng đã đăng nhập hay chưa (thường dùng ở Splash screen).
class AuthInitial extends AuthState {}

/// Trạng thái đã xác thực thành công. Lưu trữ thông tin [UserEntity].
class Authenticated extends AuthState {
  final UserEntity user;

  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// Trạng thái chưa đăng nhập hoặc đã bị đăng xuất.
class Unauthenticated extends AuthState {}
