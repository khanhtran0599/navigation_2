// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:navigation_2/feature/home/domain/entities/place_dog_walk_entity.dart';

/// [PlaceDogWalkRepository] là một interface (lớp trừu tượng) định nghĩa các phương thức
/// để tương tác với dữ liệu địa điểm dắt chó đi dạo.
/// Việc sử dụng interface giúp tách biệt giữa tầng Domain và tầng Data (Dependency Inversion).
abstract class PlaceDogWalkRepository {
  /// Lấy danh sách tất cả các địa điểm dắt chó đi dạo từ nguồn dữ liệu.
  Future<List<PlaceDogWalkEntity>> getPlaceDogWalks();
}
