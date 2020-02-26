import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/core/animations/SlideBottomRoute.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/diet/bloc.dart';
import 'package:scaneat/features/home_page/presentation/pages/diet_selection.dart';
import 'package:scaneat/features/home_page/presentation/widgets/name_desc_display.dart';
import 'package:scaneat/features/home_page/presentation/widgets/widgets.dart';

class DietScreen extends StatefulWidget {
  const DietScreen({
    Key key,
    @required DietBloc dietBloc,
  })  : _dietBloc = dietBloc,
        super(key: key);

  final DietBloc _dietBloc;

  @override
  DietScreenState createState() {
    return DietScreenState(_dietBloc);
  }
}

class DietScreenState extends State<DietScreen> {
  final DietBloc _dietBloc;
  DietScreenState(this._dietBloc);

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
              'Diets',
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
          child: BlocBuilder<DietBloc, DietState>(
            bloc: widget._dietBloc,
            builder: (
              BuildContext context,
              DietState currentState,
            ) {
              if (currentState is UnDietState) {
                return Center(child: LoadingWidget());
              }
              if (currentState is ErrorDietState) {
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
              if (currentState is InDietState) {
                return Wrap(
                  children: currentState.diets.map((a) {
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
    widget._dietBloc.add(UnDietEvent());
    widget._dietBloc.add(LoadDietEvent());
  }

  void _edit(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Edit Diets",
        content: DietSelection(
          dietBloc: _dietBloc,
        ),
      ),
    ).whenComplete(() {
      widget._dietBloc.add(LoadDietEvent());
    });
  }
}
