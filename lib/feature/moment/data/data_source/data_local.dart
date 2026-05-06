
import 'package:navigation_2/feature/moment/data/model/post_model.dart';

/// [jsonPost] là danh sách dữ liệu mẫu (mock data) dưới dạng JSON.
/// Có thể dùng để hiển thị ảnh hoặc thông tin bài đăng giả lập.
var jsonPost = [
  {
    "id": "1",
    "imageUrl":
        "https://d3544la1u8djza.cloudfront.net/APHI/Blog/2024/October/Walking-Dog-Hero.jpg",
  },
  {
    "id": "2",
    "imageUrl":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1TeCOD1seLGHrgHPfbnhUINNWw6EG_uSyvQ&s",

  },
  {
    "id": "3",
    "imageUrl":
        "https://simplyhelping.com.au/wp-content/uploads/2023/12/SH-Summer-Dog-Walking-Tips-Every-Pet-Owner-Should-Know-Blog-Image.png",

  },
  {
    "id": "4",
    "imageUrl":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToUPuqZ48k_xIR6uelL5uYOMB1h9ynG2zWHQ&s",
  
  },
  {
    "id": "5",
    "imageUrl":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBDn5Mv4gyOxQKpW9UvJ6WLBFTFPsTLG6mRg&s",
  },
];

/// [PostDataLocalSource] chịu trách nhiệm lấy dữ liệu bài đăng từ nguồn cục bộ.
class PostDataLocalSource {
  /// Lấy danh sách các bài đăng.
  /// Giả lập thời gian chờ (latency) 5 giây để mô phỏng việc gọi API.
  Future<List<PostModel>> getPost() async {
    List<PostModel> posts = [];

    await Future.delayed(Duration(seconds: 5), () {
      // Chuyển đổi dữ liệu từ Map (JSON) sang Object (Model)
      //posts = jsonPost.map((json) => PostModel.fromJson(json)).toList();
    });

    return posts;
  }
}
