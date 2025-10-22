import 'package:dio/dio.dart';
import 'package:hihear_mo/core/network/api_client.dart';
class AuthRemoteDataSource {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiClient.authUrl));

  Future<dynamic> loginWithGoogle() async {
    final response = await _dio.get('/google');
    return response.data;
  }

  Future<dynamic> loginWithFacebook() async {
    final response = await _dio.get('/facebook');
    return response.data;
  }
}