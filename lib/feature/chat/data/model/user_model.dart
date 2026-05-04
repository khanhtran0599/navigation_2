import 'package:navigation_2/feature/chat/domain/entities/user_entity.dart';

/// [UserModel] là lớp Model kế thừa từ [UserEntity].
/// Chịu trách nhiệm chuyển đổi dữ liệu giữa dạng JSON (từ API/Local) và Object trong Dart.
class UserModel extends UserEntity{
  /// Khởi tạo [UserModel] với [id] và [name].
  UserModel({required super.id, required super.name});

  /// Chuyển đổi từ dữ liệu Map (JSON) sang đối tượng [UserModel].
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      name: json["name"],
     
    );
  }

  /// Chuyển đổi đối tượng [UserModel] sang dạng Map (JSON).
  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };

  @override
  String toString() {
    return "$id, $name ";
  }
}