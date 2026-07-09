import 'package:flutter/material.dart';

class RankingFiltersSection extends StatelessWidget {
  const RankingFiltersSection({super.key});

  static const _filters = [
    'Todos',
    'Brasil',
    'Estado',
    'Cidade',
    'Offline',
    'Online',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final filter in _filters) ...[
            ChoiceChip(
              label: Text(filter),
              selected: filter == 'Todos',
              onSelected: (_) {},
            ),
            if (filter != _filters.last) const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}
