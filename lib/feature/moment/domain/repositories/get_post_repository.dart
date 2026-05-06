import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/feature/moment/domain/entities/post_entity.dart';

/// [GetPostRepository] là abstract class định nghĩa hợp đồng (contract) cho việc lấy danh sách bài đăng.
/// Việc triển khai cụ thể sẽ nằm ở Data Layer (Dependency Inversion).
abstract class GetPostRepository {
  /// Hàm lấy danh sách bài đăng, trả về [Failure] nếu có lỗi hoặc danh sách [PostEntity] nếu thành công.
  Future<Either<Failure, List<PostEntity>>> getPosts();
}

