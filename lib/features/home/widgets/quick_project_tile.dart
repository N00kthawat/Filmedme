import 'package:flutter/material.dart';

import '../../../core/models/film_project.dart';
import '../../../core/widgets/soft_card.dart';

class QuickProjectTile extends StatelessWidget {
  const QuickProjectTile({super.key, required this.project});

  final FilmProject project;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SoftCard(
      child: Row(
        children: [
          Container(
            width: 88,
            height: 104,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE8CBAE),
                  Color(0xFF9E8267),
                  Color(0xFF2A2622),
                ],
              ),
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project.title, style: theme.textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(project.palette, style: theme.textTheme.bodyLarge),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _MetaChip(label: project.recipe),
                    _MetaChip(label: project.status),
                  ],
                ),
                const SizedBox(height: 12),
                Text(project.capture, style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Text(label),
    );
  }
}
