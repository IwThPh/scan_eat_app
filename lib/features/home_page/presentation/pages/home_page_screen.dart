import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/core/animations/SlideTopRoute.dart';
import 'package:scaneat/di_container.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/allergen/allergen_bloc.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/allergen/allergen_event.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/bloc.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/diet/bloc.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/preference/bloc.dart';
import 'package:scaneat/features/home_page/presentation/pages/allergen_screen.dart';
import 'package:scaneat/features/home_page/presentation/pages/diet_screen.dart';
import 'package:scaneat/features/home_page/presentation/pages/preference_screen.dart';
import 'package:scaneat/features/login/domain/entities/user.dart';
import 'package:scaneat/features/login/presentation/bloc/bloc.dart';
import 'package:scaneat/features/login/presentation/pages/login_page.dart';

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

  final AllergenBloc _allergenBloc;
  final DietBloc _dietBloc;
  final HomePageBloc _homePageBloc;
  final PreferenceBloc _preferenceBloc;
  final User _user;

  @override
  HomePageScreenState createState() {
    return HomePageScreenState();
  }
}

class HomePageScreenState extends State<HomePageScreen> {
  HomePageScreenState();

  LoginPageBloc _loginPageBloc;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loginPageBloc = sl<LoginPageBloc>();
    this._load();
  }

  void _load() {
    widget._homePageBloc.add(UnHomePageEvent());
    widget._homePageBloc.add(LoadHomePageEvent());
    widget._preferenceBloc.add(LoadPreferenceEvent());
    widget._allergenBloc.add(LoadAllergenEvent());
    widget._dietBloc.add(LoadDietEvent());
  }

  Widget _buildBody() {
    ShapeBorder sb = RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
    );

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          actions: <Widget>[
            RawMaterialButton(
              shape: (RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(16)))),
              highlightColor: Colours.primary,
              fillColor: Colours.primaryAccent,
              child: Row(
                children: <Widget>[
                  Text('Logout ',
                      style: AppTheme.theme.textTheme.button
                          .apply(color: Colors.white)),
                  Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ),
              onPressed: () => _loginPageBloc.add(LogoutLoginPageEvent()),
            ),
          ],
          elevation: 0,
          pinned: true,
          backgroundColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: Size(200, 42),
            child: Material(
              color: Colors.transparent,
              elevation: 8,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: Image.asset(
                  'lib/assets/icon/logo.png',
                  height: 52,
                  width: 154,
                  semanticLabel: 'ScanEat Logo',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
          flexibleSpace: ClipPath.shape(
            shape: sb,
            child: Image.asset(
              'lib/assets/icon/test.jpg',
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(16),
          sliver: SliverToBoxAdapter(
            child: Text(
              'Hello, ${widget._user.name}!',
              textAlign: TextAlign.center,
              style:
                  AppTheme.theme.textTheme.headline.apply(color: Colors.white),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: PreferenceScreen(
            preferenceBloc: widget._preferenceBloc,
          ),
        ),
        SliverToBoxAdapter(
          child: AllergenScreen(
            allergenBloc: widget._allergenBloc,
          ),
        ),
        SliverToBoxAdapter(
          child: DietScreen(
            dietBloc: widget._dietBloc,
          ),
        ),
        SliverPadding(padding: EdgeInsets.all(16.0)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _loginPageBloc,
      listener: (context, state) {
        if (state is UnLoginPageState)
          Navigator.pushReplacement(
            context,
            SlideTopRoute(page: LoginPage()),
          );
      },
      child: BlocBuilder<HomePageBloc, HomePageState>(
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
      ),
    );
  }
}
