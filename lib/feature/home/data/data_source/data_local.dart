import 'package:navigation_2/feature/home/data/model/place_dog_walk_model.dart';

/// [jsonPlaceDogWalk] là danh sách dữ liệu mẫu (mock data) dưới dạng JSON.
/// Chứa thông tin về các địa điểm dắt chó đi dạo.
var jsonPlaceDogWalk = [
  {
    "id": "1",
    "imageUrl":
        "https://d3544la1u8djza.cloudfront.net/APHI/Blog/2024/October/Walking-Dog-Hero.jpg",
    "address": "123 Đường ABC, Quận 1",
    "distance": 1.2,
    "pricePerHour": 5,
  },
  {
    "id": "2",
    "imageUrl":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1TeCOD1seLGHrgHPfbnhUINNWw6EG_uSyvQ&s",
    "address": "45 Đường Lê Lợi, Quận 3",
    "distance": 2.5,
    "pricePerHour": 4,
  },
  {
    "id": "3",
    "imageUrl":
        "https://simplyhelping.com.au/wp-content/uploads/2023/12/SH-Summer-Dog-Walking-Tips-Every-Pet-Owner-Should-Know-Blog-Image.png",
    "address": "89 Công viên Gia Định, Gò Vấp",
    "distance": 3.8,
    "pricePerHour": 3,
  },
  {
    "id": "4",
    "imageUrl":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToUPuqZ48k_xIR6uelL5uYOMB1h9ynG2zWHQ&s",
    "address": "Khu đô thị Sala, Quận 2",
    "distance": 5.0,
    "pricePerHour": 8,
  },
  {
    "id": "5",
    "imageUrl":
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBDn5Mv4gyOxQKpW9UvJ6WLBFTFPsTLG6mRg&s",
    "address": "Công viên Vinhomes Central Park",
    "distance": 6.2,
    "pricePerHour": 7,
  },
];

/// [PlaceDogWalkDataLocalSource] chịu trách nhiệm lấy dữ liệu từ nguồn cục bộ (trong trường hợp này là biến static).
class PlaceDogWalkDataLocalSource {
  /// Lấy danh sách các địa điểm dắt chó đi dạo.
  /// Giả lập thời gian chờ (latency) 5 giây để mô phỏng việc gọi API.
  Future<List<PlaceDogWalkModel>> getPlaceDogWalks() async {
    List<PlaceDogWalkModel> listPlace = [];

    await Future.delayed(Duration(seconds: 5), () {
      // Chuyển đổi dữ liệu từ Map (JSON) sang Object (Model)
      listPlace = jsonPlaceDogWalk
          .map((json) => PlaceDogWalkModel.fromJson(json))
          .toList();
    });

    return listPlace;
  }
}
