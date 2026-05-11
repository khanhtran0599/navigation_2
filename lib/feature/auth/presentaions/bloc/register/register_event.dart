import 'package:equatable/equatable.dart';

/// Các sự kiện (Event) liên quan đến quá trình nhập liệu và gửi yêu cầu Đăng ký.
abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

/// Sự kiện được kích hoạt khi người dùng bấm nút "Register" trên giao diện.
class RegisterSubmitted extends RegisterEvent {
  final String email;
  final String password;

  const RegisterSubmitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
