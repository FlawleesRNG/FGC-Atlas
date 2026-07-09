import 'package:flutter/material.dart';

import 'atlas_section_title.dart';

class AtlasCard extends StatelessWidget {
  const AtlasCard({
    required this.title,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    super.key,
  });

  final String title;
  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AtlasSectionTitle(title),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}
