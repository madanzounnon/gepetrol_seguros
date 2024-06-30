// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TypeVehicule {
  final int id;
  final String title;
  final String? description;
  TypeVehicule({
    required this.id,
    required this.title,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory TypeVehicule.fromMap(Map<String, dynamic> map) {
    return TypeVehicule(
      id: map['id'] as int,
      title: map['title'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeVehicule.fromJson(String source) =>
      TypeVehicule.fromMap(json.decode(source) as Map<String, dynamic>);
}
