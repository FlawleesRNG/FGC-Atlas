import 'package:app/src/services/startgg/models/startgg_videogame.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StartGGVideogame.fromJson', () {
    test('parses required and optional fields', () {
      final videogame = StartGGVideogame.fromJson({
        'id': 1386,
        'name': 'Super Smash Bros. Ultimate',
        'displayName': 'Ultimate',
        'slug': 'game/ultimate',
      });

      expect(videogame.id, 1386);
      expect(videogame.name, 'Super Smash Bros. Ultimate');
      expect(videogame.displayName, 'Ultimate');
      expect(videogame.slug, 'game/ultimate');
    });

    test('uses safe values when optional or required fields are absent', () {
      final videogame = StartGGVideogame.fromJson(const {});

      expect(videogame.id, 0);
      expect(videogame.name, isEmpty);
      expect(videogame.displayName, isNull);
      expect(videogame.slug, isNull);
    });
  });
}
