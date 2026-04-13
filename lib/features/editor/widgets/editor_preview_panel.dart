import 'package:flutter/material.dart';

import '../../../core/widgets/soft_card.dart';

class EditorPreviewPanel extends StatelessWidget {
  const EditorPreviewPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SoftCard(
      padding: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFE8CFB3),
                    Color(0xFFB28F75),
                    Color(0xFF342D28),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 18,
                    left: 18,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white.withValues(alpha: 0.15),
                      ),
                      child: const Text(
                        'M5 Dawn Fade',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 18,
                    bottom: 18,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black.withValues(alpha: 0.32),
                      ),
                      child: const Text(
                        'Before / After',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text('Harbor light portrait', style: theme.textTheme.titleLarge),
            const SizedBox(height: 6),
            Text(
              'Preview canvas for crop overlays, comparison gestures, and fine-tune controls.',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
