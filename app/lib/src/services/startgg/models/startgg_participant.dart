import 'startgg_player.dart';

class StartGGParticipant {
  const StartGGParticipant({
    required this.id,
    required this.gamerTag,
    this.prefix,
    this.player,
  });

  factory StartGGParticipant.fromJson(Map<String, dynamic> json) {
    final player = json['player'];
    final user = json['user'];
    final playerJson = player is Map<String, dynamic> ? player : null;
    final userJson = user is Map<String, dynamic> ? user : null;
    final linkedIdentity = playerJson == null && userJson == null
        ? null
        : <String, dynamic>{...?playerJson, 'user': ?userJson};
    final playerModel = linkedIdentity == null
        ? null
        : StartGGPlayer.fromJson(linkedIdentity);
    final gamerTag =
        _nonEmptyString(json['gamerTag']) ??
        playerModel?.name ??
        'Unknown player';

    return StartGGParticipant(
      id: _intFromJson(json['id']) ?? 0,
      gamerTag: gamerTag,
      prefix: _nonEmptyString(json['prefix']),
      player: playerModel,
    );
  }

  final int id;
  final String gamerTag;
  final String? prefix;
  final StartGGPlayer? player;
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
