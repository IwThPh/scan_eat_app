import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/assets/theme/colours.dart';
import 'package:scaneat/features/login/presentation/bloc/bloc.dart';

import '../widgets/widgets.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({
    Key key,
    @required LoginPageBloc loginPageBloc,
  })  : _loginPageBloc = loginPageBloc,
        super(key: key);

  final LoginPageBloc _loginPageBloc;

  @override
  LoginPageScreenState createState() {
    return LoginPageScreenState(_loginPageBloc);
  }
}

class LoginPageScreenState extends State<LoginPageScreen>
    with SingleTickerProviderStateMixin {
  final LoginPageBloc _loginPageBloc;
  LoginPageScreenState(this._loginPageBloc);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

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
    tabList.add(Tab(child: Text('Login')));
    tabList.add(Tab(child: Text('Register')));
    this._tabController =
        new TabController(length: tabList.length, vsync: this);
    this._tabController.addListener(_handleTabSelection);
    this._load();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
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

    return BlocBuilder(
      bloc: _loginPageBloc,
      builder: (
        BuildContext context,
        LoginPageState currentState,
      ) {
        if (currentState is UnLoginPageState) {
          return LoadingWidget();
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
          //TODO: Fire animation trigger to home here.
          return Column(
            children: <Widget>[
              Text('Completed Login'),
              Text(currentState.token),
              RaisedButton(
                onPressed: () => _load(false),
                child: Text('Reset'),
              ),
            ],
          );
        }
        if (currentState is ErrorLoginPageState) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text(currentState.errorMessage),
              RaisedButton(
                onPressed: () => _load(false),
                child: Text('Reset'),
              ),
            ],
          );
        }
        return Text('Error');
      },
    );
  }

  void _load([bool isError = false]) {
    widget._loginPageBloc.add(UnLoginPageEvent());
    widget._loginPageBloc.add(LoadLoginPageEvent(isError));
  }
}
