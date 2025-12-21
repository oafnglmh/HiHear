import 'package:dio/dio.dart';
import 'package:hihear_mo/core/network/api_client.dart';
import 'package:hihear_mo/domain/entities/VocabUserEntity/vocab_user_entity.dart';
import 'package:hihear_mo/domain/entities/lesson/lession_entity.dart';
import 'package:hihear_mo/share/TokenStorage.dart';
import 'package:hihear_mo/share/UserShare.dart';

class LessionRemoteDataSource {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiClient.lession_get_url));

  // ---------------------------------------------------------------------------
  //                               LOAD LESSONS
  // ---------------------------------------------------------------------------
  Future<List<LessionEntity>> loadLessions() async {
    _debugHeader("LOAD LESSONS");

    final token = await TokenStorage.getToken();
    if (token == null) {
      _debugError("Token null → user chưa đăng nhập");
      throw Exception("User chưa login.");
    }

    final national = UserShare().national;

    final response = await _dio.get(
      "lessons",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );
    UserShare().debugPrint();
    final responseHistory = await _dio.get(
      "user-progress/${UserShare().id}",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      final filtered = data.where((lesson) {
        if (lesson["category"] == "Nghe hiểu") return false;
        return (lesson["exercises"] as List).any(
          (ex) => ex["national"] == national,
        );
      }).toList();

      final historyList = responseHistory.data as List<dynamic>;
      final completedLessonIds = historyList
          .where((h) => h["completed"] == true)
          .map<String>((h) => h["lesson_id"] as String)
          .toSet();

      final lessons = filtered.map((json) {
        final entity = LessionEntity.fromJson(json);

        final lessonId = entity.id;
        final prerequisite = entity.prerequisiteLessonId;

        bool isCompleted = completedLessonIds.contains(lessonId);
        bool isLocked = false;

        if (prerequisite != null && prerequisite.isNotEmpty) {
          if (!completedLessonIds.contains(prerequisite)) {
            isLocked = true;
          }
        }

        if (isCompleted) {
          isLocked = false;
        }

        return entity.copyWith(isLock: isLocked);
      }).toList();

      for (var lesson in lessons) {
        _debugValue("Lesson ${lesson.id}", lesson.toJson());
      }

      return lessons;
    }

    throw Exception("Lấy dữ liệu thất bại: ${response.statusCode}");
  }

  Future<List<LessionEntity>> loadLessionBySpeaking() async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      _debugError("Token null → user chưa đăng nhập");
      throw Exception("User chưa login.");
    }

    final national = UserShare().national;
    final response = await _dio.get(
      "lessons?category=Nói",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    UserShare().debugPrint();

    final responseHistory = await _dio.get(
      "user-progress/${UserShare().id}",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;

      final filtered = data.where((lesson) {
        return (lesson["exercises"] as List).any(
          (ex) => ex["national"] == national,
        );
      }).toList();
      final historyList = responseHistory.data as List<dynamic>;
      final completedLessonIds = historyList
          .where((h) => h["completed"] == true)
          .map<String>((h) => h["lesson_id"] as String)
          .toSet();

      final lessons = filtered
          .map((json) => LessionEntity.fromJson(json))
          .where((entity) => !completedLessonIds.contains(entity.id))
          .map((entity) => entity.copyWith(isLock: false))
          .toList();

      _debugValue("Loaded lessons", lessons);
      return lessons;
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
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    _debugValue("Status code", response.statusCode);
    _debugValue("Response", response.data);

    _debugFooter();

    if (response.statusCode == 200) {
      return LessionEntity.fromJson(response.data);
    }
    throw Exception("Lấy dữ liệu thất bại: ${response.statusCode}");
  }

  Future<List<VocabUserEntity>> loadVocabUserById(String id) async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      throw Exception("User chưa login hoặc token chưa được lưu.");
    }

    final response = await _dio.get(
      "user-saved-vocabularies/$id",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.statusCode == 200) {
      final list = response.data as List;
      print("Loaded vocab user data: $list");
      return list.map((json) => VocabUserEntity.fromJson(json)).toList();
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
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
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

  Future<void> saveCompleteLesson({
    required String lessonId,
    required String userId,
  }) async {
    final token = await TokenStorage.getToken();

    if (token == null) {
      throw Exception("User chưa login hoặc token chưa được lưu.");
    }
    _debugValue("UserId", userId);
    final payload = {
      "lesson_id": lessonId,
      "user_id": userId,
      "completed": true,
    };

    _debugValue("Payload", payload);

    try {
      final response = await _dio.post(
        "user-progress",
        data: payload,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      if (response.statusCode == 201) {
        _debugSuccess("Lưu từ vựng thành công");
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
