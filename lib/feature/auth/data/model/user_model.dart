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
    super.gender,
    super.dob,
    super.phoneNumber,
    super.address,
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

  /// Hàm Factory giúp chuyển đổi dữ liệu từ Firestore Document 
  /// thành đối tượng [UserModel].
  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      id: data['uid'] ?? '',
      email: data['email'],
      name: data['name'],
      gender: data['gender'],
      dob: data['dob'],
      phoneNumber: data['phoneNumber'],
      address: data['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': id,
      'email': email,
      'name': name,
      'gender': gender,
      'dob': dob,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }
}
