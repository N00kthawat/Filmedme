import 'package:flutter/material.dart';

import 'router.dart';
import 'theme.dart';

class FilmedmeApp extends StatelessWidget {
  const FilmedmeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filmedme',
      debugShowCheckedModeBanner: false,
      theme: buildFilmedmeTheme(),
      home: const AppRouter(),
    );
  }
}
