import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/feature/moment/domain/entities/comment_entity.dart';
import 'package:navigation_2/feature/moment/domain/usecases/get_comment_usecase.dart';

/// [GetCommentRepository] là abstract class định nghĩa hợp đồng (contract) cho việc lấy danh sách Comment của bài đăng.
/// Việc triển khai cụ thể sẽ nằm ở Data Layer (Dependency Inversion).
abstract class GetCommentRepository {
  /// Hàm lấy danh sách bài đăng, trả về [Failure] nếu có lỗi hoặc danh sách [CommentEntity] nếu thành công.
  Future<Either<Failure, List<CommentEntity>>> getComments(CommentParam param);
}
