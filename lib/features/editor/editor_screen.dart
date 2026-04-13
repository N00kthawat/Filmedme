import 'package:flutter/material.dart';

import '../../core/widgets/app_section_header.dart';
import '../../core/widgets/film_action_button.dart';
import '../../core/widgets/soft_card.dart';
import 'widgets/editor_adjustment_row.dart';
import 'widgets/editor_preview_panel.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text('Editor')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: const [
          EditorPreviewPanel(),
          SizedBox(height: 24),
          AppSectionHeader(
            title: 'Edit controls',
            subtitle:
                'A clean shell for the main image adjustments we will wire to real state next.',
          ),
          SizedBox(height: 16),
          SoftCard(
            child: Column(
              children: [
                EditorAdjustmentRow(label: 'Exposure', value: 0.68),
                SizedBox(height: 18),
                EditorAdjustmentRow(label: 'Contrast', value: 0.52),
                SizedBox(height: 18),
                EditorAdjustmentRow(label: 'Temperature', value: 0.43),
                SizedBox(height: 18),
                EditorAdjustmentRow(label: 'Grain', value: 0.71),
                SizedBox(height: 18),
                EditorAdjustmentRow(label: 'Fade', value: 0.29),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: FilmActionButton(
                  label: 'Save recipe',
                  icon: Icons.bookmark_border_rounded,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: FilmActionButton(
                  label: 'Export',
                  icon: Icons.file_upload_outlined,
                  inverted: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
