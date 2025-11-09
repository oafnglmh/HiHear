import 'package:dio/dio.dart';
import 'package:hihear_mo/core/network/api_client.dart';
import 'package:hihear_mo/domain/entities/lession_entity.dart';
import 'package:hihear_mo/share/TokenStorage.dart';

class LessionRemoteDataSource {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiClient.lession_get_url));

  Future<List<LessionEntity>> loadLessions() async {
    print("data where");
    final token = await TokenStorage.getToken();
    if (token == null) {
      throw Exception('User chưa login hoặc token chưa được lưu.');
    }

    final response = await _dio.get(
      'lession',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );

    print("Status code: ${response.statusCode}"); // <--- thêm để debug
    print("Response data: ${response.data}");

    // Chấp nhận 200 OK
    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      return data.map((json) => LessionEntity.fromJson(json)).toList();
    } else {
      throw Exception('Lấy dữ liệu thất bại với code: ${response.statusCode}');
    }
  }
}
