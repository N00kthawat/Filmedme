import 'package:flutter/material.dart';

class SpacesScreen extends StatelessWidget {
  const SpacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFF08090C),
      child: Center(
        child: Text(
          'SPACES\nCOMING SOON',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFA2A6AE),
            letterSpacing: 2.2,
            fontSize: 11,
            height: 1.6,
          ),
        ),
      ),
    );
  }
}
