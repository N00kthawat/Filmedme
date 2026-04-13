import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/widgets/app_top_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return DefaultTabController(
      length: 2,
      child: DecoratedBox(
        decoration: BoxDecoration(color: colors.bg),
        child: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 36),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const AppTopBar(),
                    const SizedBox(height: 20),
                    const _DiscoverHeader(),
                    const SizedBox(height: 14),
                    const _HeroSection(),
                    const SizedBox(height: 16),
                    const _FeatureSection(),
                    const SizedBox(height: 16),
                    const _SeriesSection(),
                    const SizedBox(height: 16),
                    const _TileRow(),
                    const SizedBox(height: 38),
                    Center(
                      child: Text(
                        'END OF ARCHIVE',
                        style: TextStyle(
                          color: colors.muted,
                          letterSpacing: 3.5,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class _DiscoverHeader extends StatelessWidget {
  const _DiscoverHeader();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CURATED FEED',
            style: TextStyle(
              color: colors.muted,
              letterSpacing: 2.8,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              'DISCOVER',
              style: TextStyle(
                color: colors.ink,
                fontSize: 58,
                height: 0.94,
                letterSpacing: -1.8,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 248,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF0B0D10), Color(0xFFB8BBC2), Color(0xFF2C2E33)],
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        center: const Alignment(0, 0.55),
                        radius: 0.9,
                        colors: [
                          Colors.white.withValues(alpha: 0.24),
                          Colors.black.withValues(alpha: 0.78),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: -22,
                  right: -22,
                  bottom: -2,
                  child: Transform.rotate(
                    angle: -0.05,
                    child: Container(height: 46, color: Colors.white.withValues(alpha: 0.72)),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CREATOR',
                        style: TextStyle(
                          color: colors.muted,
                          letterSpacing: 1.4,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'ELIAS VANCE',
                        style: TextStyle(
                          color: colors.ink,
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                          height: 0.95,
                          letterSpacing: -0.6,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '35MM - F/2.8 - 1/500',
                        style: TextStyle(
                          color: colors.muted,
                          letterSpacing: 1.4,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colors.ink,
                    side: BorderSide(color: colors.line),
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    minimumSize: const Size(118, 42),
                  ),
                  icon: const Icon(Icons.bookmark, size: 14),
                  label: const Text(
                    'COLLECT',
                    style: TextStyle(letterSpacing: 1.3, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureSection extends StatelessWidget {
  const _FeatureSection();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 210,
            color: const Color(0xFFCDCED0),
            child: Stack(
              children: [
                Positioned(left: 0, top: 16, child: Container(width: 130, height: 180, color: const Color(0xFFB9BABD))),
                Positioned(left: 118, top: 28, child: Container(width: 140, height: 166, color: const Color(0xFFADAFB3))),
                Positioned(left: 234, top: 12, child: Container(width: 128, height: 176, color: const Color(0xFFC7C9CC))),
                Positioned(
                  left: 86,
                  top: 68,
                  child: Container(
                    width: 62,
                    height: 74,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      border: Border.all(color: const Color(0xFF9D9FA4), width: 4),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'CREATOR\nSARA HOLM',
                        style: TextStyle(
                          color: colors.ink,
                          fontWeight: FontWeight.w700,
                          height: 1.18,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 32,
                      height: 32,
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          side: BorderSide(color: colors.line),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        ),
                        child: Icon(Icons.star, size: 13, color: colors.ink),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'STRUCTURAL\nSILENCE',
                  style: TextStyle(
                    color: colors.ink,
                    fontSize: 34,
                    height: 0.9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Exploring the intersection of brutalist architecture and the fleeting nature of morning light. Shot on location in Berlin.',
                  style: TextStyle(
                    color: colors.muted,
                    height: 1.4,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 12),
                Container(height: 1, width: 112, color: colors.line),
                const SizedBox(height: 7),
                Text(
                  'ISO 100 - 50MM - NO FILTER',
                  style: TextStyle(
                    color: colors.muted,
                    letterSpacing: 1.2,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SeriesSection extends StatelessWidget {
  const _SeriesSection();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 236,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF292A2E),
                  const Color(0xFF111216),
                  Colors.black.withValues(alpha: 0.9),
                ],
              ),
            ),
            child: Stack(
              children: [
                ...List.generate(
                  8,
                  (index) => Positioned(
                    left: 16 + (index * 28),
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 12,
                      color: Colors.white.withValues(alpha: 0.03 * (index.isEven ? 1 : 2)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
            child: Text(
              'FEATURED SERIES',
              style: TextStyle(
                color: colors.muted,
                letterSpacing: 1.7,
                fontSize: 10,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 0),
            child: Text(
              'THE FARTHEST\nREACH',
              style: TextStyle(
                color: colors.ink,
                fontSize: 43,
                height: 0.9,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.6,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
            child: Text(
              'BY MARCUS THORNE',
              style: TextStyle(
                color: colors.ink,
                letterSpacing: 1.6,
                fontSize: 12,
              ),
            ),
          ),
          Center(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: colors.ink,
                side: BorderSide(color: colors.line),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                minimumSize: const Size(134, 40),
              ),
              child: const Text(
                'VIEW ARCHIVE',
                style: TextStyle(letterSpacing: 1.3, fontSize: 11),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _TileRow extends StatelessWidget {
  const _TileRow();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 166,
            decoration: BoxDecoration(
              border: Border.all(color: colors.line),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF3A3C44), Color(0xFF0D0F14)],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: Text(
                    'A. LYRA JONES',
                    style: TextStyle(
                      color: colors.ink,
                      letterSpacing: 1.2,
                      fontSize: 9,
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Icon(Icons.star, size: 12, color: Colors.white.withValues(alpha: 0.82)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 166,
            decoration: BoxDecoration(
              border: Border.all(color: colors.line),
              color: colors.surface,
            ),
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'SAFE CINEWORKFLOW CURATION',
                      style: TextStyle(
                        color: colors.ink,
                        fontSize: 14,
                        height: 1.2,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 8,
                  bottom: 8,
                  child: Text(
                    'K. ARIUS',
                    style: TextStyle(
                      color: colors.ink,
                      letterSpacing: 1.2,
                      fontSize: 9,
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(width: 7, height: 7, color: colors.ink),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
