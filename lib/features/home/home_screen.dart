import 'package:flutter/material.dart';

import '../../core/models/film_project.dart';
import '../../core/models/preset_pack.dart';
import '../../core/widgets/app_section_header.dart';
import '../../core/widgets/film_action_button.dart';
import '../../core/widgets/soft_card.dart';
import '../editor/editor_screen.dart';
import 'widgets/curated_story_tile.dart';
import 'widgets/preset_strip.dart';
import 'widgets/quick_project_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _projects = [
    FilmProject(
      title: 'Tokyo Alley',
      palette: 'Neon wash with silver grain',
      capture: 'Captured 15 mins ago',
      recipe: 'A16 Soft Chrome',
      status: 'Draft',
    ),
    FilmProject(
      title: 'Sea Salt Morning',
      palette: 'Warm whites and lifted blacks',
      capture: 'Synced from camera roll',
      recipe: 'M5 Dawn Fade',
      status: 'Ready',
    ),
  ];

  static const _presets = [
    PresetPack(
      name: 'A16',
      description: 'Soft chrome, lifted blacks, cool skin tones',
      temperature: -8,
      grain: 38,
      intensity: 0.84,
    ),
    PresetPack(
      name: 'M5',
      description: 'Golden haze for daylight portraits',
      temperature: 10,
      grain: 22,
      intensity: 0.73,
    ),
    PresetPack(
      name: 'B2',
      description: 'Muted blues with matte contrast',
      temperature: -2,
      grain: 18,
      intensity: 0.62,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Text('Filmedme', style: theme.textTheme.titleMedium),
              const SizedBox(height: 12),
              Text(
                'Shape your photos like a film diary.',
                style: theme.textTheme.displaySmall,
              ),
              const SizedBox(height: 12),
              Text(
                'A calm editing workflow with curated presets, private studio drafts, and a gallery that stays focused on the image.',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: FilmActionButton(
                      label: 'Open editor',
                      icon: Icons.arrow_outward_rounded,
                      inverted: true,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const EditorScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: FilmActionButton(
                      label: 'New capture',
                      icon: Icons.camera_alt_outlined,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              const CuratedStoryTile(),
              const SizedBox(height: 32),
              const AppSectionHeader(
                title: 'Quick resume',
                subtitle: 'Jump back into active edits without hunting around.',
                actionLabel: 'Studio',
              ),
              const SizedBox(height: 16),
              ..._projects.map(
                (project) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: QuickProjectTile(project: project),
                ),
              ),
              const SizedBox(height: 18),
              const AppSectionHeader(
                title: 'Preset moodboard',
                subtitle:
                    'Start from a mood, then tune the details in the editor.',
                actionLabel: 'See all',
              ),
              const SizedBox(height: 16),
              PresetStrip(presets: _presets),
              const SizedBox(height: 24),
              const SoftCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Next on the roadmap'),
                    SizedBox(height: 8),
                    Text(
                      'Studio sync, editor controls, and reusable recipes are now framed into the app shell so we can connect real state and backend cleanly next.',
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
