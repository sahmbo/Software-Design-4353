import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/loginPageModel.dart';

class UserController {
  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', jsonEncode(user.toJson()));
  }

  Future<User?> fetchUser(String username, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');

    if (userData == null) {
      return null;
    }

    Map<String, dynamic> decodedUserData = jsonDecode(userData);
    return User(
      username: decodedUserData['username'] as String,
      password: decodedUserData['password'] as String,
    );
  }
}
