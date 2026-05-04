import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/feature/chat/domain/entities/user_entity.dart';

abstract class GetUserRepository {
 Future<Either<Failure,List<UserEntity>>> getUsers();
}
