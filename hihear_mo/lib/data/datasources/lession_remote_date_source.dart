import 'package:dio/dio.dart';
import 'package:hihear_mo/core/network/api_client.dart';
import 'package:hihear_mo/domain/entities/VocabUserEntity/vocab_user_entity.dart';
import 'package:hihear_mo/domain/entities/lesson/lession_entity.dart';
import 'package:hihear_mo/share/TokenStorage.dart';
import 'package:hihear_mo/share/UserShare.dart';

class LessionRemoteDataSource {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiClient.lession_get_url));
  static const List<String> _levelOrder = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

  // ---------------------------------------------------------------------------
  //                               LOAD LESSONS
  // ---------------------------------------------------------------------------
  Future<List<LessionEntity>> loadLessions() async {
    _debugHeader("LOAD LESSONS");

    final token = await TokenStorage.getToken();
    if (token == null) {
      throw Exception("User chưa login.");
    }

    final national = UserShare().national;
    final userLevel = UserShare().level;

    int _levelIndex(String? level) {
      if (level == null) return -1;
      return _levelOrder.indexOf(level);
    }

    // ================= API =================
    final response = await _dio.get(
      "lessons",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    final responseHistory = await _dio.get(
      "user-progress/${UserShare().id}",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception("Lấy dữ liệu thất bại: ${response.statusCode}");
    }

    // ================= FILTER LESSON =================
    final data = response.data as List<dynamic>;
    final filtered = data.where((lesson) {
      if (lesson["category"] == "Nghe hiểu") return false;
      return (lesson["exercises"] as List).any(
        (ex) => ex["national"] == national,
      );
    }).toList();

    // ================= USER HISTORY =================
    final historyList = responseHistory.data as List<dynamic>;
    final completedLessonIds = historyList
        .where((h) => h["completed"] == true)
        .map<String>((h) => h["lesson_id"] as String)
        .toSet();

    // ================= PHASE 1: MAP ENTITY (NO LOCK) =================
    final lessons = filtered
        .map((json) => LessionEntity.fromJson(json))
        .toList();

    // =========================================================
    // ============ PHASE 2: CHECK LAST LESSON & LEVEL UP =======
    // =========================================================

    String? effectiveUserLevel = userLevel;

    final currentLevelLessons = lessons
        .where((l) => l.level == effectiveUserLevel)
        .toList();

    if (currentLevelLessons.isNotEmpty) {
      currentLevelLessons.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      final lastLessonOfLevel = currentLevelLessons.last;
      final isFinishedLastLesson = completedLessonIds.contains(
        lastLessonOfLevel.id,
      );

      if (isFinishedLastLesson) {
        final nextLevel = _getNextLevel(effectiveUserLevel);

        if (nextLevel != null) {
          await UserShare().updateLevel(nextLevel);

          effectiveUserLevel = nextLevel;
        }
      }
    }

    // =========================================================
    // ============ PHASE 3: CALCULATE LOCK =====================
    // =========================================================

    final effectiveLevelIdx = _levelIndex(effectiveUserLevel);

    final finalLessons = lessons.map((entity) {
      final lessonLevelIdx = _levelIndex(entity.level);
      final prerequisite = entity.prerequisiteLessonId;

      bool isCompleted = completedLessonIds.contains(entity.id);
      bool isLocked = false;

      if (lessonLevelIdx > effectiveLevelIdx) {
        isLocked = true;
      } else if (lessonLevelIdx == effectiveLevelIdx) {
        if (prerequisite != null &&
            prerequisite.isNotEmpty &&
            !completedLessonIds.contains(prerequisite)) {
          isLocked = true;
        }
      }

      if (isCompleted) {
        isLocked = false;
      }

      return entity.copyWith(isLock: isLocked);
    }).toList();

    // ================= DEBUG =================
    for (var lesson in finalLessons) {
      _debugValue("Lesson ${lesson.id}", {
        "level": lesson.level,
        "createdAt": lesson.createdAt.toIso8601String(),
        "isLock": lesson.isLock,
      });
    }

    return finalLessons;
  }

  String? _getNextLevel(String? currentLevel) {
    if (currentLevel == null) return null;
    final idx = _levelOrder.indexOf(currentLevel);
    if (idx == -1 || idx == _levelOrder.length - 1) return null;
    return _levelOrder[idx + 1];
  }

  Future<LessionEntity?> loadNextLesson() async {
    _debugHeader("LOAD NEXT LESSON");

    final token = await TokenStorage.getToken();
    if (token == null) {
      throw Exception("User chưa login.");
    }

    final national = UserShare().national;
    String? userLevel = UserShare().level;

    int _levelIndex(String? level) {
      if (level == null) return -1;
      return _levelOrder.indexOf(level);
    }

    // ================= API =================
    final response = await _dio.get(
      "lessons",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    final responseHistory = await _dio.get(
      "user-progress/${UserShare().id}",
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.statusCode != 200) {
      throw Exception("Lấy dữ liệu thất bại: ${response.statusCode}");
    }

    // ================= FILTER LESSON =================
    final data = response.data as List<dynamic>;
    final filtered = data.where((lesson) {
      if (lesson["category"] == "Nghe hiểu") return false;
      return (lesson["exercises"] as List).any(
        (ex) => ex["national"] == national,
      );
    }).toList();

    // ================= USER HISTORY =================
    final historyList = responseHistory.data as List<dynamic>;
    final completedLessonIds = historyList
        .where((h) => h["completed"] == true)
        .map<String>((h) => h["lesson_id"] as String)
        .toSet();

    // ================= PHASE 1: MAP ENTITY (NO LOCK) =================
    final lessons = filtered
        .map((json) => LessionEntity.fromJson(json))
        .toList();

    // =========================================================
    // ============ PHASE 2: CHECK LAST LESSON & LEVEL UP =======
    // =========================================================

    String? effectiveUserLevel = userLevel;

    final currentLevelLessons = lessons
        .where((l) => l.level == effectiveUserLevel)
        .toList();

    if (currentLevelLessons.isNotEmpty) {
      currentLevelLessons.sort((a, b) => a.createdAt.compareTo(b.createdAt));

      final lastLessonOfLevel = currentLevelLessons.last;
      final isFinishedLastLesson = completedLessonIds.contains(
        lastLessonOfLevel.id,
      );

      if (isFinishedLastLesson) {
        final nextLevel = _getNextLevel(effectiveUserLevel);

        if (nextLevel != null) {

          await UserShare().updateLevel(nextLevel);
          effectiveUserLevel = nextLevel;
        }
      }
    }

    // =========================================================
    // ============ PHASE 3: CALCULATE LOCK =====================
    // =========================================================

    final effectiveLevelIdx = _levelIndex(effectiveUserLevel);

    final finalLessons = lessons.map((entity) {
      final lessonLevelIdx = _levelIndex(entity.level);
      final prerequisite = entity.prerequisiteLessonId;

      bool isCompleted = completedLessonIds.contains(entity.id);
      bool isLocked = false;

      // lock theo level
      if (lessonLevelIdx > effectiveLevelIdx) {
        isLocked = true;
      } else if (lessonLevelIdx == effectiveLevelIdx) {
        if (prerequisite != null &&
            prerequisite.isNotEmpty &&
            !completedLessonIds.contains(prerequisite)) {
          isLocked = true;
        }
      }

      if (isCompleted) {
        isLocked = false;
      }

      return entity.copyWith(isLock: isLocked);
    }).toList();

    // =========================================================
    // ============ PHASE 4: PICK NEXT LESSON ===================
    // =========================================================

    final availableLessons = finalLessons.where((lesson) {
      return !completedLessonIds.contains(lesson.id) && lesson.isLock == false;
    }).toList();

    _debugValue(
      "Available lessons (not completed & unlocked)",
      availableLessons.length,
    );

    if (availableLessons.isEmpty) {
      _debugValue("Result", "No available lessons to learn");
      return null;
    }
    availableLessons.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final nextLesson = availableLessons.first;

    _debugValue("NextLesson Selected", {
      "id": nextLesson.id,
      "level": nextLesson.level,
      "category": nextLesson.category,
      "createdAt": nextLesson.createdAt.toIso8601String(),
    });

    return nextLesson;
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
