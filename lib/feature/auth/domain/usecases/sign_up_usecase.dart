import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/feature/auth/domain/entities/user_entity.dart';
import 'package:navigation_2/feature/auth/domain/repositories/auth_repository.dart';

/// [SignUpUseCase] đảm nhiệm nghiệp vụ duy nhất: Đăng ký tài khoản mới.
class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  /// Nhận [SignUpParams] và gọi hàm đăng ký từ [AuthRepository].
  Future<Either<Failure, UserEntity>> call(SignUpParams params) {
    return repository.signUp(params.email, params.password, params.name);
  }
}

/// Dữ liệu đầu vào cho quá trình đăng ký.
class SignUpParams {
  final String email;
  final String password;
  final String name;

  SignUpParams({required this.email, required this.password, required this.name});
}
