import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/features/home_page/data/models/allergen_model.dart';
import 'package:scaneat/features/home_page/domain/entities/allergen.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/allergen/bloc.dart';
import 'package:scaneat/features/home_page/presentation/widgets/widgets.dart';

class AllergenSelection extends StatefulWidget {
  const AllergenSelection({
    Key key,
    @required AllergenBloc allergenBloc,
  })  : _allergenBloc = allergenBloc,
        super(key: key);

  final AllergenBloc _allergenBloc;
  @override
  _AllergenSelectionState createState() =>
      _AllergenSelectionState(_allergenBloc);
}

class _AllergenSelectionState extends State<AllergenSelection> {
  final AllergenBloc _allergenBloc;
  _AllergenSelectionState(this._allergenBloc);
  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    return BlocBuilder(
      bloc: _allergenBloc,
      builder: (context, state) {
        if (state is InAllergenState) {
          List<Allergen> selections = state.allergens;
          return Container(
            child: Column(
              children: <Widget>[
                Wrap(
                  spacing: 5,
                  alignment: WrapAlignment.center,
                  children: selections.map((a) {
                    return ChoiceChip(
                      selected: a.selected,
                      label: Text(a.name),
                      labelStyle: a.selected
                          ? AppTheme.theme.textTheme.button
                              .apply(color: Colors.white)
                          : AppTheme.theme.textTheme.button
                              .apply(color: Colours.offBlack),
                      backgroundColor: Colours.offWhite,
                      selectedColor: Colours.green,
                      onSelected: (value) {
                        setState(() {
                          AllergenModel b = AllergenModel(
                            id: a.id,
                            name: a.name,
                            description: a.description,
                            selected: value,
                          );
                          selections[selections.indexOf(a)] = b;
                        });
                        log(a.name + ' is ' + value.toString());
                      },
                    );
                  }).toList(),
                  direction: Axis.horizontal,
                ),
                FloatingActionButton(
                  elevation: 2,
                  mini: true,
                  backgroundColor: Colours.primary,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    widget._allergenBloc.add(UnAllergenEvent());
                    widget._allergenBloc.add(UpdateAllergenEvent(selections));
                  },
                )
              ],
            ),
          );
        }
        if (state is UnAllergenState) {
          return LoadingWidget();
        }
        if (state is MessageAllergenState) {
          return Text(state.message);
        }
        return Container(width: 0, height: 0);
      },
    );
  }
}
