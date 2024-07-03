import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Accessorie {
  final int id;
  final String title;
  final String? description;
  final int value;
  final int accessory;
  bool isChecked = false;
  Accessorie({
    required this.id,
    required this.title,
    this.description,
    required this.value,
    required this.accessory,
    this.isChecked = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'value': value,
      'accessory': accessory,
      'isChecked': isChecked,
    };
  }

  factory Accessorie.fromMap(Map<String, dynamic> map) {
    return Accessorie(
      id: map['id'] as int,
      title: map['title'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      value: map['value'] as int,
      accessory: map['accessory'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Accessorie.fromJson(String source) =>
      Accessorie.fromMap(json.decode(source) as Map<String, dynamic>);
}
