// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Marque {
  final int id;
  final String title;
  final String? description;
  final String? image;
  final int? most_used;
  Marque({
    required this.id,
    required this.title,
    this.description,
    this.image,
    this.most_used,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'most_used': most_used,
    };
  }

  factory Marque.fromMap(Map<String, dynamic> map) {
    return Marque(
      id: map['id'] as int,
      title: map['title'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      most_used: map['most_used'] != null ? map['most_used'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Marque.fromJson(String source) =>
      Marque.fromMap(json.decode(source) as Map<String, dynamic>);
}
