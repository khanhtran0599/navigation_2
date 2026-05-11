import 'package:equatable/equatable.dart';

/// Các trạng thái (State) quản lý màn hình Đăng ký (RegisterPage).
abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

/// Trạng thái ban đầu, giao diện ở chế độ chờ nhập liệu.
class RegisterInitial extends RegisterState {}

/// Trạng thái đang xử lý API (hiển thị vòng xoay loading).
class RegisterLoading extends RegisterState {}

/// Trạng thái đăng ký thành công.
class RegisterSuccess extends RegisterState {}

/// Trạng thái đăng ký thất bại. Chứa thông báo lỗi để hiển thị lên SnackBar.
class RegisterFailure extends RegisterState {
  final String error;

  const RegisterFailure({required this.error});

  @override
  List<Object> get props => [error];
}
