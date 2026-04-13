import 'package:flutter/material.dart';
import '../../app/theme.dart';

class AppFab extends StatefulWidget {
  const AppFab({super.key});

  @override
  State<AppFab> createState() => _AppFabState();
}

class _AppFabState extends State<AppFab> with SingleTickerProviderStateMixin {
  final GlobalKey _fabKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _removeOverlay();
    _animController.dispose();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _toggleMenu() {
    if (_overlayEntry != null) {
      _animController.reverse().then((_) => _removeOverlay());
      return;
    }

    final RenderBox button = _fabKey.currentContext!.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset fabOffset = button.localToGlobal(Offset.zero, ancestor: overlay);
    final Size fabSize = button.size;

    // Capture theme colors from current context before entering the overlay
    final colors = Theme.of(context).extension<AppColors>()!;

    const double menuWidth = 320.0;
    final double menuRight = overlay.size.width - fabOffset.dx - fabSize.width;
    const double gap = 8.0; // gap between FAB and menu group 2

    _overlayEntry = OverlayEntry(
      builder: (ctx) => FadeTransition(
        opacity: _fadeAnim,
        child: Stack(
          children: [
            // Dismiss on tap outside
            Positioned.fill(
              child: GestureDetector(
                onTap: () => _animController.reverse().then((_) => _removeOverlay()),
                behavior: HitTestBehavior.translucent,
                child: const SizedBox.expand(),
              ),
            ),
            // Both groups stacked together, anchored just above the FAB
            Positioned(
              right: menuRight,
              bottom: overlay.size.height - fabOffset.dy + gap,
              width: menuWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildMenuGroup(
                    items: [
                      _MenuItem('New moodboard', Icons.auto_awesome_mosaic_outlined),
                      _MenuItem('พื้นที่ใหม่', Icons.space_dashboard_outlined),
                      _MenuItem('สร้างบล็อก', Icons.edit_square),
                      _MenuItem('โพสต์ไปยัง VSCO', Icons.lens_blur),
                    ],
                    colors: colors,
                    onSelect: (_) => _animController.reverse().then((_) => _removeOverlay()),
                  ),
                  const SizedBox(height: 8),
                  _buildMenuGroup(
                    items: [
                      _MenuItem('นำเข้า', Icons.add_circle_outline),
                      _MenuItem('แก้ไขร่าง', Icons.tune),
                    ],
                    colors: colors,
                    onSelect: (_) => _animController.reverse().then((_) => _removeOverlay()),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _animController.forward(from: 0);
  }

  Widget _buildMenuGroup({
    required List<_MenuItem> items,
    required AppColors colors,
    required void Function(String) onSelect,
  }) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.line, width: 0.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(items.length, (i) {
            final item = items[i];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  borderRadius: BorderRadius.vertical(
                    top: i == 0 ? const Radius.circular(16) : Radius.zero,
                    bottom: i == items.length - 1 ? const Radius.circular(16) : Radius.zero,
                  ),
                  onTap: () => onSelect(item.label),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.label,
                          style: TextStyle(
                            color: colors.ink,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Icon(item.icon, color: colors.ink, size: 26),
                      ],
                    ),
                  ),
                ),
                if (i < items.length - 1)
                  Divider(
                    color: colors.line,
                    height: 1,
                    thickness: 1,
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;

    return FloatingActionButton(
      key: _fabKey,
      heroTag: null,
      onPressed: _toggleMenu,
      // FAB: ink background + bg foreground → dark in light mode, light in dark mode
      backgroundColor: colors.ink,
      foregroundColor: colors.bg,
      shape: const CircleBorder(),
      elevation: 4,
      child: const Icon(Icons.add, size: 32),
    );
  }
}

class _MenuItem {
  final String label;
  final IconData icon;
  const _MenuItem(this.label, this.icon);
}
