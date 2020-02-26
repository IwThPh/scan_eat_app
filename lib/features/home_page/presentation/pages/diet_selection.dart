import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/features/home_page/data/models/diet_model.dart';
import 'package:scaneat/features/home_page/domain/entities/diet.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/diet/bloc.dart';
import 'package:scaneat/features/home_page/presentation/widgets/widgets.dart';

class DietSelection extends StatefulWidget {
  const DietSelection({
    Key key,
    @required DietBloc dietBloc,
  })  : _dietBloc = dietBloc,
        super(key: key);

  final DietBloc _dietBloc;
  @override
  _DietSelectionState createState() => _DietSelectionState(_dietBloc);
}

class _DietSelectionState extends State<DietSelection> {
  final DietBloc _dietBloc;
  _DietSelectionState(this._dietBloc);
  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    return BlocBuilder(
      bloc: _dietBloc,
      builder: (context, state) {
        if (state is InDietState) {
          List<Diet> selections = state.diets;
          return Container(
            child: Column(
              children: <Widget>[
                Wrap(
                  spacing: 5,
                  children: selections.map((a) {
                    return ChoiceChip(
                      selected: a.selected,
                      label: Text(a.name),
                      labelStyle: AppTheme.theme.textTheme.button
                          .apply(color: Colours.offBlack),
                      backgroundColor: Colours.offWhite,
                      selectedColor: Colours.green,
                      onSelected: (value) {
                        setState(() {
                          DietModel b = DietModel(
                            id: a.id,
                            name: a.name,
                            description: a.description,
                            selected: value,
                          );
                          selections[selections.indexOf(a)] = b;
                        });
                      },
                    );
                  }).toList(),
                  direction: Axis.horizontal,
                ),
                FlatButton(
                  child: Text('Save'),
                  onPressed: () {
                    widget._dietBloc.add(UnDietEvent());
                    widget._dietBloc.add(UpdateDietEvent(selections));
                  },
                )
              ],
            ),
          );
        }
        if (state is UnDietState) {
          return LoadingWidget();
        }
        if (state is MessageDietState) {
          return Text(state.message);
        }
        return Container(width: 0, height: 0);
      },
    );
  }
}

