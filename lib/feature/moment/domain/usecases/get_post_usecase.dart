import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/core/usecase/usecase.dart';
import 'package:navigation_2/feature/moment/domain/entities/post_entity.dart';
import 'package:navigation_2/feature/moment/domain/repositories/get_post_repository.dart';

/// [GetPostsUseCase] chịu trách nhiệm xử lý logic nghiệp vụ lấy danh sách bài đăng.
/// Triển khai interface [UseCase] với kiểu trả về là danh sách [PostEntity] và không nhận tham số [NoParam].
class GetPostsUseCase implements UseCase<List<PostEntity>, NoParam> {
  /// Repository cung cấp dữ liệu bài đăng
  final GetPostRepository getPostRepository;

  /// Khởi tạo [GetPostsUseCase] cần truyền vào [getPostRepository].
  GetPostsUseCase({required this.getPostRepository});

  /// Thực thi use case, gọi đến repository để lấy danh sách bài đăng.
  /// Trả về [Either] chứa lỗi [Failure] nếu thất bại hoặc danh sách [PostEntity] nếu thành công.
  @override
  Future<Either<Failure, List<PostEntity>>> call(NoParam params) async {
    return await getPostRepository.getPosts();
  }
}


