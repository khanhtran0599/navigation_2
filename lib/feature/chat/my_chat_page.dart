import 'package:flutter/material.dart';
import 'package:navigation_2/core/network/dio_client.dart';
import 'package:navigation_2/core/theme/app_colors.dart';
import 'package:navigation_2/core/usecase/usecase.dart';
import 'package:navigation_2/feature/chat/data/data_source/data_remote.dart';
import 'package:navigation_2/feature/chat/data/repositories/get_user_repository_impl.dart';
import 'package:navigation_2/feature/chat/domain/entities/user_entity.dart';
import 'package:navigation_2/feature/chat/domain/usecases/get_user_usecase.dart';

/// [MyChatPage] hiển thị danh sách các cuộc hội thoại và tin nhắn của người dùng.
/// Đây là một nhánh chính trong Bottom Navigation Bar.
class MyChatPage extends StatefulWidget {
  const MyChatPage({super.key});

  @override
  State<MyChatPage> createState() => _MyChatPageState();
}

class _MyChatPageState extends State<MyChatPage> {
  bool isLoading = false;

  List<UserEntity> users = [];

  late GetUsersUseCase usersUseCase;

  String errorMessage = '';

  @override
  void initState() {
    final dio = DioClient.init();

    final getUserRemoteSource = GetUserRemoteSource(dio: dio);

    final getUserRepository = GetUserRepositoryImpl(
      getUserRemoteSource: getUserRemoteSource,
    );

    usersUseCase = GetUsersUseCase(getUserRepository: getUserRepository);

    // gọi data
    getUser();

    super.initState();
  }

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
