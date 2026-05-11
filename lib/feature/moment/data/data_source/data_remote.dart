// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:navigation_2/core/usecase/usecase.dart';
import 'package:navigation_2/feature/moment/data/model/comment_model.dart';
import 'package:navigation_2/feature/moment/data/model/post_model.dart';
import 'package:navigation_2/feature/moment/domain/usecases/get_comment_usecase.dart';

/// [GetPostRemoteSource] chịu trách nhiệm lấy dữ liệu bài đăng từ API thông qua giao thức HTTP (Dio).
class GetPostRemoteSource {
  /// Đối tượng [Dio] để thực hiện các HTTP requests
  final Dio dio;

  /// Khởi tạo với đối tượng [Dio]
  GetPostRemoteSource({required this.dio});

  /// Hàm lấy danh sách bài đăng từ endpoint `/posts` (ví dụ jsonplaceholder).
  /// Trả về danh sách [PostModel] nếu HTTP response trả về mã 200.
  /// Bắn ra lỗi (Exception) nếu API có lỗi.
  Future<List<PostModel>> getPosts() async {
    try {
      Response response = await dio.get("/posts");

      // ======= Update ======
      // Response response = await dio.put(
      //   "/posts/1",
      //   data: {'title': 'foo', 'body': 'bar', 'userId': 1},
      // );

      // ======= Create ======
      // Response response = await dio.post(
      //   "/posts",
      //   data: {'title': 'foo', 'body': 'bar', 'userId': 1},
      // );

      if (response.statusCode == 200) {
        List<dynamic> reponseData = response.data;
        return reponseData.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

/// [UpdatePostRemoteSource] chịu trách nhiệm gửi request cập nhật thông tin bài đăng lên API.
class UpdatePostRemoteSource {
  /// Đối tượng [Dio] để thực hiện các HTTP requests
  final Dio dio;

  /// Khởi tạo với đối tượng [Dio]
  UpdatePostRemoteSource({required this.dio});

  /// Gửi dữ liệu bài đăng mới qua method PUT đến `/posts/{id}`.
  /// Trả về [PostModel] vừa cập nhật nếu thành công (mã 200).
  /// Bắn ra lỗi (Exception) nếu API có lỗi.
  Future<PostModel> getPosts(NoParam post) async {
    try {
      Response response = await dio.put(
        "/Posts/$post",
        // data: PostModel(userId: "null", id: null, title: '', body: ''

        // ).toJson(),
      );
      if (response.statusCode == 200) {
        final reponseData = response.data;
        return PostModel.fromJson(reponseData);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

/// [GetCommentRemoteSource] chịu trách nhiệm lấy dữ liệu bài đăng từ API thông qua giao thức HTTP (Dio).
class GetCommentRemoteSource {
  /// Đối tượng [Dio] để thực hiện các HTTP requests
  final Dio dio;

  /// Khởi tạo với đối tượng [Dio]
  GetCommentRemoteSource({required this.dio});

  /// Hàm lấy danh sách Comment từ endpoint `/posts/1/comments` (ví dụ jsonplaceholder).
  /// Trả về danh sách [CommentModel] nếu HTTP response trả về mã 200.
  /// Bắn ra lỗi (Exception) nếu API có lỗi.
  Future<List<CommentModel>> getComments(CommentParam param) async {
    try {
      Response response = await dio.get("/posts/${param.id}/comments");
      if (response.statusCode == 200) {
        List<dynamic> reponseData = response.data;
        return reponseData.map((json) => CommentModel.fromJson(json)).toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
