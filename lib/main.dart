import 'package:flutter/services.dart';
import 'package:scaneat/features/login/presentation/pages/login_page.dart';

import 'assets/theme/app_theme.dart';
import 'di_container.dart' as di;

import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    await di.init();
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: LoginPage(),
    );
  }
}
