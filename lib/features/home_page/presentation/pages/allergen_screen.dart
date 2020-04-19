import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/allergen/bloc.dart';
import 'package:scaneat/features/home_page/presentation/pages/allergen_selection.dart';
import 'package:scaneat/features/home_page/presentation/widgets/custom_dialog.dart';
import '../widgets/widgets.dart';

class AllergenScreen extends StatefulWidget {
  const AllergenScreen({
    Key key,
    @required AllergenBloc allergenBloc,
  })  : _allergenBloc = allergenBloc,
        super(key: key);

  final AllergenBloc _allergenBloc;

  @override
  AllergenScreenState createState() {
    return AllergenScreenState();
  }
}

class AllergenScreenState extends State<AllergenScreen> {
  AllergenScreenState();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    this._load();
  }

  void _load([bool isError = false]) {
    widget._allergenBloc.add(UnAllergenEvent());
    widget._allergenBloc.add(LoadAllergenEvent());
  }

  void _edit(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Edit Allergens",
        content: AllergenSelection(
          allergenBloc: widget._allergenBloc,
        ),
      ),
    ).whenComplete(() {
      widget._allergenBloc.add(LoadAllergenEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Allergens',
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
          child: BlocBuilder<AllergenBloc, AllergenState>(
            bloc: widget._allergenBloc,
            builder: (
              BuildContext context,
              AllergenState currentState,
            ) {
              if (currentState is UnAllergenState) {
                return Center(child: LoadingWidget());
              }
              if (currentState is ErrorAllergenState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(currentState.errorMessage ?? 'Error'),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: RaisedButton(
                        color: Colors.blue,
                        child: Text('reload'),
                        onPressed: () => this._load(),
                      ),
                    ),
                  ],
                );
              }
              if (currentState is InAllergenState) {
                var selected = currentState.allergens.where((a) => a.selected);
                if (selected.isEmpty)
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'No Allergens Selected',
                        style: AppTheme.theme.textTheme.body2
                            .apply(color: Colors.white),
                      ),
                    ),
                  );
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Wrap(
                    spacing: 4,
                    alignment: WrapAlignment.spaceEvenly,
                    children: selected.map((a) {
                      return Chip(
                        label: Text(a.name),
                        labelStyle: AppTheme.theme.textTheme.button
                            .apply(color: Colors.white),
                        backgroundColor: Colours.green,
                      );
                    }).toList(),
                    direction: Axis.horizontal,
                  ),
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
