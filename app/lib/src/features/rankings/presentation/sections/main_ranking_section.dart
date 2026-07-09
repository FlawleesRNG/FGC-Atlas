import 'package:flutter/material.dart';

import '../../../home/presentation/widgets/atlas_section_title.dart';
import '../widgets/ranking_player.dart';
import '../widgets/ranking_player_card.dart';

class MainRankingSection extends StatelessWidget {
  const MainRankingSection({required this.players, super.key});

  final List<RankingPlayer> players;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AtlasSectionTitle('Ranking Principal'),
        const SizedBox(height: 12),
        for (final player in players) ...[
          RankingPlayerCard(player: player),
          if (player != players.last) const SizedBox(height: 10),
        ],
      ],
    );
  }
}
