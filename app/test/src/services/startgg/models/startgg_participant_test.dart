import 'package:app/src/services/startgg/models/startgg_participant.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StartGGParticipant.fromJson', () {
    test('parses participant, player and user data', () {
      final participant = StartGGParticipant.fromJson({
        'id': 456,
        'gamerTag': 'PlayerOne',
        'prefix': 'ABC',
        'player': {'id': 123, 'gamerTag': 'PlayerOne'},
        'user': {'id': 456, 'slug': 'user/player-one', 'discriminator': '1234'},
      });

      expect(participant.id, 456);
      expect(participant.gamerTag, 'PlayerOne');
      expect(participant.prefix, 'ABC');
      expect(participant.player?.id, 123);
      expect(participant.player?.userId, 456);
      expect(participant.player?.slug, 'user/player-one');
    });

    test('accepts participant without linked player or user', () {
      final participant = StartGGParticipant.fromJson({
        'id': 456,
        'gamerTag': 'Guest',
        'prefix': null,
        'player': null,
        'user': null,
      });

      expect(participant.prefix, isNull);
      expect(participant.player, isNull);
    });

    test('uses a safe fallback for null or empty gamerTag', () {
      final nullTag = StartGGParticipant.fromJson({'gamerTag': null});
      final emptyTag = StartGGParticipant.fromJson({'gamerTag': '  '});

      expect(nullTag.gamerTag, 'Unknown player');
      expect(emptyTag.gamerTag, 'Unknown player');
    });
  });
}
