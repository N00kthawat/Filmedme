import 'package:flutter/material.dart';

import '../../app/theme.dart';

class SpacesScreen extends StatelessWidget {
  const SpacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return ColoredBox(
      color: colors.bg,
      child: Center(
        child: Text(
          'SPACES\nCOMING SOON',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colors.muted,
            letterSpacing: 2.2,
            fontSize: 11,
            height: 1.6,
          ),
        ),
      ),
    );
  }
}
