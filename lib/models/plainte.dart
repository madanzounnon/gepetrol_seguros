// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Plainte {
  final int id;
  final String title;
  final String? description;
  final int status;
  Plainte({
    required this.id,
    required this.title,
    this.description,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'status': status,
    };
  }

  factory Plainte.fromMap(Map<String, dynamic> map) {
    return Plainte(
      id: map['id'] as int,
      title: map['title'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      status: map['status'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Plainte.fromJson(String source) =>
      Plainte.fromMap(json.decode(source) as Map<String, dynamic>);
}
