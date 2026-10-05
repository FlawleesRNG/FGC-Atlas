class StartGGPlayer {
  const StartGGPlayer({
    this.id,
    this.userId,
    this.slug,
    this.name,
    this.discriminator,
  });

  factory StartGGPlayer.fromJson(Map<String, dynamic> json) {
    final user = json['user'];
    final userJson = user is Map<String, dynamic> ? user : null;

    return StartGGPlayer(
      id: _intFromJson(json['id']),
      userId: _intFromJson(userJson?['id']),
      slug: _stringFromJson(json['slug']) ?? _stringFromJson(userJson?['slug']),
      name: _stringFromJson(json['name']) ?? _stringFromJson(json['gamerTag']),
      discriminator:
          _stringFromJson(json['discriminator']) ??
          _stringFromJson(userJson?['discriminator']),
    );
  }

  final int? id;
  final int? userId;
  final String? slug;
  final String? name;
  final String? discriminator;
}

int? _intFromJson(Object? value) {
  return switch (value) {
    int number => number,
    String text => int.tryParse(text),
    _ => null,
  };
}

String? _stringFromJson(Object? value) {
  if (value is! String || value.trim().isEmpty) {
    return null;
  }
  return value;
}
