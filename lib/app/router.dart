import 'package:flutter/material.dart';

import '../features/ai_lab/ai_lab_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/models/auth_session.dart';
import '../features/auth/services/auth_session_store.dart';
import '../features/feed/feed_screen.dart';
import '../features/discover/discover_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/shell/app_shell_screen.dart';
import '../features/spaces/spaces_screen.dart';
import '../features/studio/studio_screen.dart';

class AppRouter extends StatefulWidget {
  const AppRouter({super.key});

  @override
  State<AppRouter> createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  final _sessionStore = AuthSessionStore();
  AuthSession? _session;
  bool _isBootstrapping = true;

  @override
  void initState() {
    super.initState();
    _bootstrapSession();
  }

  Future<void> _bootstrapSession() async {
    final existingSession = await _sessionStore.read();
    if (!mounted) return;
    setState(() {
      _session = existingSession;
      _isBootstrapping = false;
    });
  }

  Future<void> _onLoginSuccess(AuthSession session) async {
    await _sessionStore.save(session);
    if (!mounted) return;
    setState(() {
      _session = session;
    });
  }

  Future<void> _logout() async {
    await _sessionStore.clear();
    if (!mounted) return;
    setState(() {
      _session = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isBootstrapping) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_session == null) {
      return LoginScreen(onLoginSuccess: _onLoginSuccess);
    }

    return AppShellScreen(
      initialIndex: 1,
      onLogout: _logout,
      destinations: [
        const AppShellDestination(
          label: 'Feed',
          icon: Icons.home_outlined,
          activeIcon: Icons.home_filled,
          screen: FeedScreen(),
        ),
        const AppShellDestination(
          label: 'Discover',
          icon: Icons.search_rounded,
          activeIcon: Icons.search,
          screen: DiscoverScreen(),
        ),
        const AppShellDestination(
          label: 'Studio',
          icon: Icons.crop_square_rounded,
          activeIcon: Icons.crop_square,
          screen: StudioScreen(),
        ),
        const AppShellDestination(
          label: 'AI Lab',
          icon: Icons.auto_awesome_outlined,
          activeIcon: Icons.auto_awesome,
          screen: AiLabScreen(),
        ),
        const AppShellDestination(
          label: 'Profile',
          icon: Icons.sentiment_satisfied_alt_outlined,
          activeIcon: Icons.sentiment_satisfied_alt,
          screen: ProfileScreen(),
        ),
        const AppShellDestination(
          label: 'Spaces',
          icon: Icons.dashboard_outlined,
          activeIcon: Icons.dashboard,
          screen: SpacesScreen(),
        ),
      ],
    );
  }
}
