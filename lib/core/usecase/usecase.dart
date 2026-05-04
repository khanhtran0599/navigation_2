import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
class NoParam {}
