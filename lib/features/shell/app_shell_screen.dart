import 'package:flutter/material.dart';

import '../../core/widgets/gradient_shell.dart';

class AppShellDestination {
  const AppShellDestination({
    required this.label,
    required this.icon,
    required this.screen,
  });

  final String label;
  final IconData icon;
  final Widget screen;
}

class AppShellScreen extends StatefulWidget {
  const AppShellScreen({super.key, required this.destinations});

  final List<AppShellDestination> destinations;

  @override
  State<AppShellScreen> createState() => _AppShellScreenState();
}

class _AppShellScreenState extends State<AppShellScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GradientShell(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          bottom: false,
          child: IndexedStack(
            index: _currentIndex,
            children: widget.destinations.map((item) => item.screen).toList(),
          ),
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: NavigationBar(
              selectedIndex: _currentIndex,
              destinations: widget.destinations
                  .map(
                    (item) => NavigationDestination(
                      icon: Icon(item.icon),
                      label: item.label,
                    ),
                  )
                  .toList(),
              onDestinationSelected: (index) {
                setState(() => _currentIndex = index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
