import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/feature/chat/data/data_source/data_remote.dart';
import 'package:navigation_2/feature/chat/domain/entities/user_entity.dart';
import 'package:navigation_2/feature/chat/domain/repositories/update_user_repository.dart';
import 'package:navigation_2/feature/chat/domain/usecases/update_user_usecase.dart';

/// [UpdateUserRepositoryImpl] là lớp triển khai thực tế của [UpdateUserRepository].
/// Nằm ở Data Layer, chịu trách nhiệm gọi đến [UpdateUserRemoteSource] để cập nhật dữ liệu
/// và xử lý lỗi (nếu có) trước khi trả về cho Domain Layer.
class UpdateUserRepositoryImpl implements UpdateUserRepository {
  /// Nguồn dữ liệu từ xa (API) để cập nhật người dùng
  final UpdateUserRemoteSource updateUserRemoteSource;

  /// Khởi tạo [UpdateUserRepositoryImpl] với [updateUserRemoteSource].
  UpdateUserRepositoryImpl({required this.updateUserRemoteSource});

  /// Triển khai hàm cập nhật thông tin người dùng.
  /// Bắt lỗi ngoại lệ và trả về [ServerFailure] nếu cập nhật không thành công.
  @override
  Future<Either<Failure, UserEntity>> updateUser(UserParam param) async {
    try {
      final resutl = await updateUserRemoteSource.getUsers(param);
      return Right(resutl);
    } catch (e) {
      return Left(ServerFalure(e.toString()));
    }
  }
}
