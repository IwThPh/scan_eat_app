import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/theme/app_theme.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../data/models/preference_model.dart';
import '../../domain/entities/nutrient.dart';
import '../../domain/entities/preference.dart';
import '../bloc/home_page/preference/bloc.dart';
import '../widgets/widgets.dart';
import 'nutrient_edit.dart';

class PreferencePage extends StatefulWidget {
  const PreferencePage({
    Key key,
    @required PreferenceBloc preferenceBloc,
  })  : _preferenceBloc = preferenceBloc,
        super(key: key);

  final PreferenceBloc _preferenceBloc;

  @override
  _PreferencePageState createState() => _PreferencePageState();
}

class _PreferencePageState extends State<PreferencePage> {
  Preference pref;
  Nutrient energy, carbs, protein, fat, saturate, fibre, sodium, salt, sugar;
  int userId;

  void _make(Preference pref) {
    userId = pref.user_id;
    energy = Nutrient(
        nutrient_max: pref.energy_max, nutrient_1: 1000, nutrient_2: 4000);
    carbs = Nutrient(
        nutrient_max: pref.carbohydrate_max,
        nutrient_1: pref.carbohydrate_1,
        nutrient_2: pref.carbohydrate_2);
    protein = Nutrient(
        nutrient_max: pref.protein_max,
        nutrient_1: pref.protein_1,
        nutrient_2: pref.protein_2);
    fat = Nutrient(
        nutrient_max: pref.fat_max,
        nutrient_1: pref.fat_1,
        nutrient_2: pref.fat_2);
    saturate = Nutrient(
        nutrient_max: pref.saturated_max,
        nutrient_1: pref.saturated_1,
        nutrient_2: pref.saturated_2);
    fibre = Nutrient(
        nutrient_max: pref.fibre_max,
        nutrient_1: pref.fibre_1,
        nutrient_2: pref.fibre_2);
    sodium = Nutrient(
        nutrient_max: pref.sodium_max,
        nutrient_1: pref.sodium_1,
        nutrient_2: pref.sodium_2);
    salt = Nutrient(
        nutrient_max: pref.salt_max,
        nutrient_1: pref.salt_1,
        nutrient_2: pref.salt_2);
    sugar = Nutrient(
        nutrient_max: pref.sugar_max,
        nutrient_1: pref.sugar_1,
        nutrient_2: pref.sugar_2);
  }

  void _save() {
    widget._preferenceBloc.add(UnPreferenceEvent());
    widget._preferenceBloc.add(UpdatePreferenceEvent(pref));
  }

  void _load() {
    widget._preferenceBloc.add(UnPreferenceEvent());
    widget._preferenceBloc.add(LoadPreferenceEvent());
  }

