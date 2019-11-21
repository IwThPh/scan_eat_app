import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/features/scanning/presentation/bloc/bloc.dart';
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
    return BlocProvider(
      builder: (_) => di.sl<ScanningBloc>(),
      child: MaterialApp(
        theme: AppTheme.theme,
        home: ScanningPage(),
      ),
    );
  }
}
