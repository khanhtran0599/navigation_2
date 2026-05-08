import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/core/usecase/usecase.dart';
import 'package:navigation_2/feature/moment/domain/entities/comment_entity.dart';
import 'package:navigation_2/feature/moment/domain/repositories/get_comment_repository.dart';

class GetCommentsUsecase implements UseCase<List<CommentEntity>, CommentParam> {
  /// Repository cung cấp dữ liệu bài đăng
  final GetCommentRepository getCommentRepository;

  /// Khởi tạo [GetCommentsUsecase] cần truyền vào [getCommentRepository].
  GetCommentsUsecase({required this.getCommentRepository});

  /// Thực thi use case, gọi đến repository để lấy danh sách bài đăng.
  /// Trả về [Either] chứa lỗi [Failure] nếu thất bại hoặc danh sách [PostEntity] nếu thành công.
  @override
  Future<Either<Failure, List<CommentEntity>>> call(CommentParam params) async {
    return await getCommentRepository.getComments(params);
  }
}

class CommentParam {
  final int id;
  CommentParam({required this.id});
}
