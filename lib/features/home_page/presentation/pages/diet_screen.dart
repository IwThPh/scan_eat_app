import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/diet/bloc.dart';
import 'package:scaneat/features/home_page/presentation/pages/diet_selection.dart';
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
    return DietScreenState();
  }
}

class DietScreenState extends State<DietScreen> {
  DietScreenState();

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
    widget._dietBloc.add(UnDietEvent());
    widget._dietBloc.add(LoadDietEvent());
  }

  void _edit(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Edit Diets",
        content: DietSelection(
          dietBloc: widget._dietBloc,
        ),
      ),
    ).whenComplete(() {
      widget._dietBloc.add(LoadDietEvent());
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
                    'Diets',
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
                var selected = currentState.diets.where((a) => a.selected);
                if (selected.isEmpty)
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'No Diets Selected',
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
