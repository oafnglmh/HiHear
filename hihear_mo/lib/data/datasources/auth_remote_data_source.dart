import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hihear_mo/core/network/api_client.dart';

class AuthRemoteDataSource {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiClient.authUrl));

  Future<Map<String, dynamic>> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        print('[Auth] Người dùng hủy đăng nhập Google.');
      }

      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      final response = await _dio.post(
        '/google',
        data: {'token': googleAuth?.idToken},
      );

      print('[Auth] Backend response: ${response.data}');
      return response.data;
    } catch (e, s) {
      print('[Auth][Error] Firebase Google Sign-In failed: $e');
      print('[Auth][StackTrace] $s');
      throw Exception('Lỗi đăng nhập Google: $e');
    }
  }

  Future<Map<String, dynamic>> loginWithFacebook() async {
    try {
      final response = await _dio.get('/facebook');
      return response.data;
    } on DioException catch (e) {
      throw Exception('Lỗi mạng khi đăng nhập Facebook: ${e.message}');
    } catch (e) {
      throw Exception('Lỗi đăng nhập Facebook: $e');
    }
  }
}
