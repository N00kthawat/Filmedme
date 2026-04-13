import 'package:flutter/material.dart';
import '../../app/theme.dart';
import '../../core/widgets/app_top_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return ColoredBox(
      color: colors.bg,
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 42),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const AppTopBar(),
                  const SizedBox(height: 14),
                  const _ProfileHero(),
                  const SizedBox(height: 22),
                  const _SectionTitle(
                    title: 'SELECTED WORKS',
                    trailing: '2024 Edition',
                  ),
                  const SizedBox(height: 8),
                  const _HeroWorkCard(),
                  const SizedBox(height: 8),
                  const _WorksMosaic(),
                  const SizedBox(height: 18),
                  const _MetricsPanel(),
                  const SizedBox(height: 12),
                  const _QuotePanel(),
                  const SizedBox(height: 20),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: const Color(0xFF2F3239),
                border: Border.all(color: colors.line),
              ),
              child: Icon(Icons.person, color: colors.ink, size: 44),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ELIAS VANCE',
                    style: TextStyle(
                      color: colors.ink,
                      fontSize: 37,
                      height: 0.9,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.1,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'ARCHIVIST OF THE EUROPEAN EDITORIAL',
                    style: TextStyle(
                      color: colors.muted,
                      letterSpacing: 1.3,
                      fontSize: 8.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'FRAMES. CINEMATOGRAPHIC. STILL',
                    style: TextStyle(
                      color: colors.muted,
                      letterSpacing: 1.3,
                      fontSize: 8.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'COLLECTIONS SINCE 2017, BERLIN',
                    style: TextStyle(
                      color: colors.muted,
                      letterSpacing: 1.3,
                      fontSize: 8.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            _StatBlock(value: '42', label: 'Editions'),
            SizedBox(width: 16),
            _StatBlock(value: '12K', label: 'Followers'),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.ink,
                    foregroundColor: colors.bg,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: const Text(
                    'BUY PROFILE',
                    style: TextStyle(
                      letterSpacing: 1.2,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 44,
              height: 44,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: colors.ink,
                  side: BorderSide(color: colors.line),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {},
                child: const Icon(Icons.share, size: 18),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatBlock extends StatelessWidget {
  const _StatBlock({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Row(
      children: [
        Text(
          value,
          style: TextStyle(
            color: colors.ink,
            fontSize: 26,
            height: 0.95,
            letterSpacing: -0.4,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(width: 5),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            label.toUpperCase(),
            style: TextStyle(
              color: colors.muted,
              letterSpacing: 1.2,
              fontSize: 8.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.trailing});

  final String title;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: colors.muted,
            letterSpacing: 2.2,
            fontSize: 10,
          ),
        ),
        const Spacer(),
        Text(
          trailing,
          style: TextStyle(
            color: colors.muted,
            letterSpacing: 1.4,
            fontSize: 8.5,
          ),
        ),
      ],
    );
  }
}

class _HeroWorkCard extends StatelessWidget {
  const _HeroWorkCard();

  @override
  Widget build(BuildContext context) {
    return _Frame(
      height: 232,
      child: Stack(
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFAEB1B8), Color(0xFF272B33)],
                ),
              ),
            ),
          ),
          ...List.generate(
            6,
            (index) => Positioned(
              left: 10 + (index * 28),
              right: 10 + (index * 10),
              bottom: 8 + (index * 20),
              child: Container(
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white.withValues(alpha: 0.08 + (index * 0.04)),
                ),
              ),
            ),
          ),
          Positioned(
            left: 8,
            bottom: 8,
            child: Text(
              'ISO 100  ·  1/500',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.78),
                fontSize: 8.5,
                letterSpacing: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WorksMosaic extends StatelessWidget {
  const _WorksMosaic();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: _Frame(height: 168, child: _ArchitectureTile())),
            SizedBox(width: 8),
            Expanded(child: _Frame(height: 168, child: _PierTile())),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _Frame(height: 138, child: _TextureTile())),
            SizedBox(width: 8),
            Expanded(child: _Frame(height: 138, child: _PillarTile())),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _Frame(height: 170, child: _HallwayTile())),
            SizedBox(width: 8),
            Expanded(child: _Frame(height: 170, child: _SphereTile())),
          ],
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
    final colors = Theme.of(context).extension<AppColors>()!;
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.line),
      ),
      child: child,
    );
  }
}

