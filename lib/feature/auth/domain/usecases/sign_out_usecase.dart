import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/feature/auth/domain/repositories/auth_repository.dart';

/// [SignOutUseCase] đảm nhiệm nghiệp vụ Đăng xuất.
class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  /// Gọi hàm đăng xuất từ [AuthRepository], trả về [Failure] nếu có lỗi, ngược lại trả về void.
  Future<Either<Failure, void>> call() {
    return repository.signOut();
  }
}
