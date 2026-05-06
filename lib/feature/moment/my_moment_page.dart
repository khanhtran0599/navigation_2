import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_2/core/network/dio_client.dart';
import 'package:navigation_2/feature/moment/bloc/post/post_bloc.dart';
import 'package:navigation_2/feature/moment/bloc/post/post_event.dart';
import 'package:navigation_2/feature/moment/bloc/post/post_state.dart';
import 'package:navigation_2/feature/moment/data/data_source/data_remote.dart';
import 'package:navigation_2/feature/moment/data/repositories/get_post_repository_impl.dart';
import 'package:navigation_2/feature/moment/domain/entities/post_entity.dart';
import 'package:navigation_2/feature/moment/domain/usecases/get_post_usecase.dart';
import 'package:navigation_2/feature/moment/presentaions/widgets/post_item_widget.dart';

/// [MyMomentPage] hiển thị các khoảnh khắc, bài đăng của người dùng và bạn bè.
/// Đây là một nhánh chính trong Bottom Navigation Bar để xem các tin đăng mới nhất.
class MyMomentPage extends StatefulWidget {
  const MyMomentPage({super.key});

  @override
  State<MyMomentPage> createState() => _MyMomentPageState();
}

class _MyMomentPageState extends State<MyMomentPage> {
  late GetPostsUseCase getPostsUseCase;

  @override
  void initState() {
    // Khởi tạo Dio client
    final dio = DioClient.init();

    // Khởi tạo Remote Source
    final getPostRemoteSource = GetPostRemoteSource(dio: dio);

    // Khởi tạo Repository
    final getPostRepository = GetPostRepositoryImpl(
      getPostRemoteSource: getPostRemoteSource,
    );

    // Khởi tạo Use Case
    getPostsUseCase = GetPostsUseCase(getPostRepository: getPostRepository);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (context) =>
          //  sau khi tạo được bloc thì event- getPost được gọi luôn
          PostBloc(getPostsUseCase: getPostsUseCase)..add(GetPost()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Moments Page")),
        body: BlocConsumer<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PostLoaded) {
              List<PostEntity> posts = state.posts;
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<PostBloc>().add(GetPost());
                },
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var post = posts[index];
                    return PostItemWidget(
                      post: post,
                      onTap: () {
                        context.go("/moment/detailPost/${post.id}");
                      },
                    );
                  },
                ),
              );
            } else if (state is PostError) {
              return Text(state.message);
            } else {
              return Text("No State");
            }
          },
          listener: (BuildContext context, PostState state) {
            if (state is PostLoading) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Loading")));
            } else if (state is PostLoaded) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Success")));
            } else if (state is PostError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Error")));
            } else {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("No Sate")));
            }
          },
        ),
      ),
    );
  }
}
