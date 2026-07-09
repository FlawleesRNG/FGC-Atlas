import 'package:flutter/material.dart';

class RankingsHeaderSection extends StatelessWidget {
  const RankingsHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rankings',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Veja a classifica\u00E7\u00E3o competitiva da comunidade.',
          style: textTheme.bodyMedium?.copyWith(
            color: const Color(0xFF667085),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
