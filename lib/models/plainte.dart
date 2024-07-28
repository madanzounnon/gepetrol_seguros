import 'dart:convert';

class Plainte {
  final int id;
  final String title;
  final String status;
  final String? description;

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
      status: map['state'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Plainte.fromJson(String source) =>
      Plainte.fromMap(json.decode(source) as Map<String, dynamic>);
}
