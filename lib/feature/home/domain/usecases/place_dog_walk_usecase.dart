
import 'package:navigation_2/feature/home/domain/entities/place_dog_walk_entity.dart';
import 'package:navigation_2/feature/home/domain/repositories/place_dog_walk_repository.dart';

/// [PlaceDogWalkUsecase] chứa logic nghiệp vụ liên quan đến địa điểm dắt chó đi dạo.
/// Nó đóng vai trò là một lớp trung gian giữa UI và Repository.
class PlaceDogWalkUsecase {
  final PlaceDogWalkRepository placeDogWalkRepository;

  PlaceDogWalkUsecase({required this.placeDogWalkRepository});

  @override
  Future<List<PlaceDogWalkEntity>> getPlaceDogWalks() async {
    return placeDogWalkRepository.getPlaceDogWalks();
  }
}
