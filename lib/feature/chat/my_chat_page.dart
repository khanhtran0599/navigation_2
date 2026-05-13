import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_2/core/di/service_locator.dart';
import 'package:navigation_2/core/theme/app_colors.dart';
import 'package:navigation_2/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_2/feature/auth/presentaions/bloc/auth/auth_bloc.dart';
import 'package:navigation_2/feature/auth/presentaions/bloc/auth/auth_state.dart';
import 'package:navigation_2/feature/chat/domain/entities/user_entity.dart';
import 'package:navigation_2/feature/chat/domain/usecases/get_user_usecase.dart';

class MyChatPage extends StatefulWidget {
  const MyChatPage({super.key});

  @override
  State<MyChatPage> createState() => _MyChatPageState();
}

class _MyChatPageState extends State<MyChatPage> {
  /// Trạng thái loading khi đang gọi API
  bool isLoading = false;

  /// Danh sách người dùng lấy được từ API
  List<UserEntity> users = [];

  /// Use case xử lý logic lấy danh sách người dùng
  late GetUsersUseCase usersUseCase;

  /// Thông báo lỗi nếu gọi API thất bại
  String errorMessage = '';

  @override
  void initState() {
    // Khởi tạo Use Case từ GetIt
    usersUseCase = sl<GetUsersUseCase>();

    // Bắt đầu gọi API lấy dữ liệu người dùng
    getUser();

    super.initState();
  }

  /// Hàm thực thi gọi use case để lấy danh sách người dùng từ API.
  /// Sẽ cập nhật trạng thái [isLoading] và gán kết quả vào danh sách [users] hoặc hiển thị [errorMessage].
  Future<void> getUser() async {
    setState(() {
      isLoading = true;
    });

    // gọi API
    final result = await usersUseCase(NoParam());

    result.fold(
      (failure) {
        setState(() {
          isLoading = false;
          errorMessage = failure.message;
        });
      },
      (list) {
        final authState = context.read<AuthBloc>().state;
        String? currentUserId;
        if (authState is Authenticated) {
          currentUserId = authState.user.id;
        }

        setState(() {
          isLoading = false;
          // Loại bỏ chính mình khỏi danh sách chat
          users = list.where((user) => user.id != currentUserId).toList();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat Page")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage != ""
          ? Center(child: Text(errorMessage))
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: users.length,
              separatorBuilder: (context, index) => const Divider(height: 1, indent: 80),
              itemBuilder: (context, index) {
                var user = users[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Text(
                      user.name.substring(0, 1).toUpperCase(),
                      style:  TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  title: Text(
                    user.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: const Text(
                    "Click to start chatting",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
                  onTap: () {
                    context.push("/chat/chatDetail", extra: user);
                  },
                );
              },
            ),
    );
  }
}
