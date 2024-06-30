import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Caburant {
  final String title;
  final String code;
  final String? description;
  Caburant({
    required this.title,
    required this.code,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'code': code,
      'description': description,
    };
  }

  factory Caburant.fromMap(Map<String, dynamic> map) {
    return Caburant(
      title: map['title'] as String,
      code: map['code'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Caburant.fromJson(String source) =>
      Caburant.fromMap(json.decode(source) as Map<String, dynamic>);
}
