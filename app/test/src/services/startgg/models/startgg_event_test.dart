import 'package:app/src/services/startgg/models/startgg_event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StartGGEvent.fromJson', () {
    test('parses the event and its videogame', () {
      final event = StartGGEvent.fromJson({
        'id': 1002632,
        'name': 'Ultimate Singles',
        'slug': 'tournament/genesis-x/event/ultimate-singles',
        'numEntrants': 1518,
        'videogame': {
          'id': 1386,
          'name': 'Super Smash Bros. Ultimate',
          'displayName': 'Ultimate',
          'slug': 'game/ultimate',
        },
      });

      expect(event.id, 1002632);
      expect(event.name, 'Ultimate Singles');
      expect(event.slug, 'tournament/genesis-x/event/ultimate-singles');
      expect(event.numEntrants, 1518);
      expect(event.videogame?.displayName, 'Ultimate');
    });

    test('accepts null entrants and videogame', () {
      final event = StartGGEvent.fromJson({
        'id': 1,
        'name': 'Side Event',
        'slug': 'tournament/example/event/side-event',
        'numEntrants': null,
        'videogame': null,
      });

      expect(event.numEntrants, isNull);
      expect(event.videogame, isNull);
    });

    test('uses safe values when required fields are absent', () {
      final event = StartGGEvent.fromJson(const {});

      expect(event.id, 0);
      expect(event.name, isEmpty);
      expect(event.slug, isEmpty);
      expect(event.numEntrants, isNull);
      expect(event.videogame, isNull);
    });
  });
}
