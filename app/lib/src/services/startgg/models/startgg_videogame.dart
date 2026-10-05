class StartGGVideogame {
  const StartGGVideogame({
    required this.id,
    required this.name,
    this.displayName,
    this.slug,
  });

  factory StartGGVideogame.fromJson(Map<String, dynamic> json) {
    return StartGGVideogame(
      id: _intFromJson(json['id']) ?? 0,
      name: json['name'] is String ? json['name'] as String : '',
      displayName: json['displayName'] is String
          ? json['displayName'] as String
          : null,
      slug: json['slug'] is String ? json['slug'] as String : null,
    );
  }

  final int id;
  final String name;
  final String? displayName;
  final String? slug;
}

int? _intFromJson(Object? value) {
  return switch (value) {
    int number => number,
    String text => int.tryParse(text),
    _ => null,
  };
}
