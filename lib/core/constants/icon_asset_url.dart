/// [AppIconUrl] quản lý đường dẫn đến các tệp tin tài nguyên (assets) của ứng dụng.
const baseUrl = "assets/icons";

/// Lớp hằng số chứa đường dẫn các icon SVG và hình ảnh.
class AppIconUrl {
  // Logo ứng dụng dạng SVG và PNG
  static final String iconApp = "$baseUrl/LOGO.svg";
  static final String iconAppPng = "$baseUrl/logo.png";

  // textfield
  static final String iconPlace = "$baseUrl/place.svg";

  static final String iconFilter = "$baseUrl/filter.svg";

  // Các icon cho Bottom Navigation Bar
  static final String iconHome = "$baseUrl/Home.svg";
  static final String iconSend = "$baseUrl/Send.svg";
  static final String iconUser = "$baseUrl/User.svg";
  static final String iconProfile = "$baseUrl/Profile.svg";
}
