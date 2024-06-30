// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gepetrol_eguros/models/user.dart';

class LoginSuccess {
  bool success;
  User user;
  String token;
  LoginSuccess({
    required this.success,
    required this.user,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'user': user.toMap(),
      'token': token,
    };
  }

  factory LoginSuccess.fromMap(Map<String, dynamic> map) {
    return LoginSuccess(
      success: map['success'] as bool,
      user: User.fromMap(map['response']['user'] as Map<String, dynamic>),
      token: map['response']['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginSuccess.fromJson(String source) =>
      LoginSuccess.fromMap(json.decode(source) as Map<String, dynamic>);
}
