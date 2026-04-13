import 'package:flutter/material.dart';

import '../../../app/theme.dart';

class RecommendedSection extends StatefulWidget {
  const RecommendedSection({super.key, required this.onClose});

  final VoidCallback onClose;

  @override
  State<RecommendedSection> createState() => _RecommendedSectionState();
}

class _RecommendedSectionState extends State<RecommendedSection> {
  // Dummy data for recommended accounts
  final _recommendations = [
    {
      'username': 'emmlynpure',
      'label': 'emma',
      'avatar': 'https://i.pravatar.cc/150?u=1',
      'image1': 'https://picsum.photos/200/300?random=1',
      'image2': 'https://picsum.photos/200/300?random=2',
      'image3': 'https://picsum.photos/200/300?random=3',
    },
    {
      'username': 'nature_daily',
      'label': 'nature',
      'avatar': 'https://i.pravatar.cc/150?u=2',
      'image1': 'https://picsum.photos/200/300?random=4',
      'image2': 'https://picsum.photos/200/300?random=5',
      'image3': 'https://picsum.photos/200/300?random=6',
    },
    {
      'username': 'urban_streets',
      'label': 'city',
      'avatar': 'https://i.pravatar.cc/150?u=3',
      'image1': 'https://picsum.photos/200/300?random=7',
      'image2': 'https://picsum.photos/200/300?random=8',
      'image3': 'https://picsum.photos/200/300?random=9',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: colors.line, height: 1),
        const SizedBox(height: 16),
        
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ที่แนะนำ',
                style: TextStyle(
                  color: colors.ink,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: widget.onClose,
                icon: Icon(Icons.close, color: colors.ink, size: 20),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Horizontal Scroll
        SizedBox(
          height: 220,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            itemCount: _recommendations.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final data = _recommendations[index];
              return _RecommendedCard(
                username: data['username']!,
                label: data['label']!,
                avatarUrl: data['avatar']!,
                imageUrls: [data['image1']!, data['image2']!, data['image3']!],
              );
            },
          ),
        ),
        
        const SizedBox(height: 24),
        Divider(color: colors.line, height: 1),
      ],
    );
  }
}

class _RecommendedCard extends StatelessWidget {
  const _RecommendedCard({
    required this.username,
    required this.label,
    required this.avatarUrl,
    required this.imageUrls,
  });

  final String username;
  final String label;
  final String avatarUrl;
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    
    return Container(
      width: 260,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: colors.line),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Collage
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: Image.network(imageUrls[0], fit: BoxFit.cover),
                ),
                const SizedBox(width: 2),
                Expanded(
                  flex: 1,
                  child: Image.network(imageUrls[1], fit: BoxFit.cover),
                ),
                const SizedBox(width: 2),
                Expanded(
                  flex: 1,
                  child: Image.network(imageUrls[2], fit: BoxFit.cover),
                ),
              ],
            ),
          ),
          
          // Footer
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(avatarUrl),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        username,
                        style: TextStyle(
                          color: colors.ink,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        label,
                        style: TextStyle(
                          color: colors.muted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colors.ink,
                    foregroundColor: colors.bg,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    minimumSize: const Size(60, 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    'ติดตาม',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
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
