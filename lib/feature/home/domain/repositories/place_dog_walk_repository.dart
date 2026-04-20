// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:navigation_2/feature/home/domain/entities/place_dog_walk_entity.dart';

abstract class PlaceDogWalkRepository {
  Future<List<PlaceDogWalkEntity>> getPlaceDogWalks();
}
