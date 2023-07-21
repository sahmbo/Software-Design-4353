import 'dart:convert';
import 'package:flutter_application_1/AppAuth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/loginPageModel.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/loginPageModel.dart';
import 'package:crypto/crypto.dart';

class UserController {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('UserCredentials');

  Future<bool> saveUser(User user) async {
    var bytes = utf8.encode(user.password);
    var digest = sha256.convert(bytes);
    User hashedUser =
        user.copyWith(password: digest.toString()); // Hashed password
    try {
      await users.doc(hashedUser.username).set(hashedUser.toJson());
      AppAuth.instance.userName = user.username;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<User?> fetchUser(String username, String password) async {
    try {
      var bytes = utf8.encode(password);
      var digest = sha256.convert(bytes);
      DocumentSnapshot result = await users.doc(username).get();

      if (result.exists) {
        Map<String, dynamic> data = result.data() as Map<String, dynamic>;
        User user = User.fromJson(data);

        if (user.password == digest.toString()) {
          AppAuth.instance.userName = user.username;
          return user;
        }
      }

      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
