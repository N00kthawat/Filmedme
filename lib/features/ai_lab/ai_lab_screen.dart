import 'package:flutter/material.dart';

import '../../app/theme.dart';

class AiLabScreen extends StatelessWidget {
  const AiLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return ColoredBox(
      color: colors.bg,
      child: Center(
        child: Text(
          'AI LAB\nEXPERIMENTS',
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
