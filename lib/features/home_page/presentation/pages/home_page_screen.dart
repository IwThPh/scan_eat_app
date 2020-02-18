import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/bloc.dart';

import '../widgets/widgets.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({
    Key key,
    @required HomePageBloc homePageBloc,
  })  : _homePageBloc = homePageBloc,
        super(key: key);

  final HomePageBloc _homePageBloc;

  @override
  HomePageScreenState createState() {
    return HomePageScreenState(_homePageBloc);
  }
}

class HomePageScreenState extends State<HomePageScreen> {
  final HomePageBloc _homePageBloc;
  HomePageScreenState(this._homePageBloc);

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
    return BlocBuilder<HomePageBloc, HomePageState>(
        bloc: widget._homePageBloc,
        builder: (
          BuildContext context,
          HomePageState currentState,
        ) {
          if (currentState is UnHomePageState) {
            return Center(
              child: Container(
                child: LoadingWidget(),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
              ),
            );
          }
          if (currentState is ErrorHomePageState) {
            return Center(
                child: Column(
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
            ));
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Hello <<User>>',
                style: AppTheme.theme.textTheme.display1
                    .apply(color: Colors.white),
              ),
              Placeholder(
                fallbackHeight: 150,
                fallbackWidth: MediaQuery.of(context).size.width,
              ),
              Placeholder(
                fallbackHeight: 150,
                fallbackWidth: MediaQuery.of(context).size.width,
              ),
            ],
          );
        });
  }

  void _load([bool isError = false]) {
    widget._homePageBloc.add(UnHomePageEvent());
    widget._homePageBloc.add(LoadHomePageEvent(isError));
  }
}
