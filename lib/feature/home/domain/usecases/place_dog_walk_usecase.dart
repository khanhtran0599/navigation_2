// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:navigation_2/feature/home/domain/entities/place_dog_walk_entity.dart';
import 'package:navigation_2/feature/home/domain/repositories/place_dog_walk_repository.dart';

/// [PlaceDogWalkUsecase] chứa logic nghiệp vụ liên quan đến địa điểm dắt chó đi dạo.
/// Nó đóng vai trò là một lớp trung gian giữa UI và Repository.
class PlaceDogWalkUsecase {
  final PlaceDogWalkRepository placeDogWalkRepository;
  
  PlaceDogWalkUsecase({required this.placeDogWalkRepository});

  /// Thực hiện nghiệp vụ lấy danh sách địa điểm dắt chó đi dạo.
  /// Có thể bổ sung thêm các logic lọc (filter) hoặc sắp xếp tại đây nếu cần.
  Future<List<PlaceDogWalkEntity>> getPlaceDogWalks() async {
    return await placeDogWalkRepository.getPlaceDogWalks();
  }
}
