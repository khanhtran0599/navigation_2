import 'package:equatable/equatable.dart';

/// Các trạng thái (State) quản lý màn hình Đăng nhập (LoginPage).
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

/// Trạng thái ban đầu, giao diện ở chế độ chờ nhập liệu.
class LoginInitial extends LoginState {}

/// Trạng thái đang xử lý API (hiển thị vòng xoay loading).
class LoginLoading extends LoginState {}

/// Trạng thái đăng nhập thành công.
class LoginSuccess extends LoginState {}

/// Trạng thái đăng nhập thất bại. Chứa thông báo lỗi để hiển thị lên SnackBar.
class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({required this.error});

  @override
  List<Object> get props => [error];
}
