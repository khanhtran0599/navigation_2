class PlaceDogWalkEntity {
  final String id;
  final String imageUrl;
  final String address;
  final double distance;
  final int pricePerHour;
  PlaceDogWalkEntity({
    required this.imageUrl,
    required this.address,
    required this.distance,
    required this.pricePerHour,
    required this.id,
  });
}