import 'package:flutter/material.dart';

class EditorAdjustmentRow extends StatelessWidget {
  const EditorAdjustmentRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: theme.textTheme.titleMedium),
            const Spacer(),
            Text('${(value * 100).round()}', style: theme.textTheme.labelLarge),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 12,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(
              theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
