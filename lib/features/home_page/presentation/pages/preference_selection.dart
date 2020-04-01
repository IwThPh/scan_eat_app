import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/assets/theme/colours.dart';
import 'package:scaneat/features/home_page/data/models/preference_model.dart';
import 'package:scaneat/features/home_page/domain/entities/nutrient.dart';
import 'package:scaneat/features/home_page/domain/entities/preference.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/preference/bloc.dart';
import 'package:scaneat/features/home_page/presentation/pages/nutrient_edit.dart';
import 'package:scaneat/features/home_page/presentation/widgets/widgets.dart';

class PreferenceSelection extends StatefulWidget {
  const PreferenceSelection({
    Key key,
    @required PreferenceBloc preferenceBloc,
  })  : _preferenceBloc = preferenceBloc,
        super(key: key);

  final PreferenceBloc _preferenceBloc;

  @override
  _PreferenceSelectionState createState() =>
      _PreferenceSelectionState(_preferenceBloc);
}

class _PreferenceSelectionState extends State<PreferenceSelection> {
  final PreferenceBloc _preferenceBloc;
  _PreferenceSelectionState(this._preferenceBloc);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _preferenceBloc,
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
                    icon: Icon(Icons.replay),
                    onPressed: () => this._load(),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is InPreferenceState) {
          Preference pref = state.preference;
          Nutrient energy = Nutrient(
              nutrient_max: pref.energy_max,
              nutrient_1: 1000,
              nutrient_2: 4000);
          Nutrient carbs = Nutrient(
              nutrient_max: pref.carbohydrate_max,
              nutrient_1: pref.carbohydrate_1,
              nutrient_2: pref.carbohydrate_2);
          Nutrient protein = Nutrient(
              nutrient_max: pref.protein_max,
              nutrient_1: pref.protein_1,
              nutrient_2: pref.protein_2);
          Nutrient fat = Nutrient(
              nutrient_max: pref.fat_max,
              nutrient_1: pref.fat_1,
              nutrient_2: pref.fat_2);
          Nutrient saturate = Nutrient(
              nutrient_max: pref.saturated_max,
              nutrient_1: pref.saturated_1,
              nutrient_2: pref.saturated_2);
          Nutrient fibre = Nutrient(
              nutrient_max: pref.fibre_max,
              nutrient_1: pref.fibre_1,
              nutrient_2: pref.fibre_2);
          Nutrient sodium = Nutrient(
              nutrient_max: pref.sodium_max,
              nutrient_1: pref.sodium_1,
              nutrient_2: pref.sodium_2);
          Nutrient salt = Nutrient(
              nutrient_max: pref.salt_max,
              nutrient_1: pref.salt_1,
              nutrient_2: pref.salt_2);
          Nutrient sugar = Nutrient(
              nutrient_max: pref.sugar_max,
              nutrient_1: pref.sugar_1,
              nutrient_2: pref.sugar_2);
          return Container(
            child: ListView(
              children: <Widget>[
                NutrientListTile(
                  title: 'Daily Calories',
                  subtitle:
                      'Daily Max : ' + energy.nutrient_max.toString() + 'Kcal',
                  onTap: () => _edit(
                      context, 'Daily Calories', energy, 1000, 4000,
                      unit: 'Kcal', isRange: false),
                ),
                NutrientListTile(
                  title: 'Carbohyrates',
                  subtitle: 'Daily Max : ' +
                      carbs.nutrient_max.toString() +
                      'g\n' +
                      'Low-Med: ' +
                      (carbs.nutrient_1 * 100).toString() +
                      '%, ' +
                      'Med-High: ' +
                      (carbs.nutrient_2 * 100).toString() +
                      '%.',
                  onTap: () => _edit(context, 'Carbohydrates', carbs, 0, 500),
                ),
                NutrientListTile(
                  title: 'Protein',
                  subtitle: 'Daily Max : ' +
                      protein.nutrient_max.toString() +
                      'g\n' +
                      'Low-Med: ' +
                      (protein.nutrient_1 * 100).toString() +
                      '%, ' +
                      'Med-High: ' +
                      (protein.nutrient_2 * 100).toString() +
                      '%.',
                  onTap: () => _edit(context, 'Protein', protein, 0, 80),
                ),
                NutrientListTile(
                  title: 'Fat',
                  subtitle: 'Daily Max : ' +
                      fat.nutrient_max.toString() +
                      'g\n' +
                      'Low-Med: ' +
                      (fat.nutrient_1 * 100).toString() +
                      '%, ' +
                      'Med-High: ' +
                      (fat.nutrient_2 * 100).toString() +
                      '%.',
                  onTap: () => _edit(context, 'Fat', fat, 0, 100),
                ),
                NutrientListTile(
                  title: 'Saturated Fat',
                  subtitle: 'Daily Max : ' +
                      saturate.nutrient_max.toString() +
                      'g\n' +
                      'Low-Med: ' +
                      (saturate.nutrient_1 * 100).toString() +
                      '%, ' +
                      'Med-High: ' +
                      (saturate.nutrient_2 * 100).toString() +
                      '%.',
                  onTap: () => _edit(context, 'Saturates', saturate, 0, 100),
                ),
                NutrientListTile(
                  title: 'Fibre',
                  subtitle: 'Daily Max : ' +
                      fibre.nutrient_max.toString() +
                      'g\n' +
                      'Low-Med: ' +
                      (fibre.nutrient_1 * 100).toString() +
                      '%, ' +
                      'Med-High: ' +
                      (fibre.nutrient_2 * 100).toString() +
                      '%.',
                  onTap: () => _edit(context, 'Fibre', fibre, 0, 100),
                ),
                NutrientListTile(
                  title: 'Sodium',
                  subtitle: 'Daily Max : ' +
                      sodium.nutrient_max.toString() +
                      'g\n' +
                      'Low-Med: ' +
                      (sodium.nutrient_1 * 100).toString() +
                      '%, ' +
                      'Med-High: ' +
                      (sodium.nutrient_2 * 100).toString() +
                      '%.',
                  onTap: () => _edit(context, 'Sodium', sodium, 0, 100),
                ),
                NutrientListTile(
                  title: 'Salt',
                  subtitle: 'Daily Max : ' +
                      salt.nutrient_max.toString() +
                      'g\n' +
                      'Low-Med: ' +
                      (salt.nutrient_1 * 100).toString() +
                      '%, ' +
                      'Med-High: ' +
                      (salt.nutrient_2 * 100).toString() +
                      '%.',
                  onTap: () => _edit(context, 'Salt', salt, 0, 100),
                ),
                NutrientListTile(
                  title: 'Sugar',
                  subtitle: 'Daily Max : ' +
                      sugar.nutrient_max.toString() +
                      'g\n' +
                      'Low-Med: ' +
                      (sugar.nutrient_1 * 100).toString() +
                      '%, ' +
                      'Med-High: ' +
                      (sugar.nutrient_2 * 100).toString() +
                      '%.',
                  onTap: () => _edit(context, 'Sugar', sugar, 0, 100),
                ),
                FlatButton(
                  child: Text('Save'),
                  onPressed: () {
                    PreferenceModel b = PreferenceModel(
                      user_id: pref.user_id,
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
                    pref = b;
                    widget._preferenceBloc.add(UnPreferenceEvent());
                    widget._preferenceBloc.add(UpdatePreferenceEvent(pref));
                  },
                )
              ],
            ),
          );
        }
        if (state is UnPreferenceState) {
          return Center(child: LoadingWidget());
        }
        return Container(width: 0, height: 0);
      },
    );
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
    );
  }
}
