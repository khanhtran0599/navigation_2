import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/feature/auth/domain/entities/user_entity.dart';
import 'package:navigation_2/feature/auth/domain/repositories/auth_repository.dart';

/// [GetCurrentUserUseCase] đảm nhiệm việc lấy thông tin người dùng đang lưu trong phiên làm việc hiện tại (session).
class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  /// Gọi hàm lấy User hiện tại từ [AuthRepository]. Trả về null nếu không có người dùng nào đang đăng nhập.
  Future<Either<Failure, UserEntity?>> call() {
    return repository.getCurrentUser();
  }
}
