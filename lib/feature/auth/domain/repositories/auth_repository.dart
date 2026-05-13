import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/feature/auth/domain/entities/user_entity.dart';

/// [AuthRepository] là interface (hợp đồng) nằm ở Domain Layer.
/// Nó định nghĩa CÁC CHỨC NĂNG (hành vi) mà Data Layer (hoặc Repository Impl) bắt buộc phải tuân thủ.
/// Việc sử dụng [Either] từ package dartz giúp bắt lỗi một cách tường minh:
/// - Left(Failure): Nếu có lỗi xảy ra.
/// - Right(Data): Nếu thành công trả về dữ liệu.
abstract class AuthRepository {
  /// Đăng nhập bằng email và mật khẩu. Trả về [UserEntity] nếu thành công.
  Future<Either<Failure, UserEntity>> signIn(String email, String password);
  
  /// Đăng ký tài khoản mới. Trả về [UserEntity] nếu thành công.
  Future<Either<Failure, UserEntity>> signUp(String email, String password, String name);
  
  /// Đăng xuất khỏi hệ thống.
  Future<Either<Failure, void>> signOut();
  
  /// Lấy thông tin user đang đăng nhập hiện tại (Session/Cache). Trả về null nếu chưa đăng nhập.
  Future<Either<Failure, UserEntity?>> getCurrentUser();

  /// Lấy thông tin chi tiết người dùng từ Firestore.
  Future<Either<Failure, UserEntity>> getUserProfile(String uid);

  /// Cập nhật thông tin người dùng.
  Future<Either<Failure, void>> updateUserProfile(UserEntity user);
}
