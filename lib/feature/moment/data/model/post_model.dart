import 'package:navigation_2/feature/moment/domain/entities/post_entity.dart';

/// [PostModel] là lớp Model kế thừa từ [PostEntity].
/// Chịu trách nhiệm chuyển đổi dữ liệu giữa dạng JSON (từ API/Local) và Object trong Dart cho bài đăng.
class PostModel extends PostEntity{
    PostModel({
        required super.userId,
        required super.id,
        required super.title,
        required super.body,
    });

    /// Tạo một bản sao của đối tượng với các giá trị thay đổi tùy chọn.
    PostModel copyWith({
        int? userId,
        int? id,
        String? title,
        String? body,
    }) {
        return PostModel(
            userId: userId ?? this.userId,
            id: id ?? this.id,
            title: title ?? this.title,
            body: body ?? this.body,
        );
    }

    /// Chuyển đổi từ dữ liệu Map (JSON) sang đối tượng [PostModel].
    factory PostModel.fromJson(Map<String, dynamic> json){ 
        return PostModel(
            userId: json["userId"],
            id: json["id"],
            title: json["title"],
            body: json["body"],
        );
    }

    /// Chuyển đổi đối tượng [PostModel] sang dạng Map (JSON).
    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };

    @override
    String toString(){
        return "$userId, $id, $title, $body, ";
    }
}
