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

  Future<void> _onRegisterSubmitted(RegisterSubmitted event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    final result = await signUpUseCase(
      SignUpParams(email: event.email, password: event.password, name: event.name),
    );
    result.fold(
      (failure) => emit(RegisterFailure(error: failure.message)),
      (user) => emit(RegisterSuccess(user: user)),
    );
  }
}
