import 'package:flutter/material.dart';

import '../../app/theme.dart';
import 'app_drawer.dart';

class AppShellDestination {
  const AppShellDestination({
    required this.label,
    required this.icon,
    required this.screen,
    this.activeIcon,
  });

  final String label;
  final IconData icon;
  final IconData? activeIcon;
  final Widget screen;
}

class AppShellScreen extends StatefulWidget {
  const AppShellScreen({
    super.key,
    required this.destinations,
    this.initialIndex = 1,
    this.onLogout,
  });

  final List<AppShellDestination> destinations;
  final int initialIndex;
  final Future<void> Function()? onLogout;

  @override
  State<AppShellScreen> createState() => _AppShellScreenState();
}

class _AppShellScreenState extends State<AppShellScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    final maxIndex = widget.destinations.isEmpty ? 0 : widget.destinations.length - 1;
    _currentIndex = widget.initialIndex.clamp(0, maxIndex);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Scaffold(
      backgroundColor: colors.bg,
      drawer: AppDrawer(onLogout: widget.onLogout),
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
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border(
              top: BorderSide(color: colors.line),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: colors.ink,
            unselectedItemColor: colors.muted,
            selectedLabelStyle: const TextStyle(fontSize: 11),
            unselectedLabelStyle: const TextStyle(fontSize: 11),
            items: widget.destinations
                .map(
                  (item) => BottomNavigationBarItem(
                    icon: Icon(item.icon, size: 18),
                    activeIcon: Icon(item.activeIcon ?? item.icon, size: 18),
                    label: item.label,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
