import 'package:dartz/dartz.dart';

import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/core/usecase/usecase.dart';
import 'package:navigation_2/feature/chat/domain/entities/user_entity.dart';
import 'package:navigation_2/feature/chat/domain/repositories/update_user_repository.dart';

class UpdateUsersUseCase implements UseCase<UserEntity, UserParam> {
  final UpdateUserRepository updateUserRepository;

  UpdateUsersUseCase({required this.updateUserRepository});

  @override
  Future<Either<Failure, UserEntity>> call(UserParam params) async {
    return await updateUserRepository.updateUser(params);
  }
}

class UserParam {
  final int id;
  UserEntity userEntity;
  UserParam({required this.id, required this.userEntity});
}
