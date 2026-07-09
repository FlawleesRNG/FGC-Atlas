import 'package:go_router/go_router.dart';

import '../../features/home/presentation/pages/home_page.dart';
import '../../features/rankings/presentation/pages/rankings_page.dart';

final appRouter = GoRouter(
  initialLocation: HomePage.routePath,
  routes: [
    GoRoute(
      path: HomePage.routePath,
      name: HomePage.routeName,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: RankingsPage.routePath,
      name: RankingsPage.routeName,
      builder: (context, state) => const RankingsPage(),
    ),
  ],
);
