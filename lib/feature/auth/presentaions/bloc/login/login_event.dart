import 'package:equatable/equatable.dart';

/// Các sự kiện (Event) liên quan đến quá trình nhập liệu và gửi yêu cầu Đăng nhập.
abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

/// Sự kiện được kích hoạt khi người dùng bấm nút "Login" trên giao diện.
class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  const LoginSubmitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
