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
    return AllergenScreenState(_allergenBloc);
  }
}

class AllergenScreenState extends State<AllergenScreen> {
  final AllergenBloc _allergenBloc;
  AllergenScreenState(this._allergenBloc);

  @override
  void initState() {
    super.initState();
    this._load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Allergens',
              style:
                  AppTheme.theme.textTheme.subhead.apply(color: Colors.white),
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
                return Wrap(
                  children: currentState.allergens.map((a) {
                    return a.selected
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Chip(
                              label: Text(a.name),
                              labelStyle: AppTheme.theme.textTheme.button
                                  .apply(color: Colors.white),
                              backgroundColor: Colours.green,
                            ),
                          )
                        : Container(width: 0, height: 0);
                  }).toList(),
                  direction: Axis.horizontal,
                );
              }
              return Container();
            },
          ),
        ),
      ],
    );
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
          allergenBloc: _allergenBloc,
        ),
      ),
    ).whenComplete(() {
      widget._allergenBloc.add(LoadAllergenEvent());
    });
  }
}
