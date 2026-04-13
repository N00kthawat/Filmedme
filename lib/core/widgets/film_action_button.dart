import 'package:flutter/material.dart';

class FilmActionButton extends StatelessWidget {
  const FilmActionButton({
    super.key,
    required this.label,
    required this.icon,
    this.inverted = false,
    this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool inverted;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final background = inverted ? theme.colorScheme.primary : Colors.white;
    final foreground = inverted ? Colors.white : theme.colorScheme.primary;

    return FilledButton.icon(
      onPressed: onPressed ?? () {},
      style: FilledButton.styleFrom(
        backgroundColor: background,
        foregroundColor: foreground,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: BorderSide(color: theme.colorScheme.outline),
        ),
      ),
      icon: Icon(icon, size: 18),
      label: Text(label),
    );
  }
}
