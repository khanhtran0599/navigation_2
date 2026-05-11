import 'package:go_router/go_router.dart';
import 'package:navigation_2/feature/chat/my_chat_page.dart';
import 'package:navigation_2/feature/home/domain/entities/place_dog_walk_entity.dart';
import 'package:navigation_2/feature/home/my_home_page.dart';
import 'package:navigation_2/feature/home/presentaions/pages/my_list_place_dogwalk_page.dart';
import 'package:navigation_2/feature/home/presentaions/pages/my_place_dogwalk_detail_page.dart';
import 'package:navigation_2/feature/moment/my_moment_page.dart';
import 'package:navigation_2/feature/moment/presentaions/pages/detail_post_page.dart';
import 'package:navigation_2/feature/profile/my_profile_page.dart';
import 'package:navigation_2/feature/profile/presentations/sub_setting.dart';
import 'package:navigation_2/feature/splash/splash_page.dart';
import 'package:navigation_2/main.dart';

/// Cấu hình điều hướng (Router) cho toàn bộ ứng dụng sử dụng gói [go_router].
final appRouter = GoRouter(
  initialLocation: "/splash",
  redirect: (context, state) => null,
  routes: <RouteBase>[
    // splash screen
    GoRoute(path: "/splash", builder: (context, state) => MySplashPage()),

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
            GoRoute(path: "/chat", builder: (context, state) => MyChatPage()),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: "/profile",
              builder: (context, state) => MyProfilePage(),
              routes: [
                GoRoute(
                  path: "setting",
                  builder: (context, state) => MySettingPage(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
