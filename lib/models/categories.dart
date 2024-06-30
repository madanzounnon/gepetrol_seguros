import 'dart:convert';

class Categorie {
  final String title;
  final String code_category;
  final String? description;
  Categorie({
    required this.title,
    required this.code_category,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'code_category': code_category,
      'description': description,
    };
  }

  factory Categorie.fromMap(Map<String, dynamic> map) {
    return Categorie(
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
