import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_2/feature/auth/domain/usecases/sign_in_usecase.dart';
import 'package:navigation_2/feature/auth/presentaions/bloc/login/login_event.dart';
import 'package:navigation_2/feature/auth/presentaions/bloc/login/login_state.dart';

/// [LoginBloc] quản lý trạng thái độc lập cho riêng màn hình Login.
/// Việc tách biệt [LoginBloc] và [AuthBloc] giúp giao diện không bị gián đoạn và tái sử dụng dễ dàng hơn.
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignInUseCase signInUseCase;

  LoginBloc({required this.signInUseCase}) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  /// Xử lý sự kiện [LoginSubmitted] do người dùng kích hoạt.
  Future<void> _onLoginSubmitted(LoginSubmitted event, Emitter<LoginState> emit) async {
    // 1. Chuyển sang trạng thái Loading (để UI vô hiệu hóa nút bấm và hiện vòng xoay).
    emit(LoginLoading());
    
    // 2. Gọi Usecase xử lý logic Đăng nhập.
    final result = await signInUseCase(SignInParams(
      email: event.email,
      password: event.password,
    ));

    // 3. Emit kết quả: Lỗi thì báo lỗi, thành công thì emit LoginSuccess.
    result.fold(
      (failure) => emit(LoginFailure(error: failure.message)),
      (user) => emit(LoginSuccess()),
    );
  }
}
