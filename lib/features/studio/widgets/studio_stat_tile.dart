import 'package:flutter/material.dart';

import '../../../core/widgets/soft_card.dart';

class StudioStatTile extends StatelessWidget {
  const StudioStatTile({
    super.key,
    required this.label,
    required this.value,
    required this.caption,
  });

  final String label;
  final String value;
  final String caption;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SoftCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 16),
          Text(value, style: theme.textTheme.headlineMedium),
          const SizedBox(height: 8),
          Text(caption, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
