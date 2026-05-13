import 'package:flutter/material.dart';
import 'package:navigation_2/core/di/service_locator.dart';
import 'package:navigation_2/core/theme/app_colors.dart';
import 'package:navigation_2/core/usecase/usecase.dart';
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
        setState(() {
          isLoading = false;
          users = list;
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
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  var user = users[index];
                  return ListTile(
                    splashColor: AppColors.primary,
                    onLongPress: () {},
                    onTap: () {},
                    leading: Text(user.id.toString()),
                    title: Text(user.name),
                  );
                },
              ),
            ),
    );
  }
}
