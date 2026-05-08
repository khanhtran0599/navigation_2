// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_2/feature/moment/bloc/comment/comment_event.dart';
import 'package:navigation_2/feature/moment/bloc/comment/comment_state.dart';
import 'package:navigation_2/feature/moment/domain/usecases/get_comment_usecase.dart';

/// [CommentBloc] là thành phần quản lý trạng thái (State Management) cho tính năng comment.
/// BLoC này sẽ lắng nghe các [ CommentEvent] và phát ra các [CommentState] tương ứng.
class CommentBloc extends Bloc<CommentEvent, CommentState> {
  /// UseCase để lấy danh sách comment từ tầng Domain
  final GetCommentsUsecase getCommentsUseCase;

  /// Khởi tạo [CommentBloc] với trạng thái ban đầu là [CommentInitial]
  /// Đăng ký handler cho sự kiện [GetComment].
  CommentBloc({required this.getCommentsUseCase}) : super(CommentInitial()) {
    on<GetComment>((event, emit) => onGetComments(event, emit));
  }

  /// Xử lý sự kiện [GetComment] khi UI yêu cầu lấy danh sách comment.
  Future<void> onGetComments(
    GetComment event,
    Emitter<CommentState> emit,
  ) async {
    // Sửa tên tham số 'state' thành 'emit' cho chuẩn
    // Phát ra trạng thái đang tải
    emit(CommentLoading());

    // Gọi UseCase để lấy dữ liệu (không cần truyền tham số - CommentParam)
    final result = await getCommentsUseCase(event.param);

    // Xử lý kết quả trả về từ Either (Left: Lỗi, Right: Thành công)
    result.fold(
      (failure) {
        emit(CommentError(message: failure.message));
      },
      (comments) {
        emit(CommentLoaded(comments: comments));
      },
    );
  }
}
