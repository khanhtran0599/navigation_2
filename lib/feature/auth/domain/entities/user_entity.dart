import 'package:equatable/equatable.dart';

/// [UserEntity] là đối tượng lõi (Core Entity) trong Domain Layer.
/// Đại diện cho thông tin cơ bản của một người dùng trong hệ thống.
/// Việc kế thừa [Equatable] giúp so sánh 2 object UserEntity dễ dàng hơn dựa trên value thay vì reference.
class UserEntity extends Equatable {
  /// ID duy nhất của người dùng (thường là UID từ Firebase).
  final String id;
  
  /// Địa chỉ email của người dùng (có thể null nếu đăng nhập bằng phương thức khác không cung cấp email).
  final String? email;
  
  /// Tên hiển thị của người dùng.
  final String? name;

  /// Giới tính của người dùng.
  final String? gender;

  /// Ngày tháng năm sinh.
  final String? dob;

  /// Số điện thoại.
  final String? phoneNumber;

  /// Địa chỉ.
  final String? address;

  const UserEntity({
    required this.id,
    this.email,
    this.name,
    this.gender,
    this.dob,
    this.phoneNumber,
    this.address,
  });

  @override
  List<Object?> get props => [id, email, name, gender, dob, phoneNumber, address];
}
