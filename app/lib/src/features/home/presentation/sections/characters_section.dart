import 'package:flutter/material.dart';

import '../widgets/atlas_card.dart';
import '../widgets/atlas_stat_card.dart';

class CharactersSection extends StatelessWidget {
  const CharactersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const AtlasCard(
      title: 'Personagens',
      child: Row(
        children: [
          Expanded(
            child: AtlasStatCard(
              label: 'Main',
              value: 'Byleth',
              valueFirst: false,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: AtlasStatCard(
              label: 'Secondary',
              value: 'Cloud',
              valueFirst: false,
            ),
          ),
        ],
      ),
    );
  }
}
