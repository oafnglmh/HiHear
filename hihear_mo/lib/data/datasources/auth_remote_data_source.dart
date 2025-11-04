import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hihear_mo/core/network/api_client.dart';
import 'package:hihear_mo/domain/entities/user_entity.dart';

class AuthRemoteDataSource {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiClient.authUrl));

  Future<UserEntity> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
        serverClientId: '495791136012-1jmsqr1eon062483ia16cgetsri510h5.apps.googleusercontent.com',
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) throw Exception('Đăng nhập Google bị hủy.');

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print('token: ${googleAuth.idToken}');
      final userCred = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCred.user;
      if (user == null) throw Exception('Không thể xác thực người dùng.');
      try {
        final response = await _dio.post(
          '/google',
          data: {'idToken': googleAuth.idToken},
          options: Options(headers: {'Content-Type': 'application/json'}),
        );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Backend trả về lỗi: ${response.statusCode}');
      }



        print('Backend response: ${response.data}');
      } catch (e) {
        print('Lỗi gọi backend: $e');
        throw Exception('Lỗi đăng nhập Google: $e');
      }

      return UserEntity(
        id: user.uid,
        name: user.displayName ?? '',
        email: user.email ?? '',
        photoUrl: user.photoURL ?? '',
      );
    } catch (e) {
      throw Exception('Lỗi đăng nhập Google: $e');
    }
  }

  Future<UserEntity> loginWithFacebook() async {
    try {
      final response = await _dio.get('/facebook');
      return UserEntity(
        id: 'fb_123',
        name: response.data['name'] ?? 'User',
        email: response.data['email'] ?? 'unknown@email.com',
        photoUrl: response.data['avatar'] ?? '',
      );
    } catch (e) {
      throw Exception('Lỗi đăng nhập Facebook: $e');
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
