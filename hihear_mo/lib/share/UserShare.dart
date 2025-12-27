import 'package:shared_preferences/shared_preferences.dart';

class UserShare {
  static final UserShare _instance = UserShare._internal();
  factory UserShare() => _instance;
  UserShare._internal();

  String? id;
  String? name;
  String? email;
  String? photoUrl;
  String? national;
  String? dailyStreak;
  String? level;

  Future<void> saveUser({
    required String id,
    required String name,
    required String email,
    required String photoUrl,
    String? national,
    String? level,
    required String dailyStreak,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    this.id = id;
    this.name = name;
    this.email = email;
    this.photoUrl = photoUrl;
    this.national = national;
    this.level = level?.toString();
    this.dailyStreak = dailyStreak;

    await prefs.setString("id", id);
    await prefs.setString("name", name);
    await prefs.setString("email", email);
    await prefs.setString("photoUrl", photoUrl);

    if (national != null) {
      await prefs.setString("national", national);
    } else {
      await prefs.remove("national");
    }

    if (level != null) {
      await prefs.setString("level", level.toString());
    } else {
      await prefs.remove("level");
    }

    await prefs.setString("dailyStreak", dailyStreak);
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();

    id = prefs.getString("id");
    name = prefs.getString("name");
    email = prefs.getString("email");
    photoUrl = prefs.getString("photoUrl");
    national = prefs.getString("national");
    level = prefs.getString("level");
    dailyStreak = prefs.getString("dailyStreak");
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    id = null;
    name = null;
    email = null;
    photoUrl = null;
    national = null;
    level = null;
    dailyStreak = null;
  }

  Future<void> updateLevel(String newLevel) async {
    final prefs = await SharedPreferences.getInstance();

    level = newLevel;
    await prefs.setString("level", newLevel);
  }

  Future<void> updateNational(String national) async {
    final prefs = await SharedPreferences.getInstance();
    this.national = national;
    await prefs.setString("national", national);
  }

  void debugPrint() {
    print("========== USER SHARE DEBUG ==========");
    print("ID       : $id");
    print("Name     : $name");
    print("Email    : $email");
    print("Photo    : $photoUrl");
    print("National : $national");
    print("Level    : $level");
    print("Streak   : $dailyStreak");
    print("======================================");
  }
}
