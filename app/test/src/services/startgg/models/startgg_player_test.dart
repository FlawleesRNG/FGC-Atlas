import 'package:app/src/services/startgg/models/startgg_player.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StartGGPlayer.fromJson', () {
    test('parses player and linked user fields', () {
      final player = StartGGPlayer.fromJson({
        'id': 123,
        'gamerTag': 'PlayerOne',
        'user': {'id': 456, 'slug': 'user/player-one', 'discriminator': '1234'},
      });

      expect(player.id, 123);
      expect(player.userId, 456);
      expect(player.name, 'PlayerOne');
      expect(player.slug, 'user/player-one');
      expect(player.discriminator, '1234');
    });

    test('accepts every field as optional', () {
      final player = StartGGPlayer.fromJson(const {});

      expect(player.id, isNull);
      expect(player.userId, isNull);
      expect(player.name, isNull);
      expect(player.slug, isNull);
      expect(player.discriminator, isNull);
    });
  });
}
