import 'package:flutter/material.dart';

import '../widgets/atlas_card.dart';
import '../widgets/atlas_stat_card.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const AtlasCard(
      title: 'EstatÃ­sticas Gerais',
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AtlasStatCard(label: 'Winrate', value: '68.2%'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: AtlasStatCard(label: 'Eventos', value: '47'),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: AtlasStatCard(label: 'Top 8s', value: '18'),
              ),
              SizedBox(width: 12),
              Expanded(
                child: AtlasStatCard(label: 'Consistency', value: '82.1'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
