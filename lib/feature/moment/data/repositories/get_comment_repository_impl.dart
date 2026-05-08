import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/feature/moment/data/data_source/data_remote.dart';
import 'package:navigation_2/feature/moment/domain/entities/comment_entity.dart';
import 'package:navigation_2/feature/moment/domain/repositories/get_comment_repository.dart';
import 'package:navigation_2/feature/moment/domain/usecases/get_comment_usecase.dart';

/// [GetCommentRepositoryImpl] là lớp triển khai thực tế của [GetCommentRepository].
/// Nằm ở Data Layer, chịu trách nhiệm gọi đến [GetCommentRemoteSource] để lấy dữ liệu
/// và xử lý lỗi (nếu có) trước khi trả về cho Domain Layer.
class GetCommentRepositoryImpl implements GetCommentRepository {
  /// Nguồn dữ liệu từ xa (API)
  final GetCommentRemoteSource getCommentRemoteSource;

  /// Khởi tạo [GetCommentRepositoryImpl] cần truyền vào [getCommentRemoteSource].
  GetCommentRepositoryImpl({required this.getCommentRemoteSource});

  /// Triển khai hàm lấy danh sách bài đăng.
  /// Bắt lỗi từ [getCommentRemoteSource] và chuyển đổi thành [ServerFailure] nếu có lỗi.
  @override
  Future<Either<Failure, List<CommentEntity>>> getComments(
    CommentParam param,
  ) async {
    try {
      final resutl = await getCommentRemoteSource.getComments(param);
      return Right(resutl);
    } catch (e) {
      return Left(ServerFalure(e.toString()));
    }
  }
}
