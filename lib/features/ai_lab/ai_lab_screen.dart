import 'package:flutter/material.dart';

class AiLabScreen extends StatelessWidget {
  const AiLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: Color(0xFF08090C),
      child: Center(
        child: Text(
          'AI LAB\nEXPERIMENTS',
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
