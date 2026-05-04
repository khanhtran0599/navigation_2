import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/feature/chat/domain/entities/user_entity.dart';
import 'package:navigation_2/feature/chat/domain/usecases/update_user_usecase.dart';

abstract class UpdateUserRepository {
 Future<Either<Failure,UserEntity>> updateUser(UserParam param);
}
