import 'package:flutter/material.dart';

import '../settings/settings_screen.dart';
import '../../app/theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, this.onLogout});

  final Future<void> Function()? onLogout;

  Future<void> _handleLogout(BuildContext context) async {
    if (onLogout == null) return;
    
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('ออกจากระบบ', style: TextStyle(color: Colors.white)),
          content: const Text('คุณต้องการออกจากระบบใช่หรือไม่?', style: TextStyle(color: Colors.white70)),
          backgroundColor: const Color(0xFF1A1C23),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('ยกเลิก', style: TextStyle(color: Colors.white60)),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: FilledButton.styleFrom(backgroundColor: Colors.red.shade900),
              child: const Text('ออกจากระบบ', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      await onLogout?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    return Drawer(
      width: MediaQuery.sizeOf(context).width,
      backgroundColor: colors.bg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: MediaQuery.paddingOf(context).top),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.close, color: colors.ink, size: 24),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  FilledButton.icon(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFFFFD166),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                      minimumSize: const Size(0, 36),
                    ),
                    icon: const Icon(Icons.diamond_outlined, size: 16),
                    label: const Text(
                      'UPGRADE',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 0.5),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  bottom: MediaQuery.paddingOf(context).bottom + 32,
                ),
                children: [
                  _buildSectionHeader('CONNECT', colors),
                  _buildMenuItem('ความเคลื่อนไหว', context, colors),
                  _buildMenuItem('ข้อความ', context, colors),
                  _buildMenuItem('รายการโปรด', context, colors),
                  _buildMenuItem('บุคคล', context, colors),
                  const SizedBox(height: 24),
                  Divider(color: colors.line, height: 1),
                  const SizedBox(height: 24),
                  _buildSectionHeader('FROM FILMEDME', colors),
                  _buildFeatureItem(
                    title: 'Canvas',
                    subtitle: 'Moodboarding and visual planning',
                    icon: Icons.grid_view_rounded,
                    isNew: true,
                    colors: colors,
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureItem(
                    title: 'Capture',
                    subtitle: 'Advanced camera and tools',
                    icon: Icons.camera_alt_outlined,
                    isNew: true,
                    colors: colors,
                  ),
                  const SizedBox(height: 24),
                  Divider(color: colors.line, height: 1),
                  const SizedBox(height: 24),
                  _buildSectionHeader('ACCOUNT', colors),
                  _buildMenuItem('Privacy & data', context, colors),
                  _buildMenuItem('Support', context, colors),
                  _buildMenuItem('Safety', context, colors),
                  _buildMenuItem('About', context, colors),
                  _buildMenuItem('การตั้งค่า', context, colors, onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    );
                  }),
                  _buildMenuItem('ออกจากระบบ', context, colors, onTap: () => _handleLogout(context)),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ],
        ),
    );
  }

  Widget _buildSectionHeader(String title, AppColors colors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: TextStyle(
          color: colors.muted,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  Widget _buildMenuItem(String title, BuildContext context, AppColors colors, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          title,
          style: TextStyle(
            color: colors.ink,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required AppColors colors,
    bool isNew = false,
  }) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: colors.ink, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: colors.ink,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (isNew) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: colors.ink,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'NEW',
                            style: TextStyle(
                              color: colors.bg,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: colors.muted,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
