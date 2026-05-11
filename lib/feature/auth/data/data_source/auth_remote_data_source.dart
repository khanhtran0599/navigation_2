import 'package:firebase_auth/firebase_auth.dart';
import 'package:navigation_2/feature/auth/data/model/user_model.dart';

/// [AuthRemoteDataSource] là interface quy định các phương thức kết nối với máy chủ (Remote).
/// Nó tách biệt phần kết nối thật (ví dụ HTTP Client, Firebase) khỏi phần logic Repository.
abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<UserModel> signUp(String email, String password);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
}

/// [AuthRemoteDataSourceImpl] là phần triển khai thực tế sử dụng [FirebaseAuth].
/// Ở đây gọi các API của Firebase trực tiếp và ném lỗi (throw Exception) nếu API trả về lỗi.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl({required this.firebaseAuth});

  /// Gửi yêu cầu đăng nhập bằng Email/Password lên Firebase.
  @override
  Future<UserModel> signIn(String email, String password) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user != null) {
      return UserModel.fromFirebaseUser(userCredential.user!);
    } else {
      throw Exception('Sign in failed');
    }
  }

  /// Gửi yêu cầu tạo tài khoản mới lên Firebase.
  @override
  Future<UserModel> signUp(String email, String password) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user != null) {
      return UserModel.fromFirebaseUser(userCredential.user!);
    } else {
      throw Exception('Sign up failed');
    }
  }

  /// Xóa phiên (session) hiện tại trên Firebase.
  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  /// Lấy thông tin user hiện tại được cache bởi Firebase SDK.
  @override
  Future<UserModel?> getCurrentUser() async {
    final user = firebaseAuth.currentUser;
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }
}
