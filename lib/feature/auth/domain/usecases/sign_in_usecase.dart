import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/core/usecase/usecase.dart';
import 'package:navigation_2/feature/auth/domain/entities/user_entity.dart';
import 'package:navigation_2/feature/auth/domain/repositories/auth_repository.dart';

/// [SignInUseCase] đảm nhiệm DUY NHẤT một nghiệp vụ: Đăng nhập.
/// Tuân thủ nguyên tắc Single Responsibility trong SOLID và Clean Architecture.
class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  /// Gọi hàm sign in thông qua [AuthRepository] (không phụ thuộc vào framework bên dưới là Firebase hay API riêng).
  Future<Either<Failure, UserEntity>> call(SignInParams params) {
    return repository.signIn(params.email, params.password);
  }
}

/// [SignInParams] là lớp mang dữ liệu đầu vào (parameters) cho [SignInUseCase].
class SignInParams {
  final String email;
  final String password;

  SignInParams({required this.email, required this.password});
}
