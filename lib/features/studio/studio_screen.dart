import 'package:flutter/material.dart';

import '../../core/models/film_project.dart';
import '../../core/widgets/app_section_header.dart';
import '../../core/widgets/soft_card.dart';
import 'widgets/studio_project_card.dart';
import 'widgets/studio_stat_tile.dart';

class StudioScreen extends StatelessWidget {
  const StudioScreen({super.key});

  static const _projects = [
    FilmProject(
      title: 'Harbor light portrait',
      palette: 'Warm skin, soft highlight roll-off',
      capture: 'Updated 4 minutes ago',
      recipe: 'M5 Dawn Fade',
      status: 'Active',
    ),
    FilmProject(
      title: 'Concrete poetry',
      palette: 'Muted tungsten with punchy grain',
      capture: 'Updated yesterday',
      recipe: 'A16 Soft Chrome',
      status: 'Queued',
    ),
    FilmProject(
      title: 'Hotel hallway study',
      palette: 'Matte blacks with pale beige glow',
      capture: 'Imported this week',
      recipe: 'S9 Quiet Dust',
      status: 'Draft',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      children: [
        Text('Studio', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'Private drafts, edit sessions, and export-ready projects stay here before anything gets published.',
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        const Row(
          children: [
            Expanded(
              child: StudioStatTile(
                label: 'Drafts',
                value: '12',
                caption: 'Private projects',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: StudioStatTile(
                label: 'Recipes',
                value: '08',
                caption: 'Saved looks',
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: StudioStatTile(
                label: 'Exports',
                value: '24',
                caption: 'This month',
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        const SoftCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Why this structure works'),
              SizedBox(height: 8),
              Text(
                'Studio is separate from discover and presets so we can add local drafts, sync status, folders, and backend metadata later without tangling the UI tree.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        const AppSectionHeader(
          title: 'Recent projects',
          subtitle:
              'Each card is ready to become a reusable component for project lists, search results, and profile drafts.',
        ),
        const SizedBox(height: 16),
        ..._projects.map(
          (project) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: StudioProjectCard(project: project),
          ),
        ),
      ],
    );
  }
}
