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
    userId = pref.userId;
    energy = Nutrient(
        nutrientMax: pref.energyMax, nutrient_1: 1000, nutrient_2: 4000);
    carbs = Nutrient(
        nutrientMax: pref.carbohydrateMax,
        nutrient_1: pref.carbohydrate_1,
        nutrient_2: pref.carbohydrate_2);
    protein = Nutrient(
        nutrientMax: pref.proteinMax,
        nutrient_1: pref.protein_1,
        nutrient_2: pref.protein_2);
    fat = Nutrient(
        nutrientMax: pref.fatMax,
        nutrient_1: pref.fat_1,
        nutrient_2: pref.fat_2);
    saturate = Nutrient(
        nutrientMax: pref.saturatedMax,
        nutrient_1: pref.saturated_1,
        nutrient_2: pref.saturated_2);
    fibre = Nutrient(
        nutrientMax: pref.fibreMax,
        nutrient_1: pref.fibre_1,
        nutrient_2: pref.fibre_2);
    sodium = Nutrient(
        nutrientMax: pref.sodiumMax,
        nutrient_1: pref.sodium_1,
        nutrient_2: pref.sodium_2);
    salt = Nutrient(
        nutrientMax: pref.saltMax,
        nutrient_1: pref.salt_1,
        nutrient_2: pref.salt_2);
    sugar = Nutrient(
        nutrientMax: pref.sugarMax,
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
      userId: userId,
      energyMax: energy.nutrientMax,
      carbohydrateMax: carbs.nutrientMax,
      carbohydrate_1: carbs.nutrient_1,
      carbohydrate_2: carbs.nutrient_2,
      proteinMax: protein.nutrientMax,
      protein_1: protein.nutrient_1,
      protein_2: protein.nutrient_2,
      fatMax: fat.nutrientMax,
      fat_1: fat.nutrient_1,
      fat_2: fat.nutrient_2,
      saturatedMax: saturate.nutrientMax,
      saturated_1: saturate.nutrient_1,
      saturated_2: saturate.nutrient_2,
      fibreMax: fibre.nutrientMax,
      fibre_1: fibre.nutrient_1,
      fibre_2: fibre.nutrient_2,
      sodiumMax: sodium.nutrientMax,
      sodium_1: sodium.nutrient_1,
      sodium_2: sodium.nutrient_2,
      saltMax: salt.nutrientMax,
      salt_1: salt.nutrient_1,
      salt_2: salt.nutrient_2,
      sugarMax: sugar.nutrientMax,
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
                        energy.nutrientMax.toStringAsFixed(2) +
                        'Kcal',
                    onTap: () => _edit(
                        context, 'Daily Calories', energy, 1000, 4000,
                        unit: 'Kcal', isRange: false),
                  ),
                  NutrientListTile(
                    title: 'Carbohyrates',
                    subtitle: 'Daily Max : ' +
                        carbs.nutrientMax.toStringAsFixed(2) +
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
                        protein.nutrientMax.toStringAsFixed(2) +
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
                        fat.nutrientMax.toStringAsFixed(2) +
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
                        saturate.nutrientMax.toStringAsFixed(2) +
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
                        fibre.nutrientMax.toStringAsFixed(2) +
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
                        sodium.nutrientMax.toStringAsFixed(2) +
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
                        salt.nutrientMax.toStringAsFixed(2) +
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
                        sugar.nutrientMax.toStringAsFixed(2) +
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
