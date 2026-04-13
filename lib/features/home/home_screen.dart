import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.onLogout});

  final Future<void> Function()? onLogout;

  static const _bg = Color(0xFF08090C);
  static const _surface = Color(0xFF101216);
  static const _line = Color(0xFF23262D);
  static const _ink = Color(0xFFF3F3F5);
  static const _muted = Color(0xFFA0A4AD);

  Future<void> _openSettings(BuildContext context) async {
    if (onLogout == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Settings will be added next step')),
      );
      return;
    }

    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Log out'),
          content: const Text('Sign out from this device?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Log out'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      await onLogout?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: _bg),
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 36),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _TopBar(onSettingsTap: () => _openSettings(context)),
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
                const Center(
                  child: Text(
                    'END OF ARCHIVE',
                    style: TextStyle(
                      color: _muted,
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
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onSettingsTap});

  final VoidCallback onSettingsTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: HomeScreen._ink, size: 18),
            visualDensity: VisualDensity.compact,
          ),
          const Text(
            'FILMEDME',
            style: TextStyle(
              color: HomeScreen._ink,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: onSettingsTap,
            icon: const Icon(Icons.settings, color: HomeScreen._ink, size: 18),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}

class _DiscoverHeader extends StatelessWidget {
  const _DiscoverHeader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CURATED FEED',
            style: TextStyle(
              color: HomeScreen._muted,
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
                color: HomeScreen._ink,
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
    return Container(
      decoration: BoxDecoration(
        color: HomeScreen._surface,
        border: Border.all(color: HomeScreen._line),
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
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CREATOR',
                        style: TextStyle(
                          color: HomeScreen._muted,
                          letterSpacing: 1.4,
                          fontSize: 10,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'ELIAS VANCE',
                        style: TextStyle(
                          color: HomeScreen._ink,
                          fontWeight: FontWeight.w800,
                          fontSize: 30,
                          height: 0.95,
                          letterSpacing: -0.6,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '35MM - F/2.8 - 1/500',
                        style: TextStyle(
                          color: HomeScreen._muted,
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
                    foregroundColor: HomeScreen._ink,
                    side: const BorderSide(color: HomeScreen._line),
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
    return Container(
      decoration: BoxDecoration(
        color: HomeScreen._surface,
        border: Border.all(color: HomeScreen._line),
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
                    const Expanded(
                      child: Text(
                        'CREATOR\nSARA HOLM',
                        style: TextStyle(
                          color: HomeScreen._ink,
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
                          side: const BorderSide(color: HomeScreen._line),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                        ),
                        child: const Icon(Icons.star, size: 13, color: HomeScreen._ink),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'STRUCTURAL\nSILENCE',
                  style: TextStyle(
                    color: HomeScreen._ink,
                    fontSize: 34,
                    height: 0.9,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Exploring the intersection of brutalist architecture and the fleeting nature of morning light. Shot on location in Berlin.',
                  style: TextStyle(
                    color: HomeScreen._muted,
                    height: 1.4,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 12),
                Container(height: 1, width: 112, color: HomeScreen._line),
                const SizedBox(height: 7),
                const Text(
                  'ISO 100 - 50MM - NO FILTER',
                  style: TextStyle(
                    color: HomeScreen._muted,
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
    return Container(
      decoration: BoxDecoration(
        color: HomeScreen._surface,
        border: Border.all(color: HomeScreen._line),
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
          const Padding(
            padding: EdgeInsets.fromLTRB(12, 10, 12, 0),
            child: Text(
              'FEATURED SERIES',
              style: TextStyle(
                color: HomeScreen._muted,
                letterSpacing: 1.7,
                fontSize: 10,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(12, 4, 12, 0),
            child: Text(
              'THE FARTHEST\nREACH',
              style: TextStyle(
                color: HomeScreen._ink,
                fontSize: 43,
                height: 0.9,
                fontWeight: FontWeight.w900,
                letterSpacing: -1.6,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(12, 4, 12, 12),
            child: Text(
              'BY MARCUS THORNE',
              style: TextStyle(
                color: HomeScreen._ink,
                letterSpacing: 1.6,
                fontSize: 12,
              ),
            ),
          ),
          Center(
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: HomeScreen._ink,
                side: const BorderSide(color: HomeScreen._line),
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
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 166,
            decoration: BoxDecoration(
              border: Border.all(color: HomeScreen._line),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF3A3C44), Color(0xFF0D0F14)],
              ),
            ),
            child: Stack(
              children: [
                const Positioned(
                  left: 8,
                  bottom: 8,
                  child: Text(
                    'A. LYRA JONES',
                    style: TextStyle(
                      color: HomeScreen._ink,
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
              border: Border.all(color: HomeScreen._line),
              color: const Color(0xFF1A1C23),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'SAFE CINEWORKFLOW CURATION',
                      style: TextStyle(
                        color: HomeScreen._ink,
                        fontSize: 14,
                        height: 1.2,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  left: 8,
                  bottom: 8,
                  child: Text(
                    'K. ARIUS',
                    style: TextStyle(
                      color: HomeScreen._ink,
                      letterSpacing: 1.2,
                      fontSize: 9,
                    ),
                  ),
                ),
                Positioned(
                  right: 8,
                  bottom: 8,
                  child: Container(width: 7, height: 7, color: HomeScreen._ink),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
