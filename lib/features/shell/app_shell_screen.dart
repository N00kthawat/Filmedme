import 'package:flutter/material.dart';

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
  });

  final List<AppShellDestination> destinations;
  final int initialIndex;

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
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Color(0xFF17191F), Color(0xFF2C2F36), Color(0xFF17191F)],
            ),
            border: Border(
              top: BorderSide(color: Color(0xFF1F2127)),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: const Color(0xFFF3F3F5),
            unselectedItemColor: const Color(0xFFA2A6AE),
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
