import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/theme/app_theme.dart';
import '../../../../core/animations/SlideBottomRoute.dart';
import '../bloc/home_page/preference/bloc.dart';
import '../widgets/widgets.dart';
import 'preference_page.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({
    Key key,
    @required PreferenceBloc preferenceBloc,
  })  : _preferenceBloc = preferenceBloc,
        super(key: key);

  final PreferenceBloc _preferenceBloc;

  @override
  PreferenceScreenState createState() {
    return PreferenceScreenState();
  }
}

class PreferenceScreenState extends State<PreferenceScreen> {
  PreferenceScreenState();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    this._load();
  }

  void _load() {
    widget._preferenceBloc.add(UnPreferenceEvent());
    widget._preferenceBloc.add(LoadPreferenceEvent());
  }

  void _edit(BuildContext context) {
    Navigator.push(
      context,
      SlideBottomRoute(
        page: PreferencePage(preferenceBloc: widget._preferenceBloc),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Preferences',
                    style: AppTheme.theme.textTheme.headline
                        .apply(color: Colors.white),
                  ),
                  OutlineButton(
                    borderSide: BorderSide(color: Colours.offWhite),
                    highlightColor: Colours.green,
                    highlightedBorderColor: Colours.greenAccent,
                    textColor: Colours.offWhite,
                    onPressed: () => _edit(context),
                    child: Text('Edit'),
                  ),
                ],
              ),
              Divider(
                color: Colours.offWhite,
                thickness: 2,
              ),
            ],
          ),
        ),
        Container(
          child: BlocBuilder<PreferenceBloc, PreferenceState>(
            bloc: widget._preferenceBloc,
            builder: (
              BuildContext context,
              PreferenceState state,
            ) {
              if (state is UnPreferenceState) {
                return Center(child: LoadingWidget());
              }
              if (state is ErrorPreferenceState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(state.errorMessage ?? 'Error'),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: IconButton(
                          color: Colours.offBlack,
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
                final p = state.preference;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Calories',
                                style: AppTheme.theme.textTheme.subtitle
                                    .apply(color: Colors.white),
                              ),
                              Text(
                                'Daily Max : ' + p.energyMax.toString() + 'Kcal',
                                style: AppTheme.theme.textTheme.subtitle
                                    .apply(color: Colors.white),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colours.offWhite,
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 120,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          NutrientDisplay(
                              name: 'Carbohyrates',
                              max: p.carbohydrateMax.toString(),
                              s1: p.carbohydrate_1,
                              s2: p.carbohydrate_2),
                          NutrientDisplay(
                              name: 'Protein',
                              max: p.proteinMax.toString(),
                              s1: p.protein_1,
                              s2: p.protein_2),
                          NutrientDisplay(
                              name: 'Fat',
                              max: p.fatMax.toString(),
                              s1: p.fat_1,
                              s2: p.fat_2),
                          NutrientDisplay(
                              name: 'Fibre',
                              max: p.fibreMax.toString(),
                              s1: p.fibre_1,
                              s2: p.fibre_2),
                          NutrientDisplay(
                              name: 'Salt',
                              max: p.saltMax.toString(),
                              s1: p.salt_1,
                              s2: p.salt_2),
                          NutrientDisplay(
                              name: 'Sodium',
                              max: p.sodiumMax.toString(),
                              s1: p.sodium_1,
                              s2: p.sodium_2),
                          NutrientDisplay(
                              name: 'Saturated',
                              max: p.saturatedMax.toString(),
                              s1: p.saturated_1,
                              s2: p.saturated_2),
                          NutrientDisplay(
                              name: 'Sugar',
                              max: p.sugarMax.toString(),
                              s1: p.sugar_1,
                              s2: p.sugar_2)
                        ],
                      ),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }
}
