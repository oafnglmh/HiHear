import 'package:dio/dio.dart';
import 'package:hihear_mo/core/network/api_client.dart';
import 'package:hihear_mo/domain/entities/lesson/lession_entity.dart';
import 'package:hihear_mo/share/TokenStorage.dart';
import 'package:hihear_mo/share/UserShare.dart';

class LessionRemoteDataSource {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiClient.lession_get_url));

  Future<List<LessionEntity>> loadLessions() async {
    print("data where");
    final token = await TokenStorage.getToken();
    if (token == null) {
      throw Exception('User chưa login hoặc token chưa được lưu.');
    }
    // final national = UserShare().national;`
    final national = "Korea";
    print("National from UserShare: $national");
    final response = await _dio.get(
      'lessons',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );

    print("Status code: ${response.statusCode}");
    print("Response data: ${response.data}");

    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      final filtered = data.where((lesson) {
        final exercises = lesson['exercises'] as List<dynamic>;
        return exercises.any((ex) => ex['national'] == national);
      }).toList();

      print("Filtered lessons count: ${filtered.length}");
      print("data when filter: ${filtered}");
      return filtered.map((json) => LessionEntity.fromJson(json)).toList();
    } else {
      throw Exception('Lấy dữ liệu thất bại với code: ${response.statusCode}');
    }
  }

  Future<LessionEntity> loadLessionById(String id) async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      throw Exception('User chưa login hoặc token chưa được lưu.');
    }

    final response = await _dio.get(
      'lessons/$id',
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      return LessionEntity.fromJson(response.data);
    } else {
      throw Exception('Lấy dữ liệu thất bại: ${response.statusCode}');
    }
  }
}
