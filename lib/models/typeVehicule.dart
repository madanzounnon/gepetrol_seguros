import 'dart:convert';

class TypeVehicule {
  final String title;
  final String? description;
  TypeVehicule({
    required this.title,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
    };
  }

  factory TypeVehicule.fromMap(Map<String, dynamic> map) {
    return TypeVehicule(
      title: map['title'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeVehicule.fromJson(String source) =>
      TypeVehicule.fromMap(json.decode(source) as Map<String, dynamic>);
}
