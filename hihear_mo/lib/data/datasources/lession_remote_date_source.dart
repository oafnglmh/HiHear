import 'package:dio/dio.dart';
import 'package:hihear_mo/core/network/api_client.dart';
import 'package:hihear_mo/domain/entities/lesson/lession_entity.dart';
import 'package:hihear_mo/share/TokenStorage.dart';

class LessionRemoteDataSource {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiClient.lession_get_url));

  // ---------------------------------------------------------------------------
  //                               LOAD LESSONS
  // ---------------------------------------------------------------------------
  Future<List<LessionEntity>> loadLessions() async {
    _debugHeader("LOAD LESSONS");

    final token = await TokenStorage.getToken();
    _debugValue("TOKEN", token);

    if (token == null) {
      _debugError("Token null → user chưa đăng nhập");
      throw Exception("User chưa login hoặc token chưa được lưu.");
    }

    const national = "UK";
    _debugValue("National filter", national);

    final response = await _dio.get(
      "lessons",
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      }),
    );

    _debugValue("Status code", response.statusCode);
    _debugValue("Raw response", response.data);

    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;

      final filtered = data.where((lesson) {
        if (lesson["category"] == "Nghe hiểu") return false;
        final exercises = lesson["exercises"] as List<dynamic>;
        return exercises.any((ex) => ex["national"] == national);
      }).toList();

      _debugValue("Filtered lesson count", filtered.length);
      _debugValue("Filtered list", filtered);

      _debugFooter();
      return filtered.map((e) => LessionEntity.fromJson(e)).toList();
    }

    throw Exception("Lấy dữ liệu thất bại: ${response.statusCode}");
  }

  // ---------------------------------------------------------------------------
  //                           LOAD LESSON BY ID
  // ---------------------------------------------------------------------------
  Future<LessionEntity> loadLessionById(String id) async {
    _debugHeader("LOAD LESSON BY ID");
    _debugValue("ID", id);

    final token = await TokenStorage.getToken();
    _debugValue("TOKEN", token);

    if (token == null) {
      _debugError("Token null → user chưa đăng nhập");
      throw Exception("User chưa login hoặc token chưa được lưu.");
    }

    final response = await _dio.get(
      "lessons/$id",
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      }),
    );

    _debugValue("Status code", response.statusCode);
    _debugValue("Response", response.data);

    _debugFooter();

    if (response.statusCode == 200) {
      return LessionEntity.fromJson(response.data);
    }
    throw Exception("Lấy dữ liệu thất bại: ${response.statusCode}");
  }

  // ---------------------------------------------------------------------------
  //                             SAVE VOCABULARY
  // ---------------------------------------------------------------------------
  Future<void> saveVocabulary({
    required String word,
    required String meaning,
    required String category,
    required String userId,
  }) async {
    _debugHeader("SAVE VOCABULARY");

    _debugValue("Word", word);
    _debugValue("Meaning", meaning);
    _debugValue("Category", category);
    _debugValue("UserId", userId);

    final token = await TokenStorage.getToken();
    _debugValue("TOKEN", token);

    if (token == null) {
      _debugError("Token null → user chưa đăng nhập");
      throw Exception("User chưa login hoặc token chưa được lưu.");
    }

    final payload = {
      "word": word,
      "meaning": meaning,
      "category": category,
      "userId": userId,
    };

    _debugValue("Payload", payload);

    try {
      final response = await _dio.post(
        "user-saved-vocabularies",
        data: payload,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
      );

      _debugValue("Status code", response.statusCode);
      _debugValue("Response", response.data);

      if (response.statusCode == 201) {
        _debugSuccess("Lưu từ vựng thành công");
        _debugFooter();
        return;
      }

      _debugError("Server trả về lỗi: ${response.statusCode}");
      throw Exception("Lưu từ vựng thất bại: ${response.statusCode}");
    } on DioException catch (e) {
      _debugError("DIO ERROR: ${e.message}");
      _debugValue("Response", e.response?.data);
      _debugValue("Status", e.response?.statusCode);
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      _debugError("UNEXPECTED ERROR: $e");
      throw Exception("Save vocab unexpected error: $e");
    }
  }

  // ---------------------------------------------------------------------------
  //                          DEBUG UTILITIES
  // ---------------------------------------------------------------------------
  void _debugHeader(String title) {
    print("\n============================================================");
    print("$title");
    print("============================================================");
  }

  void _debugFooter() {
    print("============================================================\n");
  }

  void _debugValue(String label, Object? value) {
    print("• $label: $value");
  }

  void _debugError(String message) {
    print("ERROR: $message");
  }

  void _debugSuccess(String message) {
    print("SUCCESS: $message");
  }
}
