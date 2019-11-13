import 'package:scaneat/features/scanning/presentation/pages/scanning_page.dart';

import 'assets/theme/app_theme.dart';
import 'di_container.dart' as di;

import 'package:flutter/material.dart';

void main() async {
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      home: ScanningPage(),
    );
  }
}