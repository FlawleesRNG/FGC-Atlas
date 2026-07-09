import 'package:flutter/material.dart';

import 'src/core/routing/app_router.dart';
import 'src/core/theme/atlas_theme.dart';

class AtlasApp extends StatelessWidget {
  const AtlasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FGC Atlas',
      debugShowCheckedModeBanner: false,
      theme: AtlasTheme.light,
      routerConfig: appRouter,
    );
  }
}
