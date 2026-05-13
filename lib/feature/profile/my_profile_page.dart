import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_2/core/theme/app_colors.dart';
import 'package:navigation_2/feature/auth/presentaions/bloc/auth/auth_bloc.dart';
import 'package:navigation_2/feature/auth/presentaions/bloc/auth/auth_event.dart';
import 'package:navigation_2/feature/auth/presentaions/bloc/auth/auth_state.dart';
import 'package:navigation_2/feature/profile/presentations/bloc/profile_bloc.dart';
import 'package:navigation_2/feature/profile/presentations/bloc/profile_state.dart';

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
          builder: (context, authState) {
            if (authState is Authenticated) {
              return BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, profileState) {
                  String email = authState.user.email ?? 'No email';
                  String name = authState.user.name ?? 'User';

                  if (profileState is ProfileLoaded) {
                    email = profileState.user.email ?? email;
                    name = profileState.user.name ?? name;
                  }

                  final user = (profileState is ProfileLoaded) ? profileState.user : authState.user;

                  return SingleChildScrollView(
                    child: Padding(
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
                          if (profileState is ProfileLoading)
                            const Center(child: CircularProgressIndicator())
                          else ...[
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
                            const SizedBox(height: 24),
                            _buildInfoTile(Icons.wc, "Gender", user.gender ?? "Not specified"),
                            _buildInfoTile(Icons.calendar_today, "Birthday", user.dob ?? "Not specified"),
                            _buildInfoTile(Icons.phone, "Phone", user.phoneNumber ?? "Not specified"),
                            _buildInfoTile(Icons.location_on, "Address", user.address ?? "Not specified"),
                          ],
                          const SizedBox(height: 32),
                          ElevatedButton.icon(
                            onPressed: () {
                              context.push("/profile/editProfile", extra: user);
                            },
                            icon: const Icon(Icons.edit, color: Colors.white),
                            label: const Text("Edit Profile", style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          const SizedBox(height: 16),
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
                          const SizedBox(height: 24),
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
                    ),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Text("$label:", style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Text(value, style: TextStyle(color: AppColors.lightText))),
        ],
      ),
    );
  }
}
