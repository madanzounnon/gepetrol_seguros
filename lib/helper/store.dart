import 'dart:convert';
import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:gepetrol_eguros/models/user.dart';

class StoreAuth {
  final Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();

  Future<String?> getToken() async {
    final SharedPreferences sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getString('token');
  }

  Future<String?> getUserId() async {
    final SharedPreferences sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getString('userId');
  }

  Future<String?> getCode() async {
    final SharedPreferences sharedPreferences = await _sharedPreferences;
    return sharedPreferences.getString('code');
  }

  Future<User> getUser() async {
    final SharedPreferences sharedPreferences = await _sharedPreferences;
    //return jsonDecode(sharedPreferences.getString('user')!);
    print(sharedPreferences.getString('user'));
    //print(json.decode(sharedPreferences.getString('user')!));
    //rprint(json.decode(sharedPreferences.getString('user')!)["email"]);
    var users;
    if (sharedPreferences.getString('user') != null) {
      users = json.decode(sharedPreferences.getString('user')!);
    }
    print(users["first_subscription"]);
    print(User.fromMap(users));
    return User.fromMap(users);
  }

  Future<void> saveUserId(Map<String, dynamic> user) async {
    final SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString('userId', user["id"].toString());
  }

  Future<bool> saveCode(String code) async {
    final SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.remove("empreinte");
    return sharedPreferences.setString('code', code);
  }

  Future<bool> saveEmpreinte(String val) async {
    final SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.remove("code");
    return sharedPreferences.setString("empreinte", val);
  }

  Future<void> saveToken(String token) async {
    final SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString('token', token);
  }

  Future<void> saveUser(Map<String, dynamic> user) async {
    saveUserId(user);
    final SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.setString('user', json.encode(user));
  }

  Future<void> restoreUser() async {
    final SharedPreferences sharedPreferences = await _sharedPreferences;
    sharedPreferences.remove('token');
    sharedPreferences.remove('user');
    sharedPreferences.remove('userId');
  }

  Future<bool> logout() async {
    restoreUser();
    return true;
  }
}
