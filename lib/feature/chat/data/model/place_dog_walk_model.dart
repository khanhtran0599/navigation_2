import 'package:navigation_2/feature/home/domain/entities/place_dog_walk_entity.dart';

/// [PlaceDogWalkModel] là lớp Model kế thừa từ [PlaceDogWalkEntity].
/// Chịu trách nhiệm chuyển đổi dữ liệu giữa dạng JSON (từ API/Local) và Object trong Dart.
class PlaceDogWalkModel extends PlaceDogWalkEntity {
  PlaceDogWalkModel({
    required super.imageUrl,
    required super.address,
    required super.distance,
    required super.pricePerHour,
    required super.id,
  });

  /// Tạo một bản sao của đối tượng với các giá trị thay đổi tùy chọn.
  PlaceDogWalkModel copyWith({
    String? imageUrl,
    String? address,
    double? distance,
    int? pricePerHour,
    String? id,
  }) {
    return PlaceDogWalkModel(
      imageUrl: imageUrl ?? this.imageUrl,
      address: address ?? this.address,
      distance: distance ?? this.distance,
      pricePerHour: pricePerHour ?? this.pricePerHour,
      id: id ?? this.id,
    );
  }

  /// Chuyển đổi từ dữ liệu Map (JSON) sang đối tượng [PlaceDogWalkModel].
  factory PlaceDogWalkModel.fromJson(Map<String, dynamic> json) {
    return PlaceDogWalkModel(
      imageUrl: json["imageUrl"],
      address: json["address"],
      distance: (json["distance"] as num).toDouble(), // Đảm bảo kiểu dữ liệu double
      pricePerHour: json["pricePerHour"],
      id: json["id"],
    );
  }

  /// Chuyển đổi đối tượng [PlaceDogWalkModel] sang dạng Map (JSON).
  Map<String, dynamic> toJson() => {
    "imageUrl": imageUrl,
    "address": address,
    "distance": distance,
    "pricePerHour": pricePerHour,
    "id": id,
  };

  @override
  String toString() {
    return "$imageUrl, $address, $distance, $pricePerHour, $id, ";
  }
}
