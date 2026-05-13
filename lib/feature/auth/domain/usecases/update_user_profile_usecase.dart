import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/core/usecase/usecase.dart';
import 'package:navigation_2/feature/auth/domain/entities/user_entity.dart';
import 'package:navigation_2/feature/auth/domain/repositories/auth_repository.dart';

class UpdateUserProfileUseCase implements UseCase<void, UserEntity> {
  final AuthRepository repository;

  UpdateUserProfileUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(UserEntity user) async {
    return await repository.updateUserProfile(user);
  }
}
