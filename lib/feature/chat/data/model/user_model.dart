import 'package:navigation_2/feature/chat/domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({required super.id, required super.name});

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