import 'package:flutter/material.dart';

import '../features/auth/login_screen.dart';
import '../features/auth/models/auth_session.dart';
import '../features/auth/services/auth_session_store.dart';
import '../features/home/home_screen.dart';
import '../features/presets/presets_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/shell/app_shell_screen.dart';
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
      destinations: [
        const AppShellDestination(
          label: 'Studio',
          icon: Icons.grid_view_rounded,
          screen: StudioScreen(),
        ),
        AppShellDestination(
          label: 'Home',
          icon: Icons.filter_none_rounded,
          screen: HomeScreen(onLogout: _logout),
        ),
        const AppShellDestination(
          label: 'Create',
          icon: Icons.add_photo_alternate_outlined,
          screen: PresetsScreen(),
        ),
        const AppShellDestination(
          label: 'Profile',
          icon: Icons.person_rounded,
          screen: ProfileScreen(),
        ),
      ],
    );
  }
}
