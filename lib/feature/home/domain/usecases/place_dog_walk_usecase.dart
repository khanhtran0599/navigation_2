// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:navigation_2/feature/home/domain/entities/place_dog_walk_entity.dart';
import 'package:navigation_2/feature/home/domain/repositories/place_dog_walk_repository.dart';

class PlaceDogWalkUsecase {
  final PlaceDogWalkRepository placeDogWalkRepository;
  PlaceDogWalkUsecase({required this.placeDogWalkRepository});

  Future<List<PlaceDogWalkEntity>> getPlaceDogWalks() async {
    return await placeDogWalkRepository.getPlaceDogWalks();
  }
}
