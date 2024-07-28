class Countryz {
  final String name;
  final String nativeName;
  final String code;
  final String prefix;

  const Countryz({
    required this.name,
    required this.nativeName,
    required this.code,
    required this.prefix,
  });

  factory Countryz.fromJson(Map<String, dynamic> json) => Countryz(
        name: json['name'],
        code: json['code'],
        nativeName: json['native'],
        prefix: json['phone'],
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Countryz &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          nativeName == other.nativeName &&
          code == other.code &&
          prefix == other.prefix;

  @override
  int get hashCode =>
      name.hashCode ^ nativeName.hashCode ^ code.hashCode ^ prefix.hashCode;
}
