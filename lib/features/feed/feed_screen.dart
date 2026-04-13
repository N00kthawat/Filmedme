import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/widgets/app_fab.dart';
import '../../core/widgets/app_top_bar.dart';
import 'widgets/feed_post_card.dart';
import 'widgets/recommended_section.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  bool _showRecommended = true;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    
    return DefaultTabController(
      length: 2,
      child: ColoredBox(
        color: colors.bg,
        child: SafeArea(
          child: Stack(
            children: [
              NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: colors.bg,
                  pinned: true,
                  floating: true,
                  toolbarHeight: 120, // Enough for Menu + Title
                  titleSpacing: 0,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppTopBar(),
                        const SizedBox(height: 12),
                        Text(
                          'ฟีด',
                          style: TextStyle(
                            color: colors.ink,
                            fontSize: 32,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(48),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        isScrollable: true,
                        dividerColor: Colors.transparent,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: colors.ink,
                        indicatorWeight: 2,
                        labelColor: colors.ink,
                        unselectedLabelColor: colors.muted,
                        labelStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                        ),
                        indicatorPadding: const EdgeInsets.symmetric(horizontal: 16),
                        labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                        tabAlignment: TabAlignment.start,
                        tabs: const [
                          Tab(text: 'สำหรับคุณ'),
                          Tab(text: 'ผู้ที่คุณติดตาม'),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                _buildFeedList(),
                _buildFeedList(), // Duplicate for demo purposes
              ],
            ),
          ),
          Positioned(
                bottom: 16,
                right: 8,
                child: const AppFab(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeedList() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 100),
      itemCount: 5,
      itemBuilder: (context, index) {
        if (index == 1 && _showRecommended) {
          return Column(
            children: [
              FeedPostCard(
                imageUrl: 'https://picsum.photos/800/1000?random=$index',
                username: 'franzoniso',
                avatarUrl: 'https://i.pravatar.cc/150?u=author$index',
                badgeText: 'vsco',
              ),
              RecommendedSection(
                onClose: () => setState(() => _showRecommended = false),
              ),
            ],
          );
        }
        
        return FeedPostCard(
          imageUrl: 'https://picsum.photos/800/1000?random=$index',
          username: index % 2 == 0 ? 'vikkiwiki' : 'franzoniso',
          avatarUrl: 'https://i.pravatar.cc/150?u=author$index',
          badgeText: index % 2 == 0 ? 'vsco' : null,
          commentInfo: index == 2 ? 'Beautiful' : null,
        );
      },
    );
  }
}
