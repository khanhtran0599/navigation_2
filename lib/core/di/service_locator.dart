import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:navigation_2/core/network/dio_client.dart';

// Auth
import 'package:navigation_2/feature/auth/data/data_source/auth_remote_data_source.dart';
import 'package:navigation_2/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:navigation_2/feature/auth/domain/repositories/auth_repository.dart';
import 'package:navigation_2/feature/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:navigation_2/feature/auth/domain/usecases/get_user_profile_usecase.dart';
import 'package:navigation_2/feature/auth/domain/usecases/update_user_profile_usecase.dart';
import 'package:navigation_2/feature/auth/domain/usecases/sign_in_usecase.dart';
import 'package:navigation_2/feature/auth/domain/usecases/sign_out_usecase.dart';
import 'package:navigation_2/feature/auth/domain/usecases/sign_up_usecase.dart';

// Profile
import 'package:navigation_2/feature/profile/presentations/bloc/profile_bloc.dart';

// Chat
import 'package:navigation_2/feature/chat/data/data_source/data_remote.dart' as chat_remote;
import 'package:navigation_2/feature/chat/data/repositories/get_user_repository_impl.dart';
import 'package:navigation_2/feature/chat/domain/repositories/get_user_repository.dart';
import 'package:navigation_2/feature/chat/domain/usecases/get_user_usecase.dart';

// Moment
import 'package:navigation_2/feature/moment/data/data_source/data_remote.dart' as moment_remote;
import 'package:navigation_2/feature/moment/data/repositories/get_post_repository_impl.dart';
import 'package:navigation_2/feature/moment/domain/repositories/get_post_repository.dart';
import 'package:navigation_2/feature/moment/domain/usecases/get_post_usecase.dart';
import 'package:navigation_2/feature/moment/data/repositories/get_comment_repository_impl.dart';
import 'package:navigation_2/feature/moment/domain/repositories/get_comment_repository.dart';
import 'package:navigation_2/feature/moment/domain/usecases/get_comment_usecase.dart';

/// Instance của [GetIt] dùng để quản lý Service Locator trong toàn bộ ứng dụng.
/// Cho phép truy cập các dependencies từ bất kỳ đâu một cách tập trung.
final sl = GetIt.instance;

/// Khởi tạo các dependencies cần thiết cho ứng dụng.
/// Hàm này nên được gọi trong `main.dart` trước khi chạy `runApp`.
Future<void> init() async {
  // ===========================================================================
  // CORE
  // Các dependencies hệ thống và dùng chung
  // ===========================================================================
  sl.registerLazySingleton<Dio>(() => DioClient.init());
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // ===========================================================================
  // AUTH FEATURE
  // Quản lý xác thực, đăng nhập, đăng ký và lấy thông tin người dùng
  // ===========================================================================
  
  // Data sources: Giao tiếp trực tiếp với Firebase/Firestore
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl()),
  );
  
  // Repositories: Cầu nối giữa Data và Domain layer
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  
  // UseCases: Logic nghiệp vụ cho Auth
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => GetUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserProfileUseCase(sl()));
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));

  // ===========================================================================
  // PROFILE FEATURE
  // Quản lý thông tin cá nhân và cập nhật hồ sơ
  // ===========================================================================
  
  // Blocs: Dùng registerFactory để mỗi lần gọi sl() sẽ tạo ra một instance mới, 
  // giúp tránh lỗi "Cannot add new events after calling close".
  sl.registerFactory(() => ProfileBloc(
        getUserProfileUseCase: sl(),
        updateUserProfileUseCase: sl(),
      ));

  // ===========================================================================
  // CHAT FEATURE
  // Quản lý danh sách người dùng và tin nhắn
  // ===========================================================================
  sl.registerLazySingleton<chat_remote.GetUserRemoteSource>(
    () => chat_remote.GetUserRemoteSource(dio: sl()),
  );
  sl.registerLazySingleton<GetUserRepository>(
    () => GetUserRepositoryImpl(getUserRemoteSource: sl()),
  );
  sl.registerLazySingleton(() => GetUsersUseCase(getUserRepository: sl()));

  // ===========================================================================
  // MOMENT FEATURE
  // Quản lý bài đăng (posts) và bình luận (comments)
  // ===========================================================================
  
  // Posts logic
  sl.registerLazySingleton<moment_remote.GetPostRemoteSource>(
    () => moment_remote.GetPostRemoteSource(dio: sl()),
  );
  sl.registerLazySingleton<GetPostRepository>(
    () => GetPostRepositoryImpl(getPostRemoteSource: sl()),
  );
  sl.registerLazySingleton(() => GetPostsUseCase(getPostRepository: sl()));
  
  // Comments logic
  sl.registerLazySingleton<moment_remote.GetCommentRemoteSource>(
    () => moment_remote.GetCommentRemoteSource(dio: sl()),
  );
  sl.registerLazySingleton<GetCommentRepository>(
    () => GetCommentRepositoryImpl(getCommentRemoteSource: sl()),
  );
  sl.registerLazySingleton(() => GetCommentsUsecase(getCommentRepository: sl()));
}
