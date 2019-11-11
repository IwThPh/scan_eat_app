import 'package:food_label_app/features/scanning/presentation/pages/scanning_page.dart';

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
      title: 'ScanEat',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: ScanningPage(title: 'ScanEat'),
    );
  }
}