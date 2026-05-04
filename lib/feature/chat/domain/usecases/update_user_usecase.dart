import 'package:dartz/dartz.dart';

import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/core/usecase/usecase.dart';
import 'package:navigation_2/feature/chat/domain/entities/user_entity.dart';
import 'package:navigation_2/feature/chat/domain/repositories/update_user_repository.dart';

/// [UpdateUsersUseCase] chịu trách nhiệm xử lý logic nghiệp vụ cập nhật thông tin người dùng.
/// Cần truyền vào [UserParam] chứa id và dữ liệu người dùng cần cập nhật.
class UpdateUsersUseCase implements UseCase<UserEntity, UserParam> {
  /// Repository xử lý việc cập nhật dữ liệu
  final UpdateUserRepository updateUserRepository;

  /// Khởi tạo [UpdateUsersUseCase] với [updateUserRepository].
  UpdateUsersUseCase({required this.updateUserRepository});

  /// Thực thi việc cập nhật người dùng thông qua repository.
  /// Trả về [Either] chứa [Failure] nếu có lỗi, hoặc [UserEntity] nếu thành công.
  @override
  Future<Either<Failure, UserEntity>> call(UserParam params) async {
    return await updateUserRepository.updateUser(params);
  }
}

/// [UserParam] chứa thông tin cần thiết để truyền vào use case cập nhật người dùng.
class UserParam {
  /// ID của người dùng cần cập nhật
  final int id;
  
  /// Thực thể chứa thông tin mới của người dùng
  UserEntity userEntity;

  /// Khởi tạo [UserParam] yêu cầu bắt buộc phải có [id] và [userEntity].
  UserParam({required this.id, required this.userEntity});
}
