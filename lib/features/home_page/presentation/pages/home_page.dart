import 'dart:developer' as developer;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class HomePage extends StatelessWidget {
  static const String routeName = '/homePage';
  final _user;
  final _homePageBloc = di.sl<HomePageBloc>();
  final _allergenBloc = di.sl<AllergenBloc>();
  final _dietBloc = di.sl<DietBloc>();
  final _preferenceBloc = di.sl<PreferenceBloc>();

  HomePage(this._user);

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
              user: _user,
            ),
          ),
        ),
      ),
    );
  }

  void _scan(BuildContext context, Preference pref, List<Allergen> allergens,
      List<Diet> diets) {
    Navigator.push(
      context,
      SlideBottomRoute(
        page:
            ScanningPage(preference: pref, allergens: allergens, diets: diets),
      ),
    );
  }

  void _saved(BuildContext context) {
    Navigator.push(
      context,
      SlideBottomRoute(
        page: SavedPage(),
      ),
    );
  }

  void _history(BuildContext context) {
    Navigator.push(
      context,
      SlideBottomRoute(
        page: HistoryPage(),
      ),
    );
  }
}
