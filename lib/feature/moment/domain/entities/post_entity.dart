/// [PostEntity] là thực thể (Entity) đại diện cho một bài đăng (post) trong tính năng Moment.
/// Đây là lớp dữ liệu thuần túy thuộc tầng Domain, chứa cấu trúc dữ liệu cốt lõi của một bài đăng.
class PostEntity {
    PostEntity({
        required this.userId,
        required this.id,
        required this.title,
        required this.body,
    });

    /// ID của người dùng tạo bài đăng
    final int userId;

    /// Mã định danh duy nhất của bài đăng
    final int id;

    /// Tiêu đề của bài đăng
    final String title;

    /// Nội dung chi tiết của bài đăng
    final String body;
}
