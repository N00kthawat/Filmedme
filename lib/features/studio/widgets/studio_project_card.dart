import 'package:flutter/material.dart';

import '../../../core/models/film_project.dart';
import '../../../core/widgets/soft_card.dart';

class StudioProjectCard extends StatelessWidget {
  const StudioProjectCard({super.key, required this.project});

  final FilmProject project;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE8CFB3),
                  Color(0xFF967255),
                  Color(0xFF181512),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(project.title, style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(project.palette, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _StudioBadge(label: project.recipe),
              _StudioBadge(label: project.status),
              _StudioBadge(label: project.capture),
            ],
          ),
        ],
      ),
    );
  }
}

class _StudioBadge extends StatelessWidget {
  const _StudioBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: Colors.white,
        border: Border.all(color: Theme.of(context).colorScheme.outline),
      ),
      child: Text(label),
    );
  }
}
