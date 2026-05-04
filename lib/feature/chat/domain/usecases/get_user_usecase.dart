import 'package:dartz/dartz.dart';
import 'package:navigation_2/core/error/failure.dart';
import 'package:navigation_2/core/usecase/usecase.dart';
import 'package:navigation_2/feature/chat/domain/entities/user_entity.dart';
import 'package:navigation_2/feature/chat/domain/repositories/get_user_repository.dart';

/// [GetUsersUseCase] chịu trách nhiệm xử lý logic nghiệp vụ lấy danh sách người dùng.
/// Triển khai interface [UseCase] với kiểu trả về là danh sách [UserEntity] và không nhận tham số [NoParam].
class GetUsersUseCase implements UseCase<List<UserEntity>, NoParam> {
  /// Repository cung cấp dữ liệu người dùng
  final GetUserRepository getUserRepository;

  /// Khởi tạo [GetUsersUseCase] cần truyền vào [getUserRepository].
  GetUsersUseCase({required this.getUserRepository});

  /// Thực thi use case, gọi đến repository để lấy danh sách người dùng.
  /// Trả về [Either] chứa lỗi [Failure] nếu thất bại hoặc danh sách [UserEntity] nếu thành công.
  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParam params) async {
    return await getUserRepository.getUsers();
  }
}
