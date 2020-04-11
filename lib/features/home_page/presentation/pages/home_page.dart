import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scaneat/core/animations/SlideLeftRoute.dart';
import 'package:scaneat/core/animations/SlideRightRoute.dart';
import 'package:scaneat/features/home_page/domain/entities/allergen.dart';
import 'package:scaneat/features/home_page/domain/entities/diet.dart';
import 'package:scaneat/features/home_page/presentation/pages/history_page.dart';
import 'package:scaneat/features/home_page/presentation/pages/saved_page.dart';

import '../../../../assets/theme/colours.dart';
import '../../../../core/animations/SlideBottomRoute.dart';
import '../../../../di_container.dart' as di;
import '../../../scanning/presentation/pages/scanning_page.dart';
import '../../domain/entities/preference.dart';
import '../bloc/home_page/allergen/bloc.dart';
import '../bloc/home_page/bloc.dart';
import '../bloc/home_page/diet/bloc.dart';
import '../bloc/home_page/preference/bloc.dart';
import 'home_page_screen.dart';

class HomePage extends StatefulWidget {
  HomePage(this._user);
  final _user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

    AllergenBloc _allergenBloc;
    DietBloc _dietBloc;
    HomePageBloc _homePageBloc;
    PreferenceBloc _preferenceBloc;

  @override
  void initState() {
    super.initState();
    _allergenBloc = di.sl<AllergenBloc>();
    _dietBloc = di.sl<DietBloc>();
    _homePageBloc = di.sl<HomePageBloc>();
    _preferenceBloc = di.sl<PreferenceBloc>();
  }

  @override
  void dispose() {
    _allergenBloc.close();
    _dietBloc.close();
    _homePageBloc.close();
    _preferenceBloc.close();
    super.dispose();
  }

  void _scan(BuildContext context, Preference pref, List<Allergen> allergens,
      List<Diet> diets) {
    Navigator.push(
      context,
      SlideBottomRoute(
        page:
            ScanningPage(allergens: allergens, diets: diets),
      ),
    );
  }

  void _saved(BuildContext context) {
    Navigator.push(
      context,
      SlideLeftRoute(
        page: SavedPage(),
      ),
    );
  }

  void _history(BuildContext context) {
    Navigator.push(
      context,
      SlideRightRoute(
        page: HistoryPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onPanUpdate: (details) {
          //Check if swipe direction is between top left and top right quadrants.
          if (details.delta.direction < -pi / 4 &&
              details.delta.direction > -(3 * pi) / 4) {
            // _scan(context);
          }
        },
        child: Scaffold(
          bottomNavigationBar: BottomAppBar(
            notchMargin: 10,
            color: Colours.primaryAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  color: Colours.offWhite,
                  icon: Icon(
                    Icons.favorite,
                  ),
                  onPressed: () => _saved(context),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.blur_on),
                    onPressed: () {
                      final prefState = _preferenceBloc.state;
                      final allergenState = _allergenBloc.state;
                      final dietState = _dietBloc.state;
                      if (prefState is InPreferenceState &&
                          allergenState is InAllergenState &&
                          dietState is InDietState) {
                        _scan(context, prefState.preference,
                            allergenState.allergens, dietState.diets);
                      }
                    },
                  ),
                ),
                IconButton(
                  color: Colours.offWhite,
                  icon: Icon(
                    Icons.restaurant,
                  ),
                  onPressed: () => _history(context),
                ),
              ],
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0, 0),
                end: Alignment(0, 1),
                stops: [0.1, 1],
                colors: [
                  Colours.primary,
                  Colours.primaryAccent,
                ],
              ),
            ),
            child: HomePageScreen(
              homePageBloc: _homePageBloc,
              allergenBloc: _allergenBloc,
              dietBloc: _dietBloc,
              preferenceBloc: _preferenceBloc,
              user: widget._user,
            ),
          ),
        ),
      ),
    );
  }
}
