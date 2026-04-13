import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/theme/theme_controller.dart';
import '../../core/theme/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _openCamera = false;
  bool _syncContacts = true;
  bool _onlyAllowMessages = true;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>()!;
    final themeController = ThemeProvider.of(context);
    final themeModeStr = themeController.themeMode == ThemeMode.light 
        ? 'light' 
        : themeController.themeMode == ThemeMode.dark ? 'dark' : 'system';
    return Scaffold(
      backgroundColor: colors.bg,
      appBar: AppBar(
        backgroundColor: colors.bg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: colors.ink, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'การตั้งค่า',
          style: TextStyle(
            color: colors.ink,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            _buildSectionHeader('การกำหนดค่า', colors),
            _buildSwitch(
              title: 'เปิดกล้องเมื่อเปิดแอป',
              value: _openCamera,
              onChanged: (val) => setState(() => _openCamera = val),
              colors: colors,
            ),
            _buildSwitch(
              title: 'การซิงค์รายชื่อผู้ติดต่อ',
              value: _syncContacts,
              onChanged: (val) => setState(() => _syncContacts = val),
              colors: colors,
            ),
            _buildSwitch(
              title: 'Only allow messages from people I follow',
              value: _onlyAllowMessages,
              onChanged: (val) => setState(() => _onlyAllowMessages = val),
              colors: colors,
            ),
            
            const SizedBox(height: 24),
            _buildSectionHeader('ซิงค์', colors),
            _buildStorageWidget(colors),
            _buildListItem(
              title: 'ข้อมูลเพิ่มเติมเกี่ยวกับการซิงค์',
              trailing: Icon(Icons.info_outline, color: colors.ink, size: 20),
              colors: colors,
            ),
            
            const SizedBox(height: 24),
            _buildSectionHeader('ลักษณะ', colors),
            _buildRadio(title: 'สว่าง', value: 'light', currentVal: themeModeStr, colors: colors, controller: themeController),
            _buildRadio(title: 'มืด', value: 'dark', currentVal: themeModeStr, colors: colors, controller: themeController),
            _buildRadio(title: 'ใช้การตั้งค่าระบบ', value: 'system', currentVal: themeModeStr, colors: colors, controller: themeController),
            
            const SizedBox(height: 24),
            const SizedBox(height: 16),
            _buildListItem(title: 'ส่งออกฉบับร่างทั้งหมด', colors: colors),
            const SizedBox(height: 12),
            _buildListItem(title: 'จะจัดการพรีเซ็ตและเครื่องมือได้อย่างไร', colors: colors),
            const SizedBox(height: 12),
            _buildListItem(title: 'ลบบัญชีของฉัน', colors: colors),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, AppColors colors) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, top: 8),
      child: Text(
        title,
        style: TextStyle(
          color: colors.ink,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildSwitch({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
    required AppColors colors,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: colors.ink, fontSize: 15),
            ),
          ),
          const SizedBox(width: 16),
          CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeColor: colors.ink,
            thumbColor: value ? colors.bg : const Color(0xFF8E8E93),
            trackColor: colors.line,
          ),
        ],
      ),
    );
  }

  Widget _buildRadio({
    required String title, 
    required String value, 
    required String currentVal, 
    required AppColors colors,
    required ThemeController controller,
  }) {
    final isSelected = currentVal == value;
    return InkWell(
      onTap: () {
        ThemeMode newMode;
        if (value == 'light') {
          newMode = ThemeMode.light;
        } else if (value == 'dark') {
          newMode = ThemeMode.dark;
        } else {
          newMode = ThemeMode.system;
        }
        controller.updateThemeMode(newMode);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: colors.ink, fontSize: 15),
              ),
            ),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: isSelected ? null : Border.all(color: const Color(0xFF666666), width: 2),
                color: isSelected ? colors.ink : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem({required String title, Widget? trailing, required AppColors colors}) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: colors.ink, fontSize: 15),
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildStorageWidget(AppColors colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('พื้นที่เก็บข้อมูล', style: TextStyle(color: colors.ink, fontSize: 15)),
              Text('4.4 MB / 25 MB', style: TextStyle(color: colors.muted, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            height: 4,
            decoration: BoxDecoration(
              color: colors.line,
              borderRadius: BorderRadius.circular(2),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 44, // 4.4
                  child: Container(
                    decoration: BoxDecoration(
                      color: colors.ink,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const Expanded(
                  flex: 206, // 25 - 4.4
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
