import 'package:flutter/material.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFF08090C),
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: _currentIndex,
          children: widget.destinations.map((item) => item.screen).toList(),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF111216),
            border: Border(
              top: BorderSide(color: Color(0xFF1F2127)),
            ),
          ),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              backgroundColor: const Color(0xFF111216),
              indicatorColor: Colors.white.withValues(alpha: 0.1),
              labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
              iconTheme: WidgetStateProperty.resolveWith((states) {
                return IconThemeData(
                  color: states.contains(WidgetState.selected)
                      ? const Color(0xFFF2F2F4)
                      : const Color(0xFF747A84),
                );
              }),
            ),
            child: NavigationBar(
              height: 62,
              selectedIndex: _currentIndex,
              destinations: widget.destinations
                  .map(
                    (item) => NavigationDestination(
                      icon: Icon(item.icon, size: 20),
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
