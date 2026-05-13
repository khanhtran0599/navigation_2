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
                    child: Column(
                      children: [
                        // Header Section with background or gradient
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.05),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(32),
                              bottomRight: Radius.circular(32),
                            ),
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundColor: AppColors.primary.withOpacity(0.1),
                                    child:  Icon(Icons.person, size: 60, color: AppColors.primary),
                                  ),
                                  PositionBag(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: AppColors.primary,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(Icons.camera_alt, size: 20, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              if (profileState is ProfileLoading)
                                const CircularProgressIndicator()
                              else ...[
                                Text(
                                  name,
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.base,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  email,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        color: AppColors.lightText,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Profile Info Card
                              const Text(
                                "Personal Information",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),
                              Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(color: Colors.grey.shade200),
                                ),
                                child: Column(
                                  children: [
                                    _buildInfoListTile(Icons.wc, "Gender", user.gender ?? "Not specified"),
                                    _buildDivider(),
                                    _buildInfoListTile(Icons.calendar_today, "Birthday", user.dob ?? "Not specified"),
                                    _buildDivider(),
                                    _buildInfoListTile(Icons.phone, "Phone", user.phoneNumber ?? "Not specified"),
                                    _buildDivider(),
                                    _buildInfoListTile(Icons.location_on, "Address", user.address ?? "Not specified"),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 24),
                              
                              // Actions Section
                              const Text(
                                "Account Settings",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 12),
                              Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: BorderSide(color: Colors.grey.shade200),
                                ),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading:  Icon(Icons.edit, color: AppColors.primary),
                                      title: const Text("Edit Profile"),
                                      trailing: const Icon(Icons.chevron_right),
                                      onTap: () => context.push("/profile/editProfile", extra: user),
                                    ),
                                    _buildDivider(),
                                    ListTile(
                                      leading: const Icon(Icons.settings, color: Colors.grey),
                                      title: const Text("Settings"),
                                      trailing: const Icon(Icons.chevron_right),
                                      onTap: () => context.go("/profile/setting"),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 32),
                              
                              // Logout Button
                              OutlinedButton.icon(
                                onPressed: () => context.read<AuthBloc>().add(LoggedOut()),
                                icon:  Icon(Icons.logout, color: AppColors.errorColor),
                                label:  Text(
                                  "Log Out",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.errorColor,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  side:  BorderSide(color: AppColors.errorColor),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 32),
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildInfoListTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 22),
      title: Text(title, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      trailing: Text(
        value,
        style:  TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.base),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, indent: 56, endIndent: 16, color: Colors.grey.shade100);
  }
}

class PositionBag extends StatelessWidget {
  final double? bottom;
  final double? right;
  final Widget child;
  const PositionBag({super.key, this.bottom, this.right, required this.child});

  @override
  Widget build(BuildContext context) {
    return Positioned(bottom: bottom, right: right, child: child);
  }
}
