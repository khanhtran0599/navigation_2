import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation_2/core/di/service_locator.dart';
import 'package:navigation_2/feature/moment/bloc/post/post_bloc.dart';
import 'package:navigation_2/feature/moment/bloc/post/post_event.dart';
import 'package:navigation_2/feature/moment/bloc/post/post_state.dart';
import 'package:navigation_2/feature/moment/domain/entities/post_entity.dart';
import 'package:navigation_2/feature/moment/domain/usecases/get_post_usecase.dart';
import 'package:navigation_2/feature/moment/presentaions/widgets/post_item_widget.dart';

class MyMomentPage extends StatefulWidget {
  const MyMomentPage({super.key});

  @override
  State<MyMomentPage> createState() => _MyMomentPageState();
}

class _MyMomentPageState extends State<MyMomentPage> {
  // Use case để lấy danh sách bài đăng từ repository.
  late GetPostsUseCase getPostsUseCase;

  @override
  void initState() {
    super.initState();

    // Khởi tạo Use Case từ GetIt
    getPostsUseCase = sl<GetPostsUseCase>();
  }

  @override
  Widget build(BuildContext context) {
    // BlocProvider tạo PostBloc và cung cấp nó cho mọi widget con.
    return BlocProvider<PostBloc>(
      create: (context) =>
          // Khi PostBloc được tạo, ngay lập tức dispatch event GetPost
          // để bắt đầu tải dữ liệu bài đăng từ API.
          PostBloc(getPostsUseCase: getPostsUseCase)..add(GetPost()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Moments Page")),
        body: BlocConsumer<PostBloc, PostState>(
          // Builder dùng để xây dựng UI dựa trên trạng thái hiện tại của bloc.
          builder: (context, state) {
            if (state is PostLoading) {
              // Khi đang tải dữ liệu, hiển thị indicator.
              return const Center(child: CircularProgressIndicator());
            } else if (state is PostLoaded) {
              // Khi đã tải xong, lấy danh sách bài đăng từ state.
              List<PostEntity> posts = state.posts;
              return RefreshIndicator(
                // Kéo để làm mới sẽ gọi lại event GetPost.
                onRefresh: () async {
                  context.read<PostBloc>().add(GetPost());
                },
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    var post = posts[index];
                    return PostItemWidget(
                      post: post,
                      onTap: () {
                        // Khi nhấn vào một bài đăng, điều hướng sang trang chi tiết.
                        context.go("/moment/detailPost/${post.id}");
                      },
                    );
                  },
                ),
              );
            } else if (state is PostError) {
              // Nếu có lỗi, hiển thị thông báo lỗi.
              return Text(state.message);
            } else {
              // Trạng thái mặc định nếu không có state nào phù hợp.
              return const Text("No State");
            }
          },
          // Listener dùng để hiển thị SnackBar khi state thay đổi.
          listener: (BuildContext context, PostState state) {
            if (state is PostLoading) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Loading")));
            } else if (state is PostLoaded) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Success")));
            } else if (state is PostError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Error")));
            } else {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("No State")));
            }
          },
        ),
      ),
    );
  }
}