class _ArchitectureTile extends StatelessWidget {
  const _ArchitectureTile();

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
                colors: [Color(0xFF34383F), Color(0xFF0D0F13)],
              ),
            ),
          ),
        ),
        ...List.generate(
          6,
          (index) => Positioned(
            left: -20 + (index * 30),
            top: 18 + (index * 20),
            child: Transform.rotate(
              angle: 0.24,
              child: Container(
                width: 60,
                height: 14,
                color: Colors.white.withValues(alpha: 0.12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PierTile extends StatelessWidget {
  const _PierTile();

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
                colors: [Color(0xFF8A8D94), Color(0xFF1A1D23)],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 24,
          child: Container(
            height: 2,
            color: Colors.white.withValues(alpha: 0.72),
          ),
        ),
      ],
    );
  }
}

class _TextureTile extends StatelessWidget {
  const _TextureTile();

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
                colors: [Color(0xFF50545C), Color(0xFF111318)],
              ),
            ),
          ),
        ),
        ...List.generate(
          7,
          (index) => Positioned(
            left: -10,
            right: -20,
            bottom: 8 + (index * 14),
            child: Container(
              height: 9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white.withValues(alpha: 0.05 + (index * 0.02)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _PillarTile extends StatelessWidget {
  const _PillarTile();

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
                colors: [Color(0xFF777A82), Color(0xFF1D2027)],
              ),
            ),
          ),
        ),
        ...List.generate(
          5,
          (index) => Positioned(
            left: 14 + (index * 22),
            top: -4,
            bottom: 0,
            child: Container(
              width: 6,
              color: Colors.white.withValues(alpha: 0.12 + (index.isOdd ? 0.08 : 0)),
            ),
          ),
        ),
      ],
    );
  }
}

class _HallwayTile extends StatelessWidget {
  const _HallwayTile();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Stack(
      children: [
        const Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF3A3E45), Color(0xFF090A0D)],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 20,
          child: Container(height: 2, color: Colors.white.withValues(alpha: 0.65)),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 20,
          child: Container(height: 2, color: Colors.white.withValues(alpha: 0.24)),
        ),
        Center(
          child: Icon(Icons.person, color: colors.ink, size: 24),
        ),
      ],
    );
  }
}

class _SphereTile extends StatelessWidget {
  const _SphereTile();

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
                colors: [Color(0xFF767A81), Color(0xFF20242C)],
              ),
            ),
          ),
        ),
        ...List.generate(
          9,
          (index) => Positioned(
            left: 0,
            right: 0,
            top: 16 + (index * 14),
            child: Container(
              height: 1,
              color: Colors.white.withValues(alpha: 0.06 + (index * 0.02)),
            ),
          ),
        ),
        Center(
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.78),
                  Colors.white.withValues(alpha: 0.12),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MetricsPanel extends StatelessWidget {
  const _MetricsPanel();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _MetricRow(label: 'MEASURES', value: '190'),
        SizedBox(height: 8),
        _MetricRow(label: 'RAW ISO', value: '100'),
        SizedBox(height: 8),
        _MetricRow(label: 'FOV RANGE', value: '35mm f/1.4'),
        SizedBox(height: 8),
        _MetricRow(label: 'EDITS', value: '169'),
      ],
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: colors.muted,
            letterSpacing: 1.5,
            fontSize: 9,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: colors.ink,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _QuotePanel extends StatelessWidget {
  const _QuotePanel();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'FAVORITE CINE QUOTE',
            style: TextStyle(
              color: colors.muted,
              letterSpacing: 1.6,
              fontSize: 9,
            ),
          ),
          const SizedBox(height: 8),
          const Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              _Tag(text: 'NEUTRAL'),
              _Tag(text: 'NOIR'),
              _Tag(text: 'ARCHITECTURE'),
              _Tag(text: 'SILENCE-PACE'),
              _Tag(text: 'MONOCHROME'),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '"The camera is an instrument that teaches people how to see without a camera."',
            style: TextStyle(
              color: colors.ink,
              fontStyle: FontStyle.italic,
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(color: colors.line),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: colors.muted,
          letterSpacing: 1.1,
          fontSize: 8.5,
        ),
      ),
    );
  }
}
