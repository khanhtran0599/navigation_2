// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_2/core/usecase/usecase.dart';

import 'package:navigation_2/feature/moment/bloc/post/post_event.dart';
import 'package:navigation_2/feature/moment/bloc/post/post_state.dart';
import 'package:navigation_2/feature/moment/domain/usecases/get_post_usecase.dart';

/// [PostBloc] là thành phần quản lý trạng thái (State Management) cho tính năng bài đăng.
/// BLoC này sẽ lắng nghe các [PostEvent] và phát ra các [PostState] tương ứng.
class PostBloc extends Bloc<PostEvent, PostState> {
  /// UseCase để lấy danh sách bài đăng từ tầng Domain
  final GetPostsUseCase getPostsUseCase;

  /// Khởi tạo [PostBloc] với trạng thái ban đầu là [PostInitial]
  /// Đăng ký handler cho sự kiện [GetPost].
  PostBloc({required this.getPostsUseCase}) : super(PostInitial()) {
    on<GetPost>((event, emit) => onGetPosts(event, emit));
  }

  /// Xử lý sự kiện [GetPost] khi UI yêu cầu lấy danh sách bài đăng.
  Future<void> onGetPosts(GetPost event, Emitter<PostState> emit) async { // Sửa tên tham số 'state' thành 'emit' cho chuẩn
    // Phát ra trạng thái đang tải
    emit(PostLoading());

    // Gọi UseCase để lấy dữ liệu (không cần truyền tham số - NoParam)
    final result = await getPostsUseCase(NoParam());

    // Xử lý kết quả trả về từ Either (Left: Lỗi, Right: Thành công)
    result.fold(
      (failure) {
        emit(PostError(message: failure.message));
      },
      (posts) { // Sửa tên biến từ 'post' thành 'posts' cho phù hợp với danh sách
        emit(PostLoaded(posts: posts));
      },
    );
  }
}
