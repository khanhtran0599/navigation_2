import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:navigation_2/feature/auth/data/model/user_model.dart';

/// [AuthRemoteDataSource] là interface quy định các phương thức kết nối với máy chủ (Remote).
/// Nó tách biệt phần kết nối thật (ví dụ HTTP Client, Firebase) khỏi phần logic Repository.
abstract class AuthRemoteDataSource {
  Future<UserModel> signIn(String email, String password);
  Future<UserModel> signUp(String email, String password, String name);
  Future<void> signOut();
  Future<UserModel?> getCurrentUser();
}

/// [AuthRemoteDataSourceImpl] là phần triển khai thực tế sử dụng [FirebaseAuth].
/// Ở đây gọi các API của Firebase trực tiếp và ném lỗi (throw Exception) nếu API trả về lỗi.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  /// Gửi yêu cầu tạo tài khoản mới lên Firebase và lưu thông tin vào Firestore.
  @override
  Future<UserModel> signUp(String email, String password, String name) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    if (userCredential.user != null) {
      final user = userCredential.user!;
      
      // Cập nhật Profile (DisplayName) trên Firebase Auth
      await user.updateDisplayName(name);
      
      // Lưu thông tin người dùng vào Firestore
      await firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': email,
        'name': name,
        'createdAt': FieldValue.serverTimestamp(),
      });
      
      return UserModel(
        id: user.uid,
        email: email,
        name: name,
      );
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
