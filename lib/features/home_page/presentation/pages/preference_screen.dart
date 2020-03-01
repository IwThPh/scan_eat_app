import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/preference/bloc.dart';
import 'package:scaneat/features/home_page/presentation/widgets/widgets.dart';

class PreferenceScreen extends StatefulWidget {
  const PreferenceScreen({
    Key key,
    @required PreferenceBloc preferenceBloc,
  })  : _preferenceBloc = preferenceBloc,
        super(key: key);

  final PreferenceBloc _preferenceBloc;

  @override
  PreferenceScreenState createState() {
    return PreferenceScreenState(_preferenceBloc);
  }
}

class PreferenceScreenState extends State<PreferenceScreen> {
  final PreferenceBloc _preferenceBloc;
  PreferenceScreenState(this._preferenceBloc);

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
              'Your Preferences',
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
          child: BlocBuilder<PreferenceBloc, PreferenceState>(
            bloc: widget._preferenceBloc,
            builder: (
              BuildContext context,
              PreferenceState currentState,
            ) {
              if (currentState is UnPreferenceState) {
                return Center(child: LoadingWidget());
              }
              if (currentState is ErrorPreferenceState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(currentState.errorMessage ?? 'Error'),
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: RaisedButton(
                        color: Colours.green,
                        child: Text('reload'),
                        onPressed: () => this._load(),
                      ),
                    ),
                  ],
                );
              }
              if (currentState is InPreferenceState) {
                return Text('Loaded Preferences.');
              }
              return Container();
            },
          ),
        ),
      ],
    );
  }

  void _load() {
    widget._preferenceBloc.add(UnPreferenceEvent());
    widget._preferenceBloc.add(LoadPreferenceEvent());
  }

  void _edit(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: "Edit Preferences",
        content: Text('Preferences Here'),
      ),
    ).whenComplete(() {
      widget._preferenceBloc.add(LoadPreferenceEvent());
    });
  }
}
