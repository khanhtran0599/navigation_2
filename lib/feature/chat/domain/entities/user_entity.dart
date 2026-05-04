// ignore_for_file: public_member_api_docs, sort_constructors_first

/// [UserEntity] là thực thể đại diện cho thông tin cơ bản của người dùng trong ứng dụng.
/// Được sử dụng chủ yếu ở Domain Layer để giữ cho logic nghiệp vụ không bị phụ thuộc vào Data Layer.
class UserEntity {
  /// ID định danh duy nhất của người dùng
  final int id;

  /// Tên hiển thị của người dùng
  final String name;

  /// Khởi tạo [UserEntity] yêu cầu bắt buộc phải có [id] và [name].
  UserEntity({
    required this.id,
    required this.name,
  });
}
