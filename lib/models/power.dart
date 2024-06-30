// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Power {
  final int id;
  final String min_power;
  final String max_power;
  Power({
    required this.id,
    required this.min_power,
    required this.max_power,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'min_power': min_power,
      'max_power': max_power,
    };
  }

  factory Power.fromMap(Map<String, dynamic> map) {
    return Power(
      id: map['id'] as int,
      min_power: map['min_power'] as String,
      max_power: map['max_power'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Power.fromJson(String source) =>
      Power.fromMap(json.decode(source) as Map<String, dynamic>);
}
