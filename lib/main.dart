import 'package:flutter/widgets.dart';

import 'app/app.dart';
import 'core/config/app_env.dart';
import 'core/theme/theme_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppEnv.load();
  final themeController = await ThemeController.create();
  runApp(FilmedmeApp(themeController: themeController));
}
