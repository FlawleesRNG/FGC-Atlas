import 'startgg_participant.dart';

class StartGGEntrant {
  const StartGGEntrant({
    required this.id,
    required this.name,
    required this.participants,
    this.seed,
  });

  factory StartGGEntrant.fromJson(Map<String, dynamic> json) {
    final rawParticipants = json['participants'];
    final rawSeeds = json['seeds'];
    final firstSeed = rawSeeds is List && rawSeeds.isNotEmpty
        ? rawSeeds.first
        : null;
    final seedJson = firstSeed is Map<String, dynamic> ? firstSeed : null;

    return StartGGEntrant(
      id: _intFromJson(json['id']) ?? 0,
      name: _nonEmptyString(json['name']) ?? 'Unnamed entrant',
      seed: _intFromJson(json['seed']) ?? _intFromJson(seedJson?['seedNum']),
      participants: rawParticipants is List
          ? rawParticipants
                .whereType<Map<String, dynamic>>()
                .map(StartGGParticipant.fromJson)
                .toList(growable: false)
          : const [],
    );
  }

  final int id;
  final String name;
  final int? seed;
  final List<StartGGParticipant> participants;
}

int? _intFromJson(Object? value) {
  return switch (value) {
    int number => number,
    String text => int.tryParse(text),
    _ => null,
  };
}

String? _nonEmptyString(Object? value) {
  if (value is! String || value.trim().isEmpty) {
    return null;
  }
  return value;
}
