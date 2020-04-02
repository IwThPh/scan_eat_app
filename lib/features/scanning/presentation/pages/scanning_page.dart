import 'package:flutter/material.dart';

import '../../../../assets/theme/app_theme.dart';
import '../../../../di_container.dart' as di;
import '../../../home_page/domain/entities/allergen.dart';
import '../../../home_page/domain/entities/diet.dart';
import '../../../home_page/domain/entities/preference.dart';
import '../bloc/bloc.dart';
import 'scanning_page_screen.dart';

class ScanningPage extends StatelessWidget {
  static const String routeName = '/scan';
  final ScanningBloc _scanningBloc = di.sl<ScanningBloc>();
  final Preference _preference;
  final List<Allergen> _allergens;
  final List<Diet> _diets;

  ScanningPage({
    Key key,
    @required Preference preference,
    @required List<Allergen> allergens,
    @required List<Diet> diets,
  })  : _preference = preference,
        _allergens = allergens,
        _diets = diets,
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
            allergens: _allergens,
            diets: _diets,
          ),
        ),
      ),
    );
  }
}
