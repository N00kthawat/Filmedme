import 'package:flutter/material.dart';

import '../../../core/models/preset_pack.dart';
import '../../../core/widgets/soft_card.dart';

class PresetLibraryTile extends StatelessWidget {
  const PresetLibraryTile({super.key, required this.preset});

  final PresetPack preset;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SoftCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: theme.colorScheme.secondaryContainer,
            ),
            alignment: Alignment.center,
            child: Text(preset.name, style: theme.textTheme.titleMedium),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        preset.description,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${(preset.intensity * 100).round()}%',
                      style: theme.textTheme.labelLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Temp ${preset.temperature > 0 ? '+' : ''}${preset.temperature}  •  Grain ${preset.grain}',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
