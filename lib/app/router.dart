import 'package:flutter/material.dart';

import '../features/home/home_screen.dart';
import '../features/presets/presets_screen.dart';
import '../features/shell/app_shell_screen.dart';
import '../features/studio/studio_screen.dart';

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShellScreen(
      destinations: const [
        AppShellDestination(
          label: 'Discover',
          icon: Icons.grid_view_rounded,
          screen: HomeScreen(),
        ),
        AppShellDestination(
          label: 'Studio',
          icon: Icons.photo_library_outlined,
          screen: StudioScreen(),
        ),
        AppShellDestination(
          label: 'Library',
          icon: Icons.tune_rounded,
          screen: PresetsScreen(),
        ),
      ],
    );
  }
}
