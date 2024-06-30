// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Categorie {
  final int id;
  final String title;
  final String code_category;
  final String? description;
  Categorie({
    required this.id,
    required this.title,
    required this.code_category,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'code_category': code_category,
      'description': description,
    };
  }

  factory Categorie.fromMap(Map<String, dynamic> map) {
    return Categorie(
      id: map['id'] as int,
      title: map['title'] as String,
      code_category: map['code_category'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Categorie.fromJson(String source) =>
      Categorie.fromMap(json.decode(source) as Map<String, dynamic>);
}
