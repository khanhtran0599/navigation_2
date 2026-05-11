import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_2/core/theme/app_colors.dart';
import 'package:navigation_2/feature/auth/presentaions/bloc/auth/auth_bloc.dart';
import 'package:navigation_2/feature/auth/presentaions/bloc/auth/auth_event.dart';
import 'package:navigation_2/feature/auth/presentaions/bloc/auth/auth_state.dart';

/// [MyProfilePage] hiển thị thông tin cá nhân của người dùng và chức năng đăng xuất.
class MyProfilePage extends StatelessWidget {
  const MyProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          context.go('/login');
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: const Text("Profile"),
          backgroundColor: AppColors.white,
          elevation: 0,
          foregroundColor: AppColors.base,
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            String email = 'Loading...';
            String name = 'User';

            if (state is Authenticated) {
              email = state.user.email ?? 'No email';
              name = state.user.name ?? 'User';
            }

            return Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blueAccent,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.base,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    email,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.lightText,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("Settings"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      context.go("/profile/setting");
                    },
                  ),
                  const Divider(),
                  const Spacer(),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<AuthBloc>().add(LoggedOut());
                    },
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text(
                      "Log Out",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.errorColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
