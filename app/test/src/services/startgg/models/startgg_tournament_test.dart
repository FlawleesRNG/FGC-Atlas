import 'package:app/src/services/startgg/models/startgg_tournament.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StartGGTournament.fromJson', () {
    test('parses tournament, timestamp, attendees and events', () {
      const timestamp = 1700000000;
      final tournament = StartGGTournament.fromJson({
        'id': 517161,
        'name': 'GENESIS X',
        'slug': 'tournament/genesis-x',
        'startAt': timestamp,
        'participants': {
          'pageInfo': {'total': 4786},
        },
        'events': [
          {
            'id': 1002632,
            'name': 'Ultimate Singles',
            'slug': 'tournament/genesis-x/event/ultimate-singles',
            'numEntrants': 1518,
            'videogame': {'id': 1386, 'name': 'Ultimate'},
          },
        ],
      });

      expect(tournament.id, 517161);
      expect(tournament.name, 'GENESIS X');
      expect(tournament.slug, 'tournament/genesis-x');
      expect(
        tournament.startAt,
        DateTime.fromMillisecondsSinceEpoch(timestamp * 1000, isUtc: true),
      );
      expect(tournament.numAttendees, 4786);
      expect(tournament.events, hasLength(1));
      expect(tournament.events.single.name, 'Ultimate Singles');
    });

    test('accepts null fields and an empty event list', () {
      final tournament = StartGGTournament.fromJson({
        'id': 1,
        'name': 'Tournament without schedule',
        'slug': 'tournament/without-schedule',
        'startAt': null,
        'numAttendees': null,
        'events': <Object?>[],
      });

      expect(tournament.startAt, isNull);
      expect(tournament.numAttendees, isNull);
      expect(tournament.events, isEmpty);
    });

    test('uses safe values when required fields are absent', () {
      final tournament = StartGGTournament.fromJson(const {});

      expect(tournament.id, 0);
      expect(tournament.name, isEmpty);
      expect(tournament.slug, isEmpty);
      expect(tournament.startAt, isNull);
      expect(tournament.numAttendees, isNull);
      expect(tournament.events, isEmpty);
    });
  });
}
