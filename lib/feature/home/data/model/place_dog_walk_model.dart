import 'package:navigation_2/feature/home/domain/entities/place_dog_walk_entity.dart';

class PlaceDogWalkModel extends PlaceDogWalkEntity {
  PlaceDogWalkModel({
    required super.imageUrl,
    required super.address,
    required super.distance,
    required super.pricePerHour,
    required super.id,
  });

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

  factory PlaceDogWalkModel.fromJson(Map<String, dynamic> json) {
    return PlaceDogWalkModel(
      imageUrl: json["imageUrl"],
      address: json["address"],
      distance: json["distance"],
      pricePerHour: json["pricePerHour"],
      id: json["id"],
    );
  }

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
