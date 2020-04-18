import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/allergen/allergen_bloc.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/allergen/allergen_event.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/bloc.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/diet/bloc.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/preference/bloc.dart';
import 'package:scaneat/features/home_page/presentation/pages/allergen_screen.dart';
import 'package:scaneat/features/home_page/presentation/pages/diet_screen.dart';
import 'package:scaneat/features/home_page/presentation/pages/preference_screen.dart';
import 'package:scaneat/features/login/domain/entities/user.dart';

import '../widgets/widgets.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({
    Key key,
    @required User user,
    @required HomePageBloc homePageBloc,
    @required AllergenBloc allergenBloc,
    @required DietBloc dietBloc,
    @required PreferenceBloc preferenceBloc,
  })  : _homePageBloc = homePageBloc,
        _allergenBloc = allergenBloc,
        _dietBloc = dietBloc,
        _preferenceBloc = preferenceBloc,
        _user = user,
        super(key: key);

  final User _user;
  final HomePageBloc _homePageBloc;
  final AllergenBloc _allergenBloc;
  final DietBloc _dietBloc;
  final PreferenceBloc _preferenceBloc;

  @override
  HomePageScreenState createState() {
    return HomePageScreenState();
  }
}

class HomePageScreenState extends State<HomePageScreen> {
  HomePageScreenState();

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
                    color: Colours.green,
                    child: Text('reload'),
                    onPressed: () => this._load(),
                  ),
                ),
              ],
            ),
          );
        }
        return _buildBody();
      },
    );
  }

  void _load() {
    widget._homePageBloc.add(UnHomePageEvent());
    widget._homePageBloc.add(LoadHomePageEvent());
    widget._preferenceBloc.add(LoadPreferenceEvent());
    widget._allergenBloc.add(LoadAllergenEvent());
    widget._dietBloc.add(LoadDietEvent());
  }

  Widget _buildBody() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Hello ' + widget._user.name,
              textAlign: TextAlign.left,
              style:
                  AppTheme.theme.textTheme.display1.apply(color: Colors.white),
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(8),
          sliver: SliverToBoxAdapter(
            child: PreferenceScreen(
              preferenceBloc: widget._preferenceBloc,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(8),
          sliver: SliverToBoxAdapter(
            child: AllergenScreen(
              allergenBloc: widget._allergenBloc,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(8),
          sliver: SliverToBoxAdapter(
            child: DietScreen(
              dietBloc: widget._dietBloc,
            ),
          ),
        ),
        SliverPadding(padding: EdgeInsets.all(16.0)),
      ],
    );
  }
}
