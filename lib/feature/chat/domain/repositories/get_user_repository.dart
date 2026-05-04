import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/feature/chat/domain/entities/user_entity.dart';

/// [GetUserRepository] là abstract class định nghĩa hợp đồng (contract) cho việc lấy danh sách người dùng.
/// Việc triển khai cụ thể sẽ nằm ở Data Layer.
abstract class GetUserRepository {
  /// Hàm lấy danh sách người dùng, trả về [Failure] hoặc danh sách [UserEntity].
  Future<Either<Failure, List<UserEntity>>> getUsers();
}
