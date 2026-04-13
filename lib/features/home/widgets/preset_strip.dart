import 'package:flutter/material.dart';

import '../../../core/models/preset_pack.dart';
import '../../../core/widgets/soft_card.dart';

class PresetStrip extends StatelessWidget {
  const PresetStrip({super.key, required this.presets});

  final List<PresetPack> presets;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 174,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: presets.length,
        separatorBuilder: (_, _) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          final preset = presets[index];
          return SizedBox(
            width: 220,
            child: SoftCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: theme.colorScheme.secondaryContainer,
                        child: Text(
                          preset.name,
                          style: theme.textTheme.labelLarge,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${(preset.intensity * 100).round()}%',
                        style: theme.textTheme.labelLarge,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(preset.description, style: theme.textTheme.bodyLarge),
                  const Spacer(),
                  Text(
                    'Temp ${preset.temperature > 0 ? '+' : ''}${preset.temperature}  •  Grain ${preset.grain}',
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
