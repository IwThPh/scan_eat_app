import 'package:flutter/material.dart';
import 'package:scaneat/assets/theme/app_theme.dart';

import '../../../../assets/theme/colours.dart';
import '../../../../core/animations/SlideBottomRoute.dart';
import '../../../../core/animations/SlideLeftRoute.dart';
import '../../../../core/animations/SlideRightRoute.dart';
import '../../../../di_container.dart' as di;
import '../../../scanning/presentation/pages/scanning_page.dart';
import '../../domain/entities/allergen.dart';
import '../../domain/entities/diet.dart';
import '../../domain/entities/preference.dart';
import '../bloc/home_page/allergen/bloc.dart';
import '../bloc/home_page/bloc.dart';
import '../bloc/home_page/diet/bloc.dart';
import '../bloc/home_page/preference/bloc.dart';
import 'history_page.dart';
import 'home_page_screen.dart';
import 'saved_page.dart';

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
  void dispose() {
    _allergenBloc.close();
    _dietBloc.close();
    _homePageBloc.close();
    _preferenceBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _allergenBloc = di.sl<AllergenBloc>();
    _dietBloc = di.sl<DietBloc>();
    _homePageBloc = di.sl<HomePageBloc>();
    _preferenceBloc = di.sl<PreferenceBloc>();
  }

  void _scan(BuildContext context, Preference pref, List<Allergen> allergens,
      List<Diet> diets) {
    Navigator.push(
      context,
      SlideBottomRoute(
        page: ScanningPage(allergens: allergens, diets: diets),
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
    //ShapeBorder for Panel
    ShapeBorder sb = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(16)),
    );

    return Scaffold(
      backgroundColor: Colours.primary,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.photo_camera,
          size: 32,
          color: Colours.green,
        ),
        onPressed: () {
          final prefState = _preferenceBloc.state;
          final allergenState = _allergenBloc.state;
          final dietState = _dietBloc.state;
          if (prefState is InPreferenceState &&
              allergenState is InAllergenState &&
              dietState is InDietState) {
            _scan(context, prefState.preference, allergenState.allergens,
                dietState.diets);
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 8,
        color: Colours.primaryAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RawMaterialButton(
              shape: sb,
              highlightColor: Colours.primary,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 32,
                    ),
                    Text(' Saved',
                        style: AppTheme.theme.textTheme.button
                            .apply(color: Colors.white))
                  ],
                ),
              ),
              onPressed: () => _saved(context),
            ),
            RawMaterialButton(
              shape: sb,
              highlightColor: Colours.primary,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Text('History ',
                        style: AppTheme.theme.textTheme.button
                            .apply(color: Colors.white)),
                    Icon(
                      Icons.view_list,
                      color: Colors.white,
                      size: 32,
                    ),
                  ],
                ),
              ),
              onPressed: () => _history(context),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
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
    );
  }
}
