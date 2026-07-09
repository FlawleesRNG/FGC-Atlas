import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/rankings/presentation/pages/rankings_page.dart';

class AtlasBottomNavigationBar extends StatelessWidget {
  const AtlasBottomNavigationBar({required this.selectedIndex, super.key});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) => _onDestinationSelected(context, index),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.leaderboard_outlined),
          selectedIcon: Icon(Icons.leaderboard_rounded),
          label: 'Rankings',
        ),
        NavigationDestination(
          icon: Icon(Icons.event_outlined),
          selectedIcon: Icon(Icons.event_rounded),
          label: 'Eventos',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline_rounded),
          selectedIcon: Icon(Icons.person_rounded),
          label: 'Perfil',
        ),
      ],
    );
  }

  void _onDestinationSelected(BuildContext context, int index) {
    if (index == selectedIndex) {
      return;
    }

    switch (index) {
      case 0:
        context.go(HomePage.routePath);
      case 1:
        context.go(RankingsPage.routePath);
      case 2:
      case 3:
        break;
    }
  }
}
