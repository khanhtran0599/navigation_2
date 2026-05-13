import 'package:go_router/go_router.dart';
import 'package:navigation_2/core/di/service_locator.dart';
import 'package:navigation_2/feature/chat/my_chat_page.dart';
import 'package:navigation_2/feature/home/domain/entities/place_dog_walk_entity.dart';
import 'package:navigation_2/feature/home/my_home_page.dart';
import 'package:navigation_2/feature/home/presentaions/pages/my_list_place_dogwalk_page.dart';
import 'package:navigation_2/feature/home/presentaions/pages/my_place_dogwalk_detail_page.dart';
import 'package:navigation_2/feature/moment/my_moment_page.dart';
import 'package:navigation_2/feature/moment/presentaions/pages/detail_post_page.dart';
import 'package:navigation_2/feature/profile/my_profile_page.dart';
import 'package:navigation_2/feature/profile/presentations/bloc/profile_bloc.dart';
import 'package:navigation_2/feature/profile/presentations/bloc/profile_event.dart';
import 'package:navigation_2/feature/profile/presentations/pages/edit_profile_page.dart';
import 'package:navigation_2/feature/profile/presentations/sub_setting.dart';
import 'package:navigation_2/feature/chat/presentations/pages/chat_detail_page.dart';
import 'package:navigation_2/feature/auth/domain/entities/user_entity.dart';
import 'package:navigation_2/feature/chat/domain/entities/user_entity.dart' as userChat;

import 'package:navigation_2/feature/splash/splash_page.dart';
import 'package:navigation_2/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_2/feature/auth/presentaions/bloc/login/login_bloc.dart';
import 'package:navigation_2/feature/auth/presentaions/bloc/register/register_bloc.dart';
import 'package:navigation_2/feature/auth/presentaions/pages/login_page.dart';
import 'package:navigation_2/feature/auth/presentaions/pages/register_page.dart';
import 'package:navigation_2/feature/auth/presentaions/bloc/auth/auth_bloc.dart';
import 'package:navigation_2/feature/auth/presentaions/bloc/auth/auth_state.dart';

/// Cấu hình điều hướng (Router) cho toàn bộ ứng dụng sử dụng gói [go_router].
/// Quản lý việc chuyển trang, phân nhánh (Bottom Navigation) và kiểm soát truy cập (Auth Guard).
final appRouter = GoRouter(
  /// Đường dẫn mặc định khi ứng dụng vừa khởi động.
  initialLocation: "/splash",

  /// [redirect] là cơ chế Auth Guard (Bảo vệ Route).
  /// Hàm này được gọi mỗi khi có sự thay đổi về Route hoặc trạng thái AuthBloc (nếu có listen).
  /// Nhiệm vụ: Đảm bảo người dùng chưa đăng nhập không thể vào app, 
  /// và người đã đăng nhập không bị kẹt ở màn hình Login/Splash.
  redirect: (context, state) {
    // Đọc trạng thái hiện tại của AuthBloc
    final authState = context.read<AuthBloc>().state;
    
    // Kiểm tra xem người dùng có đang điều hướng tới màn hình Auth (Login/Register) hay Splash không
    final isGoingToAuth = state.matchedLocation == '/login' || state.matchedLocation == '/register';
    final isGoingToSplash = state.matchedLocation == '/splash';

    if (authState is AuthInitial) {
      // Trạng thái ban đầu: Đang kiểm tra session. Giữ nguyên ở Splash.
      return null;
    } else if (authState is Unauthenticated) {
      // Trạng thái chưa đăng nhập: Nếu đang cố gắng vào các trang bên trong app (không phải Auth/Splash)
      // thì sẽ bị bắt buộc chuyển hướng về trang /login.
      if (!isGoingToAuth && !isGoingToSplash) {
        return '/login';
      }
    } else if (authState is Authenticated) {
      // Trạng thái đã đăng nhập: Nếu người dùng đang ở Splash hoặc cố vào lại trang Login
      // thì sẽ tự động chuyển hướng thẳng vào /home.
      if (isGoingToAuth || isGoingToSplash) {
        return '/home';
      }
    }
    
    // Trả về null nghĩa là cho phép đi tiếp tới route được yêu cầu
    return null;
  },
  routes: <RouteBase>[
    // splash screen
    GoRoute(path: "/splash", builder: (context, state) => MySplashPage()),

    GoRoute(
      path: "/login",
      builder: (context, state) => BlocProvider(
        create: (context) => LoginBloc(
          signInUseCase: sl(),
        ),
        child: const LoginPage(),
      ),
    ),

    GoRoute(
      path: "/register",
      builder: (context, state) => BlocProvider(
        create: (context) => RegisterBloc(
          signUpUseCase: sl(),
        ),
        child: const RegisterPage(),
      ),
    ),

    // Các nhánh chính khi đã vào được home
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MyRootPage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/home",
              builder: (context, state) => MyHomePage(),
              routes: [
                GoRoute(
                  path: "myListPlace",
                  builder: (context, state) {
                    var title = state.uri.queryParameters["title"];
                    var listPlace = state.extra as List<PlaceDogWalkEntity>;
                    return MyListPlaceDogWalkPage(
                      title: title,
                      listPlace: listPlace,
                    );
                  },
                ),
                GoRoute(
                  path: "myDetail/:id",
                  builder: (context, state) {
                    var id = state.pathParameters["id"];
                    return MyPlaceDogWalkDetailPage(id: id ?? "0");
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/moment",
              builder: (context, state) => MyMomentPage(),
              routes: [
                GoRoute(
                  path: "detailPost/:id",
                  builder: (context, state) {
                    var id = state.pathParameters["id"];
                    return DetailPostPage(
                      postID: int.tryParse(id.toString()) ?? 0,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/chat",
              builder: (context, state) => const MyChatPage(),
              routes: [
                GoRoute(
                  path: "chatDetail",
                  builder: (context, state) {
                    final targetUser = state.extra as userChat.UserEntity;
                    return ChatDetailPage(targetUser: targetUser);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            ShellRoute(
              builder: (context, state, child) {
                return BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, authState) {
                    if (authState is Authenticated) {
                      return BlocProvider(
                        create: (context) => sl<ProfileBloc>()
                          ..add(FetchUserProfile(authState.user.id)),
                        child: child,
                      );
                    }
                    return child;
                  },
                );
              },
              routes: [
                GoRoute(
                  path: "/profile",
                  builder: (context, state) => const MyProfilePage(),
                  routes: [
                    GoRoute(
                      path: "setting",
                      builder: (context, state) => MySettingPage(),
                    ),
                    GoRoute(
                      path: "editProfile",
                      builder: (context, state) {
                        final user = state.extra as UserEntity;
                        return EditProfilePage(user: user);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
