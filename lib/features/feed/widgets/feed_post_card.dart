import 'package:flutter/material.dart';

import '../../../app/theme.dart';

class FeedPostCard extends StatelessWidget {
  const FeedPostCard({
    super.key,
    required this.imageUrl,
    required this.username,
    required this.avatarUrl,
    this.badgeText,
    this.commentInfo,
  });

  final String imageUrl;
  final String username;
  final String avatarUrl;
  final String? badgeText;
  final String? commentInfo;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Post Image
        AspectRatio(
          aspectRatio: 4 / 5,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: colors.surface,
              alignment: Alignment.center,
              child: Icon(Icons.broken_image, color: colors.muted),
            ),
          ),
        ),
        
        // Footer actions and avatar
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar with Add Badge
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(avatarUrl),
                      ),
                      Positioned(
                        right: -2,
                        bottom: -2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: colors.bg,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add_circle,
                            color: colors.ink,
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  
                  // Username info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: TextStyle(
                            color: colors.ink,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        if (badgeText?.isNotEmpty == true)
                          Row(
                            children: [
                              Icon(Icons.sync_alt, color: colors.muted, size: 12),
                              const SizedBox(width: 4),
                              Text(
                                badgeText!,
                                style: TextStyle(
                                  color: colors.muted,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),

                  // Actions
                  Icon(Icons.star_border, color: colors.ink, size: 24),
                  const SizedBox(width: 16),
                  Icon(Icons.sync, color: colors.ink, size: 24),
                  const SizedBox(width: 16),
                  Icon(Icons.chat_bubble_outline_rounded, color: colors.ink, size: 24),
                  const SizedBox(width: 8),

                  // Custom Badge
                  if (commentInfo != null)
                     Container(
                       margin: const EdgeInsets.only(left: 8),
                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                       decoration: BoxDecoration(
                         color: const Color(0xFFE45D40), // Reddish orange badge
                         borderRadius: BorderRadius.circular(12),
                       ),
                       child: Text(
                         'B5',
                         style: TextStyle(
                           color: colors.bg,
                           fontSize: 10,
                           fontWeight: FontWeight.w700,
                         ),
                       ),
                     ),
                ],
              ),
              
              // Comment Snippet
              if (commentInfo != null) ...[
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 44),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: colors.line,
                          width: 2,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.only(left: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ดูการสนทนา (1)',
                          style: TextStyle(
                            color: colors.muted,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 13, color: colors.ink),
                            children: [
                              const TextSpan(
                                text: 'thegodshoed  ',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              TextSpan(
                                text: commentInfo,
                                style: const TextStyle(fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
