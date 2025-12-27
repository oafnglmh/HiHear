import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hihear_mo/core/network/api_client.dart';
import 'package:hihear_mo/domain/entities/country/country_entity.dart';
import 'package:hihear_mo/domain/entities/user/user_entity.dart';
import 'package:hihear_mo/share/TokenStorage.dart';
import 'package:hihear_mo/share/UserShare.dart';

class AuthRemoteDataSource {
  final Dio _dioLogin = Dio(BaseOptions(baseUrl: ApiClient.auth_url));
  final Dio _dioProfile = Dio(BaseOptions(baseUrl: ApiClient.profile_url));

  Future<UserEntity> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
        serverClientId:
            '495791136012-1jmsqr1eon062483ia16cgetsri510h5.apps.googleusercontent.com',
      );

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) throw Exception('Đăng nhập Google bị hủy.');

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCred = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final user = userCred.user;
      if (user == null) throw Exception('Không thể xác thực người dùng.');

      final response = await _dioLogin.post(
        '/google',
        data: {'idToken': googleAuth.idToken},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Backend trả về lỗi: ${response.statusCode}');
      }
      print('Response data from backend: ${response.data}');
      final accessToken = response.data['token']['accessToken'];
      await TokenStorage.saveToken(accessToken);
      final profile = response.data['profile'];
      final userData = response.data['user'];
      print('userData: ${userData}');
      print('level:${profile['level']}');
      await UserShare().saveUser(
        id: userData['id'],
        name: user.displayName ?? '',
        email: user.email ?? '',
        photoUrl: user.photoURL ?? '',
        national: profile['language'] ?? null,
        level: profile['level'] ?? null,
        dailyStreak: profile['streakDays'].toString(),
      );
      UserShare().debugPrint();
      return UserEntity(
        id: userData['id'],
        name: user.displayName ?? '',
        email: user.email ?? '',
        photoUrl: user.photoURL ?? '',
        level: profile['level'] ?? null,
        national: profile['language'] ?? null,
      );
    } catch (e) {
      print(e);
      throw Exception('Lỗi đăng nhập Google: $e');
    }
  }

  Future<UserEntity> addOrUpdateCountry(CountryEntity country) async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      throw Exception('User chưa login hoặc token chưa được lưu.');
    }

    try {
      final payload = {'language': country.code};
      print('Payload gửi lên backend: $payload');

      final response = await _dioProfile.patch(
        '/me',
        data: payload,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Backend trả về lỗi: ${response.statusCode}');
      }

      final user = UserEntity.fromJson(response.data);

      // await UserShare().saveUser(
      //   id: user.id ?? '',
      //   name: user.name ?? '',
      //   email: user.email ?? '',
      //   photoUrl: user.photoUrl ?? '',
      //   national: country.code,
      //   level: user.level,
      //   dailyStreak: user.streakDays?.toString() ?? '0',
      // );
      print(country.code);
      await UserShare().updateNational(
        country.code,
      );
      UserShare().debugPrint();

      return user;
    } catch (e) {
      print('Lỗi gọi backend: $e');
      throw Exception('Lỗi khi gọi backend: $e');
    }
  }

  Future<UserEntity> updateUserLevel(level) async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      throw Exception('User chưa login hoặc token chưa được lưu.');
    }

    try {
      final payload = {'level': level};
      print('Payload gửi lên backend: $payload');

      final response = await _dioProfile.patch(
        '/me',
        data: payload,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Backend trả về lỗi: ${response.statusCode}');
      }
      await UserShare().updateLevel(
        level,
      );
    
      UserShare().debugPrint();

      return UserEntity.fromJson(response.data);
    } catch (e) {
      print('Lỗi gọi backend: $e');
      throw Exception('Lỗi khi gọi backend: $e');
    }
  }

  Future<UserEntity> addStreak(int streak) async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      throw Exception('User chưa login hoặc token chưa được lưu.');
    }

    try {
      final payload = {'streakDays': streak};
      print('Payload gửi lên backend: $payload');

      final response = await _dioProfile.patch(
        '/me',
        data: payload,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Backend trả về lỗi: ${response.statusCode}');
      }

      return UserEntity.fromJson(response.data);
    } catch (e) {
      print('Lỗi gọi backend: $e');
      throw Exception('Lỗi khi gọi backend: $e');
    }
  }

  Future<UserEntity> loginWithFacebook() async {
    try {
      final response = await _dioLogin.get('/facebook');
      return UserEntity(
        id: 'fb_123',
        name: response.data['name'] ?? 'User',
        email: response.data['email'] ?? 'unknown@email.com',
        photoUrl: response.data['avatar'] ?? '',
        national: response.data['avatar'] ?? '',
      );
    } catch (e) {
      throw Exception('Lỗi đăng nhập Facebook: $e');
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await TokenStorage.removeToken();
  }
}
