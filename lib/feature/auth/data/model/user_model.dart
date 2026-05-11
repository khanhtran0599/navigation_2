import 'package:firebase_auth/firebase_auth.dart';
import 'package:navigation_2/feature/auth/domain/entities/user_entity.dart';

/// [UserModel] là cầu nối giữa Data Layer (Firebase) và Domain Layer (Entities).
/// Lớp này kế thừa [UserEntity] để có thể trả về đúng kiểu dữ liệu mà Domain yêu cầu,
/// đồng thời chứa các phương thức parser JSON hoặc Object chuyên biệt từ database/API.
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    super.email,
    super.name,
  });

  /// Hàm Factory giúp chuyển đổi dữ liệu từ đối tượng [User] của Firebase 
  /// thành đối tượng [UserModel] sử dụng trong hệ thống nội bộ.
  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      id: user.uid,
      email: user.email,
      name: user.displayName,
    );
  }
}
