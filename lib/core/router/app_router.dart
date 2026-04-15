import 'package:go_router/go_router.dart';
import 'package:navigation_2/feature/chat/my_chat_page.dart';
import 'package:navigation_2/feature/home/my_home_page.dart';
import 'package:navigation_2/feature/home/sub_page/my_sub_home_page.dart';
import 'package:navigation_2/feature/moment/my_moment_page.dart';
import 'package:navigation_2/feature/profile/my_profile_page.dart';
import 'package:navigation_2/feature/profile/sub_page/my_setting_page.dart';
import 'package:navigation_2/feature/splash/splash_page.dart';
import 'package:navigation_2/main.dart';

final appRouter = GoRouter(
  initialLocation: "/splash",
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
                  path: "subHome",
                  builder: (context, state) => MySubHomePage(),
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
