import 'dart:convert';

class TypeRemoque {
  final String title;
  final String? description;
  TypeRemoque({
    required this.title,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
    };
  }

  factory TypeRemoque.fromMap(Map<String, dynamic> map) {
    return TypeRemoque(
      title: map['title'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeRemoque.fromJson(String source) =>
      TypeRemoque.fromMap(json.decode(source) as Map<String, dynamic>);
}
