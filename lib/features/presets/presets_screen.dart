import 'package:flutter/material.dart';

import '../../core/models/preset_pack.dart';
import '../../core/widgets/app_section_header.dart';
import '../../core/widgets/soft_card.dart';
import 'widgets/preset_library_tile.dart';

class PresetsScreen extends StatelessWidget {
  const PresetsScreen({super.key});

  static const _packs = [
    PresetPack(
      name: 'A16',
      description: 'Cool chrome with gentle contrast for urban night scenes.',
      temperature: -8,
      grain: 38,
      intensity: 0.84,
    ),
    PresetPack(
      name: 'M5',
      description: 'Sun-faded warmth for skin tones and quiet interiors.',
      temperature: 10,
      grain: 22,
      intensity: 0.73,
    ),
    PresetPack(
      name: 'S9',
      description: 'Dusty highlights and low saturation for editorial stills.',
      temperature: 5,
      grain: 31,
      intensity: 0.78,
    ),
    PresetPack(
      name: 'B2',
      description: 'Muted cobalt shadows with matte black response.',
      temperature: -2,
      grain: 18,
      intensity: 0.62,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      children: [
        Text('Recipe library', style: theme.textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          'A front-end shell for default packs, saved recipes, and future membership bundles.',
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        const SoftCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('System layout'),
              SizedBox(height: 8),
              Text(
                'Preset packs live separately from editor controls so we can reuse them in studio recommendations, editor quick picks, and future community recipe sharing.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        const AppSectionHeader(
          title: 'Preset packs',
          subtitle:
              'Curated looks with a small amount of metadata to keep the model simple.',
        ),
        const SizedBox(height: 16),
        ..._packs.map(
          (pack) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: PresetLibraryTile(preset: pack),
          ),
        ),
      ],
    );
  }
}
