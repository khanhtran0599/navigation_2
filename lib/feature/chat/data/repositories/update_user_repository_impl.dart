import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/feature/chat/data/data_source/data_remote.dart';
import 'package:navigation_2/feature/chat/domain/entities/user_entity.dart';
import 'package:navigation_2/feature/chat/domain/repositories/update_user_repository.dart';
import 'package:navigation_2/feature/chat/domain/usecases/update_user_usecase.dart';

class UpdateUserRepositoryImpl implements UpdateUserRepository {
  final UpdateUserRemoteSource updateUserRemoteSource;

  UpdateUserRepositoryImpl({required this.updateUserRemoteSource});
  @override

  Future<Either<Failure,UserEntity>> updateUser(UserParam param) async {
    try {
      final resutl = await updateUserRemoteSource.getUsers(param);
      return Right(resutl);
    } catch (e) {
      return Left(ServerFalure(e.toString()));
    }
  }
  
}
