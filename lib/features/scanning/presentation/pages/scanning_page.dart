import 'package:flutter/material.dart';

import '../../../../assets/theme/app_theme.dart';
import '../../../home_page/domain/entities/allergen.dart';
import '../../../home_page/domain/entities/diet.dart';
import 'scanning_page_screen.dart';

class ScanningPage extends StatelessWidget {
  ScanningPage({
    Key key,
    @required List<Allergen> allergens,
    @required List<Diet> diets,
  })  : 
        _allergens = allergens,
        _diets = diets,
        super(key: key);

  static const String routeName = '/scan';

  final List<Allergen> _allergens;
  final List<Diet> _diets;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.primary,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colours.primaryAccent,
          child: ScanningPageScreen(
            allergens: _allergens,
            diets: _diets,
          ),
        ),
      ),
    );
  }
}
