// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import 'package:navigation_2/feature/chat/data/model/user_model.dart';
import 'package:navigation_2/feature/chat/domain/usecases/update_user_usecase.dart';

/// [GetUserRemoteSource] chịu trách nhiệm lấy dữ liệu người dùng từ API thông qua giao thức HTTP (Dio).
class GetUserRemoteSource {
  /// Đối tượng [Dio] để thực hiện các HTTP requests
  final Dio dio;
  
  /// Khởi tạo với đối tượng [Dio]
  GetUserRemoteSource({required this.dio});

  /// Hàm lấy danh sách người dùng từ endpoint `/users`.
  /// Trả về danh sách [UserModel] nếu HTTP response trả về mã 200.
  /// Bắn ra lỗi (Exception) nếu API có lỗi.
  Future<List<UserModel>> getUsers() async {
    try {
      Response response = await dio.get("/users");

      // ======= Update ======
      // Response response = await dio.put(
      //   "/posts/id",
      //   data: {'title': 'foo', 'body': 'bar', 'userId': 1},
      // );

      // ======= Create ======
      // Response response = await dio.post(
      //   "/posts",
      //   data: {'title': 'foo', 'body': 'bar', 'userId': 1},
      // );

      if (response.statusCode == 200) {
        List<dynamic> reponseData = response.data;
        return reponseData.map((json) => UserModel.fromJson(json)).toList();
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

/// [UpdateUserRemoteSource] chịu trách nhiệm gửi request cập nhật thông tin người dùng lên API.
class UpdateUserRemoteSource {
  /// Đối tượng [Dio] để thực hiện các HTTP requests
  final Dio dio;
  
  /// Khởi tạo với đối tượng [Dio]
  UpdateUserRemoteSource({required this.dio});

  /// Gửi dữ liệu người dùng mới qua method PUT đến `/users/{id}`.
  /// Trả về [UserModel] vừa cập nhật nếu thành công (mã 200).
  /// Bắn ra lỗi (Exception) nếu API có lỗi.
  Future<UserModel> getUsers(UserParam user) async {
    try {
      Response response = await dio.put(
        "/users/${user.id}",
        data: UserModel(
          id: user.userEntity.id,
          name: user.userEntity.name,
        ).toJson(),
      );
      if (response.statusCode == 200) {
        final reponseData = response.data;
        return UserModel.fromJson(reponseData);
      } else {
        throw Exception(response.statusMessage);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
