import 'package:flutter/material.dart';

class UserRankingHighlightSection extends StatelessWidget {
  const UserRankingHighlightSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFEFF6FF),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sua coloca\u00E7\u00E3o:',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 0,
              ),
            ),
            const SizedBox(height: 14),
            const Row(
              children: [
                Expanded(
                  child: _HighlightMetric(
                    label: 'Posi\u00E7\u00E3o',
                    value: '#17',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _HighlightMetric(label: 'Atlas Score', value: '2148'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const _HighlightMetric(
              label: 'Dist\u00E2ncia para Top 10',
              value: '+138 pontos',
            ),
          ],
        ),
      ),
    );
  }
}

class _HighlightMetric extends StatelessWidget {
  const _HighlightMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFD1E9FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF667085),
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF1565C0),
              fontSize: 22,
              fontWeight: FontWeight.w900,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }
}
