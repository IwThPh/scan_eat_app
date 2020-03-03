import 'package:flutter/material.dart';
import 'package:scaneat/di_container.dart' as di;
import 'package:scaneat/features/home_page/domain/entities/preference.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/preference/bloc.dart';
import 'package:scaneat/features/scanning/presentation/pages/scanning_page_screen.dart';

import '../../../../assets/theme/app_theme.dart';
import '../bloc/bloc.dart';

class ScanningPage extends StatelessWidget {
  static const String routeName = '/scan';
  final ScanningBloc _scanningBloc = di.sl<ScanningBloc>();
  final Preference _preference;

  ScanningPage({
    Key key,
    @required Preference preference,
  })  : _preference = preference,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colours.primaryAccent,
          child: ScanningPageScreen(
            scanningPageBloc: _scanningBloc,
            preference: _preference,
          ),
        ),
      ),
    );
  }
}
