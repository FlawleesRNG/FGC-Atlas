import 'package:flutter/material.dart';

class AtlasStatCard extends StatelessWidget {
  const AtlasStatCard({
    required this.label,
    required this.value,
    this.valueFirst = true,
    super.key,
  });

  final String label;
  final String value;
  final bool valueFirst;

  @override
  Widget build(BuildContext context) {
    final labelText = Text(
      label,
      style: const TextStyle(
        color: Color(0xFF667085),
        fontWeight: FontWeight.w700,
      ),
    );
    final valueText = Text(
      value,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w900,
        letterSpacing: 0,
      ),
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: valueFirst
            ? [valueText, const SizedBox(height: 5), labelText]
            : [labelText, const SizedBox(height: 6), valueText],
      ),
    );
  }
}
