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

  Future<void> saveUser({
    required String id,
    required String name,
    required String email,
    required String photoUrl,
    required String national,
  }) async {
    this.id = id;
    this.name = name;
    this.email = email;
    this.photoUrl = photoUrl;
    this.national = national;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("id", id);
    await prefs.setString("name", name);
    await prefs.setString("email", email);
    await prefs.setString("photoUrl", photoUrl);
    await prefs.setString("national", national);
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id");
    name = prefs.getString("name");
    email = prefs.getString("email");
    photoUrl = prefs.getString("photoUrl");
    national = prefs.getString("national");
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    id = null;
    name = null;
    email = null;
    photoUrl = null;
    national = null;
  }

  void debugPrint() {
    print("========== USER SHARE DEBUG ==========");
    print("ID       : $id");
    print("Name     : $name");
    print("Email    : $email");
    print("Photo    : $photoUrl");
    print("National : $national");
    print("======================================");
  }
}
