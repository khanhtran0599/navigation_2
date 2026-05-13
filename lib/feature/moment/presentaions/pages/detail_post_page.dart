import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation_2/core/di/service_locator.dart';
import 'package:navigation_2/core/theme/app_colors.dart';
import 'package:navigation_2/core/theme/app_text_styles.dart';
import 'package:navigation_2/core/widgets/error_widget.dart';
import 'package:navigation_2/feature/moment/bloc/comment/comment_bloc.dart';
import 'package:navigation_2/feature/moment/bloc/comment/comment_event.dart';
import 'package:navigation_2/feature/moment/bloc/comment/comment_state.dart';
import 'package:navigation_2/feature/moment/domain/entities/comment_entity.dart';
import 'package:navigation_2/feature/moment/domain/usecases/get_comment_usecase.dart';

class DetailPostPage extends StatefulWidget {
  final int postID;
  const DetailPostPage({super.key, required this.postID});

  @override
  State<DetailPostPage> createState() => _DetailPostPageState();
}

class _DetailPostPageState extends State<DetailPostPage> {
  // Use case để lấy danh sách comment từ repository.
  late GetCommentsUsecase getCommentsUseCase;

  @override
  void initState() {
    super.initState();

    // Khởi tạo Use Case từ GetIt
    getCommentsUseCase = sl<GetCommentsUsecase>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Hiển thị tiêu đề kèm ID bài đăng để nhận biết
        title: Text("Chi tiết bài đăng: ${widget.postID}"),
      ),
      body: Column(
        children: [
          Center(
            child: Text("Danh sách comment của bài đăng ID = ${widget.postID}"),
          ),
          Expanded(
            child: BlocProvider(
              create: (context) =>
                  CommentBloc(getCommentsUseCase: getCommentsUseCase)
                    ..add(GetComment(param: CommentParam(id: widget.postID))),
              child: BlocBuilder<CommentBloc, CommentState>(
                builder: (context, state) {
                  if (state is CommentLoading) {
                    // Khi đang tải dữ liệu, hiển thị indicator.
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CommentLoaded) {
                    // Khi đã tải xong, lấy danh sách bài đăng từ state.
                    List<CommentEntity> comments = state.comments;
                    return RefreshIndicator(
                      // Kéo để làm mới sẽ gọi lại event GetComment.
                      onRefresh: () async {
                        context.read<CommentBloc>().add(
                          GetComment(param: CommentParam(id: widget.postID)),
                        );
                      },
                      child: ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          var comment = comments[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(comment.email),
                                Card(
                                  color: AppColors.primary,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      title: Text(
                                        comment.body,
                                        style: AppTextStyles.body.copyWith(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else if (state is CommentError) {
                    // Nếu có lỗi, hiển thị thông báo lỗi.
                    return MyErrorWidget(
                      message: state.message,
                      onReTry: () {
                        context.read<CommentBloc>().add(
                          GetComment(param: CommentParam(id: widget.postID)),
                        );
                      },
                    );
                  } else {
                    // Trạng thái mặc định nếu không có state nào phù hợp.
                    return const Text("No State");
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
