/// [PlaceDogWalkEntity] là thực thể (Entity) đại diện cho một địa điểm dắt chó đi dạo.
/// Đây là lớp dữ liệu thuần túy thuộc tầng Domain, không phụ thuộc vào bất kỳ thư viện bên ngoài nào.
class PlaceDogWalkEntity {
  /// Mã định danh duy nhất của địa điểm
  final String id;

  /// Đường dẫn hình ảnh minh họa
  final String imageUrl;

  /// Địa chỉ cụ thể
  final String address;

  /// Khoảng cách từ vị trí hiện tại (ví dụ: km)
  final double distance;

  /// Giá thuê dắt chó đi dạo (đơn vị: $/giờ)
  final int pricePerHour;

  PlaceDogWalkEntity({
    required this.imageUrl,
    required this.address,
    required this.distance,
    required this.pricePerHour,
    required this.id,
  });
}