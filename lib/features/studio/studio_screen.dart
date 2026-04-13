import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/widgets/app_fab.dart';

class StudioScreen extends StatelessWidget {
  const StudioScreen({super.key});

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
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD166), // MVP yellow from mockup
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.diamond, color: Colors.black, size: 16),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.view_quilt_outlined, color: colors.ink),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.lens_outlined, color: colors.ink),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(AppColors colors) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'สตูดิโอ',
              style: TextStyle(
                color: colors.ink,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.ink),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Sort and filter',
                    style: TextStyle(
                      color: colors.ink,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(AppColors colors) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 2,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          // Mock data: first item loaded at index 3, rest are loading spinners to match screenshot.
          final isLoaded = index == 3;
          return _StudioGridItem(
            isLoaded: isLoaded,
            seed: isLoaded ? 'studio_$index' : null,
          );
        },
        childCount: 18,
      ),
    );
  }
}

class _StudioGridItem extends StatelessWidget {
  final bool isLoaded;
  final String? seed;

  const _StudioGridItem({required this.isLoaded, this.seed});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1F1F1F),
      child: isLoaded
          ? Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  'https://picsum.photos/seed/${seed.hashCode}/400/400',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.error, color: Colors.white24));
                  },
                ),
                // Gradient overlay at bottom
                Positioned(
                  left: 0,
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(4, 16, 4, 4),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.8),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.tune, color: Colors.white, size: 14),
                        SizedBox(width: 4),
                        Icon(Icons.save_alt, color: Colors.white, size: 14),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: CupertinoActivityIndicator(
                radius: 12,
              ),
            ),
    );
  }
}
