import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_2/feature/auth/domain/usecases/sign_up_usecase.dart';
import 'package:navigation_2/feature/auth/presentaions/bloc/register/register_event.dart';
import 'package:navigation_2/feature/auth/presentaions/bloc/register/register_state.dart';

/// [RegisterBloc] quản lý trạng thái độc lập cho riêng màn hình Đăng ký.
/// Tương tự như [LoginBloc], việc tách riêng giúp quản lý giao diện Register dễ dàng hơn.
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final SignUpUseCase signUpUseCase;

  RegisterBloc({required this.signUpUseCase}) : super(RegisterInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  /// Xử lý sự kiện [RegisterSubmitted] do người dùng kích hoạt.
  Future<void> _onRegisterSubmitted(RegisterSubmitted event, Emitter<RegisterState> emit) async {
    // 1. Chuyển sang trạng thái Loading (để UI vô hiệu hóa nút bấm và hiện vòng xoay).
    emit(RegisterLoading());
    
    // 2. Gọi Usecase xử lý logic Đăng ký tài khoản mới.
    final result = await signUpUseCase(SignUpParams(
      email: event.email,
      password: event.password,
    ));

    // 3. Emit kết quả: Lỗi thì báo lỗi, thành công thì emit RegisterSuccess.
    result.fold(
      (failure) => emit(RegisterFailure(error: failure.message)),
      (user) => emit(RegisterSuccess()),
    );
  }
}
