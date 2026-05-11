import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/feature/auth/data/data_source/auth_remote_data_source.dart';
import 'package:navigation_2/feature/auth/domain/entities/user_entity.dart';
import 'package:navigation_2/feature/auth/domain/repositories/auth_repository.dart';

/// [AuthRepositoryImpl] là cầu nối giữa Data Layer (tương tác trực tiếp API) và Domain Layer (hợp đồng cần tuân thủ).
/// Nhiệm vụ chính là gọi `AuthRemoteDataSource` và bọc dữ liệu trả về bằng class `Either`. 
/// Nếu có Exception/Lỗi, nó sẽ map sang `ServerFalure`.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  /// Chuyển tiếp lệnh Đăng nhập. Trả về [Right] (UserModel) nếu thành công, [Left] (ServerFalure) nếu lỗi.
  @override
  Future<Either<Failure, UserEntity>> signIn(String email, String password) async {
    try {
      final userModel = await remoteDataSource.signIn(email, password);
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      // Firebase cung cấp sẵn FirebaseAuthException có field `message` chứa chi tiết lỗi.
      return Left(ServerFalure(e.message ?? 'Authentication error'));
    } catch (e) {
      return Left(ServerFalure(e.toString()));
    }
  }

  /// Chuyển tiếp lệnh Đăng ký. Trả về [Right] (UserModel) hoặc [Left] (ServerFalure).
  @override
  Future<Either<Failure, UserEntity>> signUp(String email, String password) async {
    try {
      final userModel = await remoteDataSource.signUp(email, password);
      return Right(userModel);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFalure(e.message ?? 'Authentication error'));
    } catch (e) {
      return Left(ServerFalure(e.toString()));
    }
  }

  /// Chuyển tiếp lệnh Đăng xuất. Không quan tâm dữ liệu trả về (Right là null).
  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } catch (e) {
      return Left(ServerFalure(e.toString()));
    }
  }

  /// Gọi Data Source để lấy cache user của Firebase.
  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    try {
      final userModel = await remoteDataSource.getCurrentUser();
      return Right(userModel);
    } catch (e) {
      return Left(ServerFalure(e.toString()));
    }
  }
}
