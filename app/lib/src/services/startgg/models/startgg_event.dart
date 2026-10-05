import 'startgg_videogame.dart';

class StartGGEvent {
  const StartGGEvent({
    required this.id,
    required this.name,
    required this.slug,
    this.numEntrants,
    this.videogame,
  });

  factory StartGGEvent.fromJson(Map<String, dynamic> json) {
    final videogame = json['videogame'];

    return StartGGEvent(
      id: _intFromJson(json['id']) ?? 0,
      name: json['name'] is String ? json['name'] as String : '',
      slug: json['slug'] is String ? json['slug'] as String : '',
      numEntrants: _intFromJson(json['numEntrants']),
      videogame: videogame is Map<String, dynamic>
          ? StartGGVideogame.fromJson(videogame)
          : null,
    );
  }

  final int id;
  final String name;
  final String slug;
  final int? numEntrants;
  final StartGGVideogame? videogame;
}

int? _intFromJson(Object? value) {
  return switch (value) {
    int number => number,
    String text => int.tryParse(text),
    _ => null,
  };
}
