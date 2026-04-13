import 'package:flutter/material.dart';

class StudioScreen extends StatelessWidget {
  const StudioScreen({super.key});

  static const _bg = Color(0xFF08090C);
  static const _surface = Color(0xFF111318);
  static const _line = Color(0xFF23262D);
  static const _ink = Color(0xFFF1F2F4);
  static const _muted = Color(0xFFA2A6AE);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _bg,
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const _TopBar(),
                const SizedBox(height: 22),
                const _HeaderBlock(),
                const SizedBox(height: 16),
                _Frame(
                  height: 344,
                  child: const _HeroAbstract(),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _Frame(height: 166, child: const _PortraitTile()),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _Frame(height: 166, child: const _MountainTile()),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _Frame(
                  height: 342,
                  child: const _RecentEditTile(),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _Frame(height: 168, child: const _RoadTile()),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: _Frame(height: 168, child: const _WaveTile()),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _Frame(height: 168, child: const _ForestTile()),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          _Frame(height: 168, child: const _MinimalTile()),
                          Positioned(
                            right: -2,
                            bottom: -2,
                            child: Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: _ink,
                                border: Border.all(color: _line),
                              ),
                              child: const Icon(
                                Icons.add,
                                color: _bg,
                                size: 34,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: StudioScreen._ink, size: 18),
            visualDensity: VisualDensity.compact,
          ),
          const Text(
            'FILMEDME',
            style: TextStyle(
              color: StudioScreen._ink,
              fontSize: 20,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings, color: StudioScreen._ink, size: 18),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}

class _HeaderBlock extends StatelessWidget {
  const _HeaderBlock();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'PRIVATE',
          style: TextStyle(
            color: StudioScreen._muted,
            letterSpacing: 2.6,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        const Text(
          'LIBRARY',
          style: TextStyle(
            color: StudioScreen._muted,
            letterSpacing: 2.6,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Text(
              'STUDIO',
              style: TextStyle(
                color: StudioScreen._ink,
                fontSize: 56,
                height: 0.92,
                letterSpacing: -1.6,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const _HeaderTab(label: 'All', selected: true),
                    _spacer(),
                    const _HeaderTab(label: 'Images'),
                    _spacer(),
                    const _HeaderTab(label: 'Collections'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _spacer() => const SizedBox(width: 26);
}

class _HeaderTab extends StatelessWidget {
  const _HeaderTab({required this.label, this.selected = false});

  final String label;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: selected ? StudioScreen._ink : StudioScreen._muted,
            letterSpacing: 0.5,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 4),
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          width: selected ? 22 : 0,
          height: 2,
          color: selected ? StudioScreen._ink : Colors.transparent,
        ),
      ],
    );
  }
}

class _Frame extends StatelessWidget {
  const _Frame({required this.height, required this.child});

  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: StudioScreen._surface,
        border: Border.all(color: StudioScreen._line),
      ),
      child: child,
    );
  }
}

class _HeroAbstract extends StatelessWidget {
  const _HeroAbstract();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-0.35, -0.2),
                radius: 1.1,
                colors: [
                  const Color(0xFF1D2027),
                  Colors.black.withValues(alpha: 0.96),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 24,
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.white.withValues(alpha: 0.0),
                  Colors.white.withValues(alpha: 0.82),
                  Colors.white.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 54,
          bottom: 20,
          child: Transform.rotate(
            angle: 0.18,
            child: Container(
              width: 96,
              height: 236,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.78),
                    Colors.white.withValues(alpha: 0.16),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 26,
          bottom: 20,
          child: Container(
            width: 68,
            height: 200,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: 0.72),
                  Colors.white.withValues(alpha: 0.2),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PortraitTile extends StatelessWidget {
  const _PortraitTile();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(-0.2, -0.3),
                radius: 1.15,
                colors: [
                  const Color(0xFF31353D),
                  Colors.black.withValues(alpha: 0.96),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 24,
          bottom: 0,
          child: Container(
            width: 96,
            height: 152,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: 0.36),
                  Colors.white.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MountainTile extends StatelessWidget {
  const _MountainTile();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF2A2D34), Color(0xFF090A0D)],
              ),
            ),
          ),
        ),
        ...List.generate(
          5,
          (index) => Positioned(
            left: 12 + (index * 20),
            right: 12 + (index * 8),
            bottom: 12 + (index * 18),
            child: Container(
              height: 26,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.07 + (index * 0.05)),
                borderRadius: BorderRadius.circular(80),
              ),
            ),
          ),
        ),
        Positioned(
          left: 84,
          bottom: 52,
          child: Container(
            width: 36,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: 0.75),
                  Colors.white.withValues(alpha: 0.14),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RecentEditTile extends StatelessWidget {
  const _RecentEditTile();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withValues(alpha: 0.13),
              Colors.white.withValues(alpha: 0.08),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(12),
              child: Icon(Icons.settings, size: 36, color: StudioScreen._ink),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 6),
              child: Text(
                'RECENT EDIT',
                style: TextStyle(
                  color: StudioScreen._muted,
                  letterSpacing: 2,
                  fontSize: 11,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(12, 0, 12, 14),
              child: Text(
                'NOIR_SERIES_01',
                style: TextStyle(
                  color: StudioScreen._ink,
                  fontWeight: FontWeight.w900,
                  fontSize: 36,
                  height: 0.95,
                  letterSpacing: -1.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoadTile extends StatelessWidget {
  const _RoadTile();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF494C53), Color(0xFF111216)],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 16,
          child: Container(height: 2, color: Colors.white.withValues(alpha: 0.6)),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 84,
          child: Container(height: 1, color: Colors.white.withValues(alpha: 0.28)),
        ),
      ],
    );
  }
}

class _WaveTile extends StatelessWidget {
  const _WaveTile();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF20232A), Color(0xFF08090C)],
              ),
            ),
          ),
        ),
        ...List.generate(
          7,
          (index) => Positioned(
            left: -30 + (index * 24),
            right: -20 + (index * 6),
            bottom: 26 + (index * 8),
            child: Container(
              height: 16,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: Colors.white.withValues(alpha: 0.05 + (index * 0.03)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ForestTile extends StatelessWidget {
  const _ForestTile();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF2A2D32), Color(0xFF0B0C10)],
              ),
            ),
          ),
        ),
        ...List.generate(
          9,
          (index) => Positioned(
            left: 10 + (index * 18),
            top: -10,
            bottom: 0,
            child: Container(
              width: 4,
              color: Colors.white.withValues(alpha: 0.09 + (index.isEven ? 0.04 : 0)),
            ),
          ),
        ),
      ],
    );
  }
}

class _MinimalTile extends StatelessWidget {
  const _MinimalTile();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFA1A3A8), Color(0xFF363940)],
        ),
      ),
    );
  }
}
