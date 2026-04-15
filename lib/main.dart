import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_2/core/constants/icon_asset_url.dart';
import 'package:navigation_2/core/router/app_router.dart';
import 'package:navigation_2/core/theme/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Navigation 2.0',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: AppColors.primary),
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      ),
      routerConfig: appRouter,
    );
  }
}

class MyRootPage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MyRootPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        backgroundColor: AppColors.white,
        indicatorColor: Colors.transparent,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset(AppIconUrl.iconHome),
            label: "Home",
            selectedIcon: SvgPicture.asset(
              AppIconUrl.iconHome,
              color: AppColors.base,
            ),
          ),
          NavigationDestination(
            icon: SvgPicture.asset(AppIconUrl.iconUser),
            label: "Moments",
            selectedIcon: SvgPicture.asset(
              AppIconUrl.iconUser,
              color: AppColors.base,
            ),
          ),
          NavigationDestination(
            icon: SvgPicture.asset(AppIconUrl.iconSend),
            selectedIcon: SvgPicture.asset(
              AppIconUrl.iconSend,
              color: AppColors.base,
            ),
            label: "Chat",
          ),
          NavigationDestination(
            icon: SvgPicture.asset(AppIconUrl.iconProfile),
            selectedIcon: SvgPicture.asset(
              AppIconUrl.iconProfile,
              color: AppColors.base,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
