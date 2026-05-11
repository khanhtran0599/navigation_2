import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_2/feature/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:navigation_2/feature/auth/domain/usecases/sign_out_usecase.dart';
import 'package:navigation_2/feature/auth/presentaions/bloc/auth/auth_event.dart';
import 'package:navigation_2/feature/auth/presentaions/bloc/auth/auth_state.dart';

/// [AuthBloc] là BLoC cấp cao nhất (Global), có trách nhiệm quản lý phiên làm việc (Session) của người dùng.
/// Cung cấp thông tin xác thực cho [appRouter] để quyết định việc điều hướng (Redirect).
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final SignOutUseCase signOutUseCase;

  AuthBloc({
    required this.getCurrentUserUseCase,
    required this.signOutUseCase,
  }) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  /// Khi ứng dụng khởi động, lấy thông tin người dùng từ bộ nhớ đệm (cache) Firebase.
  /// Nếu có, chuyển sang [Authenticated]. Nếu không, chuyển sang [Unauthenticated].
  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    final result = await getCurrentUserUseCase();
    result.fold(
      (failure) => emit(Unauthenticated()),
      (user) {
        if (user != null) {
          emit(Authenticated(user));
        } else {
          emit(Unauthenticated());
        }
      },
    );
  }

  /// Khi người dùng đăng nhập thành công từ Login/Register Bloc, 
  /// gọi sự kiện [AppStarted] để load lại thông tin và xác nhận phiên làm việc.
  void _onLoggedIn(LoggedIn event, Emitter<AuthState> emit) {
    add(AppStarted());
  }

  /// Khi người dùng yêu cầu đăng xuất, gọi Usecase để xóa session và emit [Unauthenticated].
  Future<void> _onLoggedOut(LoggedOut event, Emitter<AuthState> emit) async {
    await signOutUseCase();
    emit(Unauthenticated());
  }
}
