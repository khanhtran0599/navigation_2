// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:navigation_2/feature/home/data/data_source/data_local.dart';
import 'package:navigation_2/feature/home/domain/entities/place_dog_walk_entity.dart';
import 'package:navigation_2/feature/home/domain/repositories/place_dog_walk_repository.dart';

/// [PlaceDogWalkRepositoryIml] là bản triển khai cụ thể của [PlaceDogWalkRepository].
/// Lớp này kết nối với các Nguồn dữ liệu (Data Sources) để thực hiện các yêu cầu từ tầng Domain.
class PlaceDogWalkRepositoryIml implements PlaceDogWalkRepository {
  final PlaceDogWalkDataLocalSource placeDogWalkDataLocalSource;

  PlaceDogWalkRepositoryIml({required this.placeDogWalkDataLocalSource});

  @override
  /// Lấy dữ liệu từ [PlaceDogWalkDataLocalSource] và trả về dưới dạng danh sách các thực thể (Entities).
  Future<List<PlaceDogWalkEntity>> getPlaceDogWalks() async {
    return await placeDogWalkDataLocalSource.getPlaceDogWalks();
  }
}
