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

/// [MyApp] là widget gốc của ứng dụng.
/// Cấu hình theme và router chính ở đây.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Navigation 2.0',
      debugShowCheckedModeBanner: false,

      // Cấu hình giao diện (Theme) cho toàn bộ ứng dụng
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      ),
      
      // Kết nối với cấu hình GoRouter đã định nghĩa
      routerConfig: appRouter,
    );
  }
}

/// [MyRootPage] đóng vai trò là "Shell" (lớp vỏ) cho phần điều hướng chính.
/// Nó chứa BottomNavigationBar và hiển thị nội dung của các nhánh điều hướng (branches).
class MyRootPage extends StatelessWidget {
  /// [navigationShell] quản lý trạng thái của các branch trong StatefulShellRoute.
  final StatefulNavigationShell navigationShell;
  
  const MyRootPage({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Hiển thị nội dung của nhánh hiện tại
      body: navigationShell,
      
      // Thanh điều hướng phía dưới (Bottom Navigation Bar)
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        backgroundColor: AppColors.white,
        indicatorColor: Colors.transparent,
        onDestinationSelected: (index) {
          // Chuyển sang nhánh (branch) tương ứng khi nhấn vào icon
          navigationShell.goBranch(
            index,
            // Nếu nhấn lại vào icon đang chọn, nó sẽ quay về trang đầu của nhánh đó
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset(AppIconUrl.iconHome),
            label: "Home",
            selectedIcon: SvgPicture.asset(
              AppIconUrl.iconHome,
              colorFilter:  ColorFilter.mode(AppColors.base, BlendMode.srcIn),
            ),
          ),
          NavigationDestination(
            icon: SvgPicture.asset(AppIconUrl.iconUser),
            label: "Moments",
            selectedIcon: SvgPicture.asset(
              AppIconUrl.iconUser,
              colorFilter:  ColorFilter.mode(AppColors.base, BlendMode.srcIn),
            ),
          ),
          NavigationDestination(
            icon: SvgPicture.asset(AppIconUrl.iconSend),
            selectedIcon: SvgPicture.asset(
              AppIconUrl.iconSend,
              colorFilter:  ColorFilter.mode(AppColors.base, BlendMode.srcIn),
            ),
            label: "Chat",
          ),
          NavigationDestination(
            icon: SvgPicture.asset(AppIconUrl.iconProfile),
            selectedIcon: SvgPicture.asset(
              AppIconUrl.iconProfile,
              colorFilter:  ColorFilter.mode(AppColors.base, BlendMode.srcIn),
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