  void _edit(BuildContext context, String name, Nutrient nutrient, double min,
      double max,
      {String unit = "g", bool isRange = true}) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Edit " + name,
        content: NutrientEdit(
          nutrient: nutrient,
          max: max,
          min: min,
          unit: unit,
          isRange: isRange,
        ),
      ),
    ).whenComplete(() => _updatePref());
  }

  void _updatePref() {
    PreferenceModel p = PreferenceModel(
      user_id: userId,
      energy_max: energy.nutrient_max,
      carbohydrate_max: carbs.nutrient_max,
      carbohydrate_1: carbs.nutrient_1,
      carbohydrate_2: carbs.nutrient_2,
      protein_max: protein.nutrient_max,
      protein_1: protein.nutrient_1,
      protein_2: protein.nutrient_2,
      fat_max: fat.nutrient_max,
      fat_1: fat.nutrient_1,
      fat_2: fat.nutrient_2,
      saturated_max: saturate.nutrient_max,
      saturated_1: saturate.nutrient_1,
      saturated_2: saturate.nutrient_2,
      fibre_max: fibre.nutrient_max,
      fibre_1: fibre.nutrient_1,
      fibre_2: fibre.nutrient_2,
      sodium_max: sodium.nutrient_max,
      sodium_1: sodium.nutrient_1,
      sodium_2: sodium.nutrient_2,
      salt_max: salt.nutrient_max,
      salt_1: salt.nutrient_1,
      salt_2: salt.nutrient_2,
      sugar_max: sugar.nutrient_max,
      sugar_1: sugar.nutrient_1,
      sugar_2: sugar.nutrient_2,
    );
    setState(() {
      pref = p;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
          title: Text(
        'Edit Preferences',
        style: AppTheme.theme.textTheme.title.apply(color: Colours.offBlack),
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colours.primary,
        tooltip: 'Save Preferences',
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
        onPressed: () => _save(),
      ),
      body: BlocBuilder(
        bloc: widget._preferenceBloc,
        builder: (context, state) {
          if (state is UnPreferenceState) {
            return Center(child: LoadingWidget());
          }
          if (state is ErrorPreferenceState) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(state.errorMessage ?? 'Error'),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: IconButton(
                      color: Colours.green,
                      iconSize: 40,
                      icon: Icon(Icons.refresh),
                      onPressed: () => this._load(),
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is InPreferenceState) {
            if (pref == null) pref = state.preference;
            _make(pref);
            return Container(
              child: ListView(
                children: <Widget>[
                  NutrientListTile(
                    title: 'Daily Calories',
                    subtitle: 'Daily Max : ' +
                        energy.nutrient_max.toStringAsFixed(2) +
                        'Kcal',
                    onTap: () => _edit(
                        context, 'Daily Calories', energy, 1000, 4000,
                        unit: 'Kcal', isRange: false),
                  ),
                  NutrientListTile(
                    title: 'Carbohyrates',
                    subtitle: 'Daily Max : ' +
                        carbs.nutrient_max.toStringAsFixed(2) +
                        'g\n' +
                        'Low-Med: ' +
                        (carbs.nutrient_1 * 100).toStringAsFixed(2) +
                        '%, ' +
                        'Med-High: ' +
                        (carbs.nutrient_2 * 100).toStringAsFixed(2) +
                        '%.',
                    onTap: () => _edit(context, 'Carbohydrates', carbs, 0, 500),
                  ),
                  NutrientListTile(
                    title: 'Protein',
                    subtitle: 'Daily Max : ' +
                        protein.nutrient_max.toStringAsFixed(2) +
                        'g\n' +
                        'Low-Med: ' +
                        (protein.nutrient_1 * 100).toStringAsFixed(2) +
                        '%, ' +
                        'Med-High: ' +
                        (protein.nutrient_2 * 100).toStringAsFixed(2) +
                        '%.',
                    onTap: () => _edit(context, 'Protein', protein, 0, 80),
                  ),
                  NutrientListTile(
                    title: 'Fat',
                    subtitle: 'Daily Max : ' +
                        fat.nutrient_max.toStringAsFixed(2) +
                        'g\n' +
                        'Low-Med: ' +
                        (fat.nutrient_1 * 100).toStringAsFixed(2) +
                        '%, ' +
                        'Med-High: ' +
                        (fat.nutrient_2 * 100).toStringAsFixed(2) +
                        '%.',
                    onTap: () => _edit(context, 'Fat', fat, 0, 100),
                  ),
                  NutrientListTile(
                    title: 'Saturated Fat',
                    subtitle: 'Daily Max : ' +
                        saturate.nutrient_max.toStringAsFixed(2) +
                        'g\n' +
                        'Low-Med: ' +
                        (saturate.nutrient_1 * 100).toStringAsFixed(2) +
                        '%, ' +
                        'Med-High: ' +
                        (saturate.nutrient_2 * 100).toStringAsFixed(2) +
                        '%.',
                    onTap: () => _edit(context, 'Saturates', saturate, 0, 100),
                  ),
                  NutrientListTile(
                    title: 'Fibre',
                    subtitle: 'Daily Max : ' +
                        fibre.nutrient_max.toStringAsFixed(2) +
                        'g\n' +
                        'Low-Med: ' +
                        (fibre.nutrient_1 * 100).toStringAsFixed(2) +
                        '%, ' +
                        'Med-High: ' +
                        (fibre.nutrient_2 * 100).toStringAsFixed(2) +
                        '%.',
                    onTap: () => _edit(context, 'Fibre', fibre, 0, 100),
                  ),
                  NutrientListTile(
                    title: 'Sodium',
                    subtitle: 'Daily Max : ' +
                        sodium.nutrient_max.toStringAsFixed(2) +
                        'g\n' +
                        'Low-Med: ' +
                        (sodium.nutrient_1 * 100).toStringAsFixed(2) +
                        '%, ' +
                        'Med-High: ' +
                        (sodium.nutrient_2 * 100).toStringAsFixed(2) +
                        '%.',
                    onTap: () => _edit(context, 'Sodium', sodium, 0, 100),
                  ),
                  NutrientListTile(
                    title: 'Salt',
                    subtitle: 'Daily Max : ' +
                        salt.nutrient_max.toStringAsFixed(2) +
                        'g\n' +
                        'Low-Med: ' +
                        (salt.nutrient_1 * 100).toStringAsFixed(2) +
                        '%, ' +
                        'Med-High: ' +
                        (salt.nutrient_2 * 100).toStringAsFixed(2) +
                        '%.',
                    onTap: () => _edit(context, 'Salt', salt, 0, 100),
                  ),
                  NutrientListTile(
                    title: 'Sugar',
                    subtitle: 'Daily Max : ' +
                        sugar.nutrient_max.toStringAsFixed(2) +
                        'g\n' +
                        'Low-Med: ' +
                        (sugar.nutrient_1 * 100).toStringAsFixed(2) +
                        '%, ' +
                        'Med-High: ' +
                        (sugar.nutrient_2 * 100).toStringAsFixed(2) +
                        '%.',
                    onTap: () => _edit(context, 'Sugar', sugar, 0, 100),
                  ),
                  Container(
                    height: 100,
                  ),
                  FlatButton(
                    child: Text(
                      'Reset Preferences',
                      style: AppTheme.theme.textTheme.button
                          .apply(color: Colours.offBlack),
                    ),
                    onPressed: () {
                      pref = null;
                      widget._preferenceBloc.add(UnPreferenceEvent());
                      widget._preferenceBloc.add(ResetPreferenceEvent());
                    },
                  ),
                ],
              ),
            );
          }
          return Container(width: 0, height: 0);
        },
      ),
    );
  }
}
