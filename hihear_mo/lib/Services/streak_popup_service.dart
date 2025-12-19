import 'package:shared_preferences/shared_preferences.dart';

class StreakPopupService {
  static const String _lastPopupDateKey = 'last_streak_popup_date';
  static const String _hasCompletedLessonTodayKey = 'completed_lesson_today_';
  Future<bool> hasShownPopupToday(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final lastDate = prefs.getString('${_lastPopupDateKey}_$userId');
    
    if (lastDate == null) return false;
    
    final lastDateTime = DateTime.parse(lastDate);
    final now = DateTime.now();
    
    return lastDateTime.year == now.year &&
           lastDateTime.month == now.month &&
           lastDateTime.day == now.day;
  }

  Future<void> markPopupShown(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      '${_lastPopupDateKey}_$userId',
      DateTime.now().toIso8601String(),
    );
  }

  Future<void> markLessonCompleted(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final today = _getTodayKey();
    await prefs.setBool('$_hasCompletedLessonTodayKey${userId}_$today', true);
    print('[StreakService] Marked lesson completed for user $userId on $today');
  }
  Future<bool> hasCompletedLessonToday(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final today = _getTodayKey();
    return prefs.getBool('$_hasCompletedLessonTodayKey${userId}_$today') ?? false;
  }

  Future<bool> shouldShowPopup(String userId) async {
    final hasShown = await hasShownPopupToday(userId);
    final hasCompleted = await hasCompletedLessonToday(userId);
    
    return !hasShown && hasCompleted;
  }

  Future<void> resetForTesting(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('${_lastPopupDateKey}_$userId');
    final today = _getTodayKey();
    await prefs.remove('$_hasCompletedLessonTodayKey${userId}_$today');
  }

  String _getTodayKey() {
    final now = DateTime.now();
    return '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
  }

  Future<void> cleanupOldData(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final allKeys = prefs.getKeys();
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    
    for (final key in allKeys) {
      if (key.startsWith('$_hasCompletedLessonTodayKey$userId')) {
        final dateStr = key.split('_').last;
        if (dateStr.length == 8) {
          try {
            final year = int.parse(dateStr.substring(0, 4));
            final month = int.parse(dateStr.substring(4, 6));
            final day = int.parse(dateStr.substring(6, 8));
            final date = DateTime(year, month, day);
            
            if (date.isBefore(thirtyDaysAgo)) {
              await prefs.remove(key);
            }
          } catch (e) {
            await prefs.remove(key);
          }
        }
      }
    }
  }
}