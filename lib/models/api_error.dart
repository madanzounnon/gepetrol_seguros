// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ApiError {
  String? message;
  String? errors;
  ApiError({
    this.message,
    this.errors,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'errors': errors,
    };
  }

  factory ApiError.fromMap(Map<String, dynamic> map) {
    return ApiError(
      message: map['message'] != null ? map['message'] as String : null,
      errors: map['errors'] != null ? map['errors'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiError.fromJson(String source) =>
      ApiError.fromMap(json.decode(source) as Map<String, dynamic>);
}
