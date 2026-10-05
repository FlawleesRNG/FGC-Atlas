import 'startgg_event.dart';

class StartGGTournament {
  const StartGGTournament({
    required this.id,
    required this.name,
    required this.slug,
    required this.events,
    this.startAt,
    this.numAttendees,
  });

  factory StartGGTournament.fromJson(Map<String, dynamic> json) {
    final startAt = _intFromJson(json['startAt']);
    final rawEvents = json['events'];
    final participants = json['participants'];
    final pageInfo = participants is Map<String, dynamic>
        ? participants['pageInfo']
        : null;
    final participantTotal = pageInfo is Map<String, dynamic>
        ? _intFromJson(pageInfo['total'])
        : null;

    return StartGGTournament(
      id: _intFromJson(json['id']) ?? 0,
      name: json['name'] is String ? json['name'] as String : '',
      slug: json['slug'] is String ? json['slug'] as String : '',
      startAt: startAt == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(startAt * 1000, isUtc: true),
      numAttendees: _intFromJson(json['numAttendees']) ?? participantTotal,
      events: rawEvents is List
          ? rawEvents
                .whereType<Map<String, dynamic>>()
                .map(StartGGEvent.fromJson)
                .toList(growable: false)
          : const [],
    );
  }

  final int id;
  final String name;
  final String slug;
  final DateTime? startAt;
  final int? numAttendees;
  final List<StartGGEvent> events;
}

int? _intFromJson(Object? value) {
  return switch (value) {
    int number => number,
    String text => int.tryParse(text),
    _ => null,
  };
}
