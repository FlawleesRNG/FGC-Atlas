import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/atlas_bottom_navigation_bar.dart';
import '../sections/main_ranking_section.dart';
import '../sections/ranking_filters_section.dart';
import '../sections/ranking_search_section.dart';
import '../sections/rankings_header_section.dart';
import '../sections/user_ranking_highlight_section.dart';
import '../widgets/ranking_player.dart';

class RankingsPage extends StatelessWidget {
  const RankingsPage({super.key});

  static const routeName = 'rankings';
  static const routePath = '/rankings';

  static const _desktopBreakpoint = 700.0;
  static const _players = [
    RankingPlayer(
      position: 1,
      nick: 'GrandMaster',
      mainCharacter: 'Hero',
      tier: 'S',
      atlasScore: 2860,
    ),
    RankingPlayer(
      position: 2,
      nick: 'PlayerX',
      mainCharacter: 'Steve',
      tier: 'S',
      atlasScore: 2752,
    ),
    RankingPlayer(
      position: 3,
      nick: 'Flawlees',
      mainCharacter: 'Byleth',
      tier: 'S',
      atlasScore: 2148,
    ),
    RankingPlayer(
      position: 4,
      nick: 'Lucas',
      mainCharacter: 'Cloud',
      tier: 'A',
      atlasScore: 2074,
    ),
    RankingPlayer(
      position: 5,
      nick: 'Nana',
      mainCharacter: 'Palutena',
      tier: 'A',
      atlasScore: 2018,
    ),
    RankingPlayer(
      position: 6,
      nick: 'ZeroBR',
      mainCharacter: 'Roy',
      tier: 'A',
      atlasScore: 1986,
    ),
    RankingPlayer(
      position: 7,
      nick: 'Kira',
      mainCharacter: 'Fox',
      tier: 'A',
      atlasScore: 1934,
    ),
    RankingPlayer(
      position: 8,
      nick: 'Maverick',
      mainCharacter: 'Snake',
      tier: 'B',
      atlasScore: 1888,
    ),
    RankingPlayer(
      position: 9,
      nick: 'Akira',
      mainCharacter: 'Ryu',
      tier: 'B',
      atlasScore: 1842,
    ),
    RankingPlayer(
      position: 10,
      nick: 'Wave',
      mainCharacter: 'Inkling',
      tier: 'B',
      atlasScore: 1810,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: _RankingsContent(players: _players)),
      bottomNavigationBar: AtlasBottomNavigationBar(selectedIndex: 1),
    );
  }
}

class _RankingsContent extends StatelessWidget {
  const _RankingsContent({required this.players});

  final List<RankingPlayer> players;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom + 96;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop =
            constraints.maxWidth >= RankingsPage._desktopBreakpoint;
        final maxContentWidth = isDesktop ? 760.0 : 430.0;

        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.fromLTRB(16, 26, 16, bottomPadding),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxContentWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const RankingsHeaderSection(),
                        const SizedBox(height: 20),
                        const RankingSearchSection(),
                        const SizedBox(height: 14),
                        const RankingFiltersSection(),
                        const SizedBox(height: 24),
                        MainRankingSection(players: players),
                        const SizedBox(height: 20),
                        const UserRankingHighlightSection(),
                      ],
                    ),
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
