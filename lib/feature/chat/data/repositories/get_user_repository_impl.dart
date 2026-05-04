import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/feature/chat/data/data_source/data_remote.dart';
import 'package:navigation_2/feature/chat/domain/entities/user_entity.dart';
import 'package:navigation_2/feature/chat/domain/repositories/get_user_repository.dart';

/// [GetUserRepositoryImpl] là lớp triển khai thực tế của [GetUserRepository].
/// Nằm ở Data Layer, chịu trách nhiệm gọi đến [GetUserRemoteSource] để lấy dữ liệu
/// và xử lý lỗi (nếu có) trước khi trả về cho Domain Layer.
class GetUserRepositoryImpl implements GetUserRepository {
  /// Nguồn dữ liệu từ xa (API)
  final GetUserRemoteSource getUserRemoteSource;

  /// Khởi tạo [GetUserRepositoryImpl] cần truyền vào [getUserRemoteSource].
  GetUserRepositoryImpl({required this.getUserRemoteSource});

  /// Triển khai hàm lấy danh sách người dùng.
  /// Bắt lỗi từ [getUserRemoteSource] và chuyển đổi thành [ServerFailure] nếu có lỗi.
  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    try {
      final resutl = await getUserRemoteSource.getUsers();
      return Right(resutl);
    } catch (e) {
      return Left(ServerFalure(e.toString()));
    }
  }
}
