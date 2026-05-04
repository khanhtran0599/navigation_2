import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/feature/chat/data/data_source/data_remote.dart';
import 'package:navigation_2/feature/chat/domain/entities/user_entity.dart';
import 'package:navigation_2/feature/chat/domain/repositories/get_user_repository.dart';


class GetUserRepositoryImpl implements GetUserRepository {
  final GetUserRemoteSource getUserRemoteSource;

  GetUserRepositoryImpl({required this.getUserRemoteSource});
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
