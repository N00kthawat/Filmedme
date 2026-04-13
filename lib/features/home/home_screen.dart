import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/widgets/app_fab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return ColoredBox(
      color: colors.bg,
      child: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: colors.bg,
                  pinned: true,
                  floating: true,
                  titleSpacing: 0,
                  title: Row(
                    children: [
                      IconButton(
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        icon: Icon(Icons.menu, color: colors.ink),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'ค้นพบ',
                            style: TextStyle(
                              color: colors.ink,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search, color: colors.ink),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    const SizedBox(height: 16),
                    const _FavoritesPromo(),
                    const SizedBox(height: 32),
                    const _HashtagMosaic(
                      title: '#PhotographersInFrame',
                      count: '209',
                    ),
                    const SizedBox(height: 32),
                    const _HashtagMosaic(
                      title: '#MyVision',
                      count: '1,033',
                      variant: MosaicVariant.threeGrid,
                    ),
                    const SizedBox(height: 48),
                    const _CuratedList(
                      title: 'เลือกสรร',
                      subtitle: 'คัดสรรโดย VSCO',
                      layoutStrategy: ListLayoutStrategy.portrait,
                    ),
                    const SizedBox(height: 32),
                    const _CuratedList(
                      title: 'บทบรรณาธิการ',
                      subtitle: 'ไฮไลต์ที่ VSCO และชุมชนผู้ใช้งาน',
                      layoutStrategy: ListLayoutStrategy.landscapeWithText,
                    ),
                    const SizedBox(height: 32),
                    const _CuratedList(
                      title: 'แสงอาทิตย์และร่มเงา',
                      subtitle: 'แสงและเงาที่ต่างกัน',
                      layoutStrategy: ListLayoutStrategy.square,
                    ),
                    const SizedBox(height: 32),
                    const _CuratedList(
                      title: 'ความปรารถนาที่จะเดินทาง',
                      subtitle: 'สำหรับนักผจญภัย',
                      layoutStrategy: ListLayoutStrategy.square,
                    ),
                    const SizedBox(height: 120), // Padding for bottom
                  ]),
                ),
              ],
            ),
            Positioned(
              bottom: 16,
              right: 8,
              child: const AppFab(),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoritesPromo extends StatefulWidget {
  const _FavoritesPromo();

  @override
  State<_FavoritesPromo> createState() => _FavoritesPromoState();
}

class _FavoritesPromoState extends State<_FavoritesPromo> {
  bool _isVisible = true;

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) return const SizedBox.shrink();
    final colors = Theme.of(context).extension<AppColors>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: colors.ink, width: 1.5),
                ),
                child: Icon(Icons.star_border, color: colors.ink),
              ),
              IconButton(
                onPressed: () => setState(() => _isVisible = false),
                icon: Icon(Icons.close, color: colors.muted, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'รูปภาพโปรดที่สร้างแรงบันดาลใจ',
            style: TextStyle(
              color: colors.ink,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'กดรูปภาพค้างไว้แล้วแตะที่ไอคอนรูปดาว ฟังก์ชั่นรูปภาพ\nโปรดจะช่วยปรับแต่งสิ่งที่คุณเห็นตรงนี้',
            style: TextStyle(
              color: colors.ink,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            height: 1,
            color: colors.line,
          ),
        ],
      ),
    );
  }
}

enum MosaicVariant { overlapping, threeGrid }

class _HashtagMosaic extends StatelessWidget {
  final String title;
  final String count;
  final MosaicVariant variant;

  const _HashtagMosaic({
    required this.title,
    required this.count,
    this.variant = MosaicVariant.overlapping,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 280,
          child: variant == MosaicVariant.overlapping
              ? _buildOverlappingMosaic()
              : _buildThreeGridMosaic(),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: colors.ink,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '$count โพสต์',
                style: TextStyle(
                  color: colors.muted,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOverlappingMosaic() {
    return Stack(
      children: [
        Positioned(
          left: 16,
          bottom: 24,
          top: 0,
          width: 140,
          child: _NetworkImageMock(seed: '${title}_1'),
        ),
        Positioned(
          left: 170,
          top: 40,
          width: 110,
          height: 90,
          child: _NetworkImageMock(seed: '${title}_2'),
        ),
        Positioned(
          left: 160,
          bottom: 12,
          width: 130,
          height: 120,
          child: _NetworkImageMock(seed: '${title}_3'),
        ),
        Positioned(
          right: -20,
          top: 80,
          width: 140,
          height: 180,
          child: _NetworkImageMock(seed: '${title}_4'),
        ),
      ],
    );
  }

  Widget _buildThreeGridMosaic() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 180,
              child: _NetworkImageMock(seed: '${title}_a'),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 180,
              child: _NetworkImageMock(seed: '${title}_b'),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            flex: 3,
            child: SizedBox(
              height: 240,
              child: _NetworkImageMock(seed: '${title}_c'),
            ),
          ),
        ],
      ),
    );
  }
}

enum ListLayoutStrategy { portrait, landscapeWithText, square }

class _CuratedList extends StatelessWidget {
  final String title;
  final String subtitle;
  final ListLayoutStrategy layoutStrategy;

  const _CuratedList({
    required this.title,
    required this.subtitle,
    required this.layoutStrategy,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: TextStyle(
              color: colors.ink,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 2),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            subtitle,
            style: TextStyle(
              color: colors.muted,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: layoutStrategy == ListLayoutStrategy.landscapeWithText
              ? 300
              : 320,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return _buildItem(context, colors, index);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, AppColors colors, int index) {
    double width, height;
    if (layoutStrategy == ListLayoutStrategy.landscapeWithText) {
      width = 300;
      height = 180;
    } else if (layoutStrategy == ListLayoutStrategy.portrait) {
      width = 200;
      height = 250;
    } else {
      width = 210;
      height = 210;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              Positioned.fill(
                child: _NetworkImageMock(seed: '${title}_$index'),
              ),
              if (layoutStrategy == ListLayoutStrategy.landscapeWithText)
                Positioned(
                  right: 12,
                  bottom: 12,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    color: Colors.black.withValues(alpha: 0.5),
                    child: const Icon(Icons.layers, color: Colors.white, size: 20),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (layoutStrategy == ListLayoutStrategy.landscapeWithText) ...[
          SizedBox(
            width: width,
            child: Text(
              'What 401 Photographers Actually Thin...',
              style: TextStyle(
                color: colors.ink,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: width,
            child: Text(
              'A data-backed look at how the photo communit...',
              style: TextStyle(
                color: colors.muted,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 12),
        ],
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors.line,
              ),
              child: Icon(Icons.person, size: 14, color: colors.ink),
            ),
            const SizedBox(width: 8),
            Text(
              layoutStrategy == ListLayoutStrategy.landscapeWithText ? 'VSCO' : 'user_$index',
              style: TextStyle(
                color: colors.ink,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _NetworkImageMock extends StatelessWidget {
  final String seed;

  const _NetworkImageMock({required this.seed});

  @override
  Widget build(BuildContext context) {
    // We use a simple network image with robust error handling for placeholders.
    // picsum.photos provides consistent random images based on a seed.
    return Image.network(
      'https://picsum.photos/seed/${seed.hashCode}/400/600',
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: const Color(0xFF333333),
          child: const Center(
            child: Icon(Icons.camera_alt, color: Colors.white24),
          ),
        );
      },
    );
  }
}
