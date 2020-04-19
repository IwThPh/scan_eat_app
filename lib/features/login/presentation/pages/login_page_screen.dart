import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/assets/theme/colours.dart';
import 'package:scaneat/core/animations/SlideBottomRoute.dart';
import 'package:scaneat/di_container.dart';
import 'package:scaneat/features/home_page/presentation/pages/home_page.dart';
import 'package:scaneat/features/login/presentation/bloc/bloc.dart';

import '../widgets/widgets.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({
    Key key,
  }) : super(key: key);

  @override
  LoginPageScreenState createState() {
    return LoginPageScreenState();
  }
}

class LoginPageScreenState extends State<LoginPageScreen>
    with SingleTickerProviderStateMixin {
  LoginPageScreenState();

  LoginPageBloc _loginPageBloc;

  TabController _tabController;
  List<Tab> tabList = List();
  int _tabIndex = 0;

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  changeTab(int index) {
    setState(() {
      _tabIndex = index;
      _tabController.animateTo(index);
    });
  }

  @override
  void initState() {
    super.initState();
    _loginPageBloc = sl<LoginPageBloc>();
    tabList.add(Tab(child: Text('Login')));
    tabList.add(Tab(child: Text('Register')));
    this._tabController =
        new TabController(length: tabList.length, vsync: this);
    this._tabController.addListener(_handleTabSelection);
    this._load();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //ShapeBorder for tabBar
    ShapeBorder tb = RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.elliptical(MediaQuery.of(context).size.width + 30, 80),
      ),
    );

    //Listens for error callback.
    BlocListener(
      bloc: _loginPageBloc,
      listener: (context, state) {
        if (state is InLoginPageState) {
          state.isReg ? changeTab(1) : changeTab(0);
        }
      },
    );

    return BlocConsumer(
      bloc: _loginPageBloc,
      listener: (
        BuildContext context,
        LoginPageState currentState,
      ) {
        if (currentState is CompleteLoginPageState) {
          developer
              .log(currentState.user.name + ' | ' + currentState.user.email);
          Navigator.pushReplacement(
            context,
            SlideBottomRoute(page: HomePage(currentState.user)),
          );
        }
      },
      builder: (
        BuildContext context,
        LoginPageState currentState,
      ) {
        if (currentState is UnLoginPageState) {
          return LoadingWidget(
            message: 'Initialising',
          );
        }
        if (currentState is InLoginPageState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Material(
                shape: tb,
                clipBehavior: Clip.antiAlias,
                elevation: 4,
                color: Colours.green,
                child: TabBar(
                  indicatorColor: Colours.offWhite,
                  labelColor: Colours.offWhite,
                  unselectedLabelColor: Colours.offBlack,
                  controller: _tabController,
                  tabs: tabList,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: [
                    LoginForm(_loginPageBloc),
                    RegisterForm(_loginPageBloc, currentState?.errors),
                  ][_tabIndex],
                ),
              ),
            ],
          );
        }
        if (currentState is CompleteLoginPageState) {
          return LoadingWidget(
            message: 'Logging In.',
          );
        }
        if (currentState is ErrorLoginPageState) {
          return displayError(currentState.errorMessage);
        }
        return displayError('Big Error');
      },
    );
  }

  void _load() {
    _loginPageBloc.add(UnLoginPageEvent());
    _loginPageBloc.add(LoadLoginPageEvent());
  }

  Widget displayError(String errorMessage) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(errorMessage),
        ),
        RaisedButton(
          onPressed: () => _load(),
          child: Text('Reset'),
        ),
      ],
    );
  }
}
