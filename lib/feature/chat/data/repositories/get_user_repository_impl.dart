import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/feature/chat/data/data_source/chat_remote_data_source.dart';
import 'package:navigation_2/feature/chat/domain/entities/user_entity.dart';
import 'package:navigation_2/feature/chat/domain/repositories/get_user_repository.dart';

class GetUserRepositoryImpl implements GetUserRepository {
  final ChatRemoteDataSource remoteDataSource;

  GetUserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    try {
      final result = await remoteDataSource.getAllUsers();
      return Right(result);
    } catch (e) {
      return Left(ServerFalure(e.toString()));
    }
  }
}
