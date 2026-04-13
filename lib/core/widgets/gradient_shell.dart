import 'package:flutter/material.dart';

class GradientShell extends StatelessWidget {
  const GradientShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF8F2EA), Color(0xFFF1E7D8), Color(0xFFEDE4D6)],
        ),
      ),
      child: child,
    );
  }
}
