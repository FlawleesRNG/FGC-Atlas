import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/atlas_bottom_navigation_bar.dart';
import '../sections/characters_section.dart';
import '../sections/header_section.dart';
import '../sections/hero_card_section.dart';
import '../sections/recent_events_section.dart';
import '../sections/stats_section.dart';
import '../sections/update_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const routeName = 'home';
  static const routePath = '/';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: _HomeDashboard()),
      bottomNavigationBar: AtlasBottomNavigationBar(selectedIndex: 0),
    );
  }
}

class _HomeDashboard extends StatelessWidget {
  const _HomeDashboard();

  static const _desktopBreakpoint = 700.0;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom + 96;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= _desktopBreakpoint;
        final maxContentWidth = isDesktop ? 1120.0 : 430.0;

        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: HeaderSection(maxWidth: maxContentWidth)),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16, 14, 16, bottomPadding),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxContentWidth),
                    child: _DashboardSections(isDesktop: isDesktop),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DashboardSections extends StatelessWidget {
  const _DashboardSections({required this.isDesktop});

  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    if (isDesktop) {
      return const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HeroCardSection(),
                SizedBox(height: 20),
                CharactersSection(),
                SizedBox(height: 20),
                RecentEventsSection(),
              ],
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [UpdateSection(), SizedBox(height: 20), StatsSection()],
            ),
          ),
        ],
      );
    }

    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        HeroCardSection(),
        SizedBox(height: 20),
        CharactersSection(),
        SizedBox(height: 20),
        UpdateSection(),
        SizedBox(height: 20),
        StatsSection(),
        SizedBox(height: 20),
        RecentEventsSection(),
      ],
    );
  }
}
