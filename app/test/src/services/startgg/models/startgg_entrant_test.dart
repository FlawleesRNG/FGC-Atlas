import 'package:app/src/services/startgg/models/startgg_entrant.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StartGGEntrant.fromJson', () {
    test('parses seed and multiple participants', () {
      final entrant = StartGGEntrant.fromJson({
        'id': 789,
        'name': 'PlayerOne / PlayerTwo',
        'seeds': [
          {'seedNum': 3},
        ],
        'participants': [
          {'id': 1, 'gamerTag': 'PlayerOne'},
          {'id': 2, 'gamerTag': 'PlayerTwo'},
        ],
      });

      expect(entrant.id, 789);
      expect(entrant.name, 'PlayerOne / PlayerTwo');
      expect(entrant.seed, 3);
      expect(entrant.participants, hasLength(2));
    });

    test('accepts null seed and an absent participant list', () {
      final entrant = StartGGEntrant.fromJson({
        'id': 789,
        'name': 'Unseeded entrant',
        'seeds': const <Object?>[],
      });

      expect(entrant.seed, isNull);
      expect(entrant.participants, isEmpty);
    });
  });
}
