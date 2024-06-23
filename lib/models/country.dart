
class Country {
  final String name;
  final String nativeName;
  final String code;
  final String prefix;

  const Country({
    required this.name,
    required this.nativeName,
    required this.code,
    required this.prefix,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json['name'],
        code: json['code'],
        nativeName: json['native'],
        prefix: json['phone'],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          nativeName == other.nativeName &&
          code == other.code &&
          prefix == other.prefix;

  @override
  int get hashCode => name.hashCode ^ nativeName.hashCode ^ code.hashCode ^ prefix.hashCode;
}
