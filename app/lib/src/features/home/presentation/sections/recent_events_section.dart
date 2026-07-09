import 'package:flutter/material.dart';

import '../widgets/atlas_card.dart';

class RecentEventsSection extends StatelessWidget {
  const RecentEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const AtlasCard(
      title: 'Eventos Recentes',
      child: Column(
        children: [
          _EventRow(
            name: 'Overdrive Arena #12',
            placement: '2Âº',
            delta: '+48',
          ),
          _Divider(),
          _EventRow(name: 'Floripa Smash Fest', placement: '3Âº', delta: '+32'),
          _Divider(),
          _EventRow(name: 'SuperXP 2025', placement: '5Âº', delta: '+18'),
        ],
      ),
    );
  }
}

class _EventRow extends StatelessWidget {
  const _EventRow({
    required this.name,
    required this.placement,
    required this.delta,
  });

  final String name;
  final String placement;
  final String delta;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          Text(
            placement,
            style: const TextStyle(
              color: Color(0xFF475467),
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 48,
            child: Text(
              delta,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: Color(0xFF047857),
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(height: 18, color: Color(0xFFE5E7EB));
  }
}
