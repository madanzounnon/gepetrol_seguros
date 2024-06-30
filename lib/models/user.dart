// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gepetrol_eguros/helper/utile.dart';

class User {
  int id;
  String email;
  String first_name;
  String last_name;
  String username;
  String? sex;
  int? status;
  String? email_verified_at;
  String? phone;
  String? profile_picture;
  User({
    required this.id,
    required this.email,
    required this.first_name,
    required this.last_name,
    required this.username,
    this.sex,
    this.status,
    this.email_verified_at,
    this.phone,
    this.profile_picture,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'first_name': first_name,
      'last_name': last_name,
      'username': username,
      'sex': sex,
      'status': status,
      'email_verified_at': email_verified_at,
      'phone': phone,
      'profile_picture': profile_picture,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      email: map['email'] as String,
      first_name: map['first_name'] as String,
      last_name: map['last_name'] as String,
      username: map['email'] as String,
      sex: map['sex'] != null ? map['sex'] as String : null,
      status: map['status'] != null ? map['status'] as int : null,
      email_verified_at: map['email_verified_at'] != null
          ? map['email_verified_at'] as String
          : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      profile_picture: map['profile_picture'] != null
          ? map['profile_picture'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
