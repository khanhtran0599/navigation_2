// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:navigation_2/feature/home/data/data_source/data_local.dart';
import 'package:navigation_2/feature/home/domain/entities/place_dog_walk_entity.dart';
import 'package:navigation_2/feature/home/domain/repositories/place_dog_walk_repository.dart';

class PlaceDogWalkRepositoryIml implements PlaceDogWalkRepository {
  final PlaceDogWalkDataLocalSource placeDogWalkDataLocalSource;
  PlaceDogWalkRepositoryIml({required this.placeDogWalkDataLocalSource});
  @override
  Future<List<PlaceDogWalkEntity>> getPlaceDogWalks() async {
    return await placeDogWalkDataLocalSource.getPlaceDogWalks();
  }
}
