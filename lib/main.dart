import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/features/login/presentation/pages/login_page.dart';
import 'package:scaneat/features/scanning/presentation/bloc/bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<ScanningBloc>(
          create: (_) => di.sl<ScanningBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        home: LoginPage(),
      ),
    );
  }
}
