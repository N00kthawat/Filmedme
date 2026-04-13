import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/widgets/app_fab.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                _buildAppBar(context, colors),
                _buildHeader(colors),
                _buildGalleryTabs(colors),
                _buildCategoryTabs(colors),
                _buildGrid(colors),
                // Padding at bottom for FAB
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
            Positioned(
              bottom: 16,
              right: 16,
              child: const AppFab(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, AppColors colors) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: colors.bg,
      pinned: true,
      elevation: 0,
      titleSpacing: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(Icons.menu, color: colors.ink),
          ),
          Text(
            'nt-rubyn',
            style: TextStyle(
              color: colors.ink,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_horiz, color: colors.ink),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(AppColors colors) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: NetworkImage('https://picsum.photos/seed/ntrubyn/200/200'),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(color: colors.bg, width: 1),
                  ),
                ),
                const SizedBox(width: 24),
                Text(
                  'N',
                  style: TextStyle(
                    color: colors.ink,
                    fontSize: 48,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              '🕯️ : Freedom of thought intellectual solitude. 🕊️',
              style: TextStyle(
                color: colors.ink,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGalleryTabs(AppColors colors) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: colors.ink,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    'MY GALLERIES',
                    style: TextStyle(
                      color: colors.bg,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.ink.withValues(alpha: 0.3)),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Text(
                    'จัดการเว็บไซต์',
                    style: TextStyle(
                      color: colors.ink,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Subtle divider line with active bold underline for MY GALLERIES
          Stack(
            children: [
              Divider(
                color: colors.line,
                thickness: 1,
                height: 1,
              ),
              Positioned(
                left: 16,
                top: 0,
                child: Container(
                  width: 146, // Approx width to underline MY GALLERIES properly
                  height: 2,
                  color: colors.ink,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(AppColors colors) {
    final categories = ['ล่าสุด', 'ALBUMS', 'SPACES', 'รีโพสต์'];
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 24),
        child: Row(
          children: categories.map((cat) {
            final isSelected = cat == 'ล่าสุด';
            return Padding(
              padding: const EdgeInsets.only(right: 24),
              child: Text(
                cat,
                style: TextStyle(
                  color: isSelected ? colors.ink : colors.muted,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildGrid(AppColors colors) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.8, // Taller rectangular tiles as per mockup
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return _ProfileGridItem(index: index);
          },
          childCount: 8,
        ),
      ),
    );
  }
}

class _ProfileGridItem extends StatelessWidget {
  final int index;
  const _ProfileGridItem({required this.index});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Container(
      color: const Color(0xFF1F1F1F),
      child: Image.network(
        'https://picsum.photos/seed/profile_$index/400/500',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Center(child: Icon(Icons.error, color: colors.muted));
        },
      ),
    );
  }
}
