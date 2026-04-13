import 'package:flutter/widgets.dart';

import 'app/app.dart';
import 'core/config/app_env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppEnv.load();
  runApp(const FilmedmeApp());
}
