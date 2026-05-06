import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/feature/moment/data/data_source/data_remote.dart';
import 'package:navigation_2/feature/moment/domain/entities/post_entity.dart';
import 'package:navigation_2/feature/moment/domain/repositories/get_post_repository.dart';

/// [GetPostRepositoryImpl] là lớp triển khai thực tế của [GetPostRepository].
/// Nằm ở Data Layer, chịu trách nhiệm gọi đến [GetPostRemoteSource] để lấy dữ liệu
/// và xử lý lỗi (nếu có) trước khi trả về cho Domain Layer.
class GetPostRepositoryImpl implements GetPostRepository {
  /// Nguồn dữ liệu từ xa (API)
  final GetPostRemoteSource getPostRemoteSource;

  /// Khởi tạo [GetPostRepositoryImpl] cần truyền vào [getPostRemoteSource].
  GetPostRepositoryImpl({required this.getPostRemoteSource});

  /// Triển khai hàm lấy danh sách bài đăng.
  /// Bắt lỗi từ [getPostRemoteSource] và chuyển đổi thành [ServerFailure] nếu có lỗi.
  @override
  Future<Either<Failure, List<PostEntity>>> getPosts() async {
    try {
      final resutl = await getPostRemoteSource.getPosts();
      return Right(resutl);
    } catch (e) {
      return Left(ServerFalure(e.toString()));
    }
  }
}
