import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/feature/chat/domain/entities/user_entity.dart';
import 'package:navigation_2/feature/chat/domain/usecases/update_user_usecase.dart';

/// [UpdateUserRepository] là abstract class định nghĩa hợp đồng (contract) cho việc cập nhật người dùng.
/// Sẽ được triển khai chi tiết ở Data Layer.
abstract class UpdateUserRepository {
  /// Cập nhật thông tin người dùng theo [UserParam].
  /// Trả về [Either] chứa [Failure] nếu có lỗi hoặc [UserEntity] sau khi cập nhật thành công.
  Future<Either<Failure, UserEntity>> updateUser(UserParam param);
}
