// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

import 'package:navigation_2/feature/chat/data/model/user_model.dart';
import 'package:navigation_2/feature/chat/domain/usecases/update_user_usecase.dart';

class GetUserRemoteSource {
  final Dio dio;
  GetUserRemoteSource({required this.dio});

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

class UpdateUserRemoteSource {
  final Dio dio;
  UpdateUserRemoteSource({required this.dio});

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
