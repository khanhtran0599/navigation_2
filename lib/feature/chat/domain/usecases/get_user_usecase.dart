import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/core/usecase/usecase.dart';
import 'package:navigation_2/feature/chat/domain/entities/user_entity.dart';
import 'package:navigation_2/feature/chat/domain/repositories/get_user_repository.dart';

class GetUsersUseCase implements UseCase<List<UserEntity>, NoParam> {
  final GetUserRepository getUserRepository;

  GetUsersUseCase({required this.getUserRepository});

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParam params) async {
    return await getUserRepository.getUsers();
  }
}
