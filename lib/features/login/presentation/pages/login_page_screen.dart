import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/core/widgets/custom_text_form_field.dart';
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

class LoginPageScreenState extends State<LoginPageScreen> {
  final LoginPageBloc _loginPageBloc;
  LoginPageScreenState(this._loginPageBloc);

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
    return BlocBuilder<LoginPageBloc, LoginPageState>(
      bloc: _loginPageBloc,
      builder: (
        BuildContext context,
        LoginPageState currentState,
      ) {
        if (currentState is UnLoginPageState) {
          return Center(
            child: LoadingWidget(),
          );
        }
        if (currentState is ErrorLoginPageState) {
          return Center(
            child: LoadingWidget(),
          );
        }
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomTextFormField(
                label: "Email",
                icon: Icons.email,
              ),
              CustomTextFormField(
                label: "Password",
                icon: Icons.vpn_key,
                obscure: true,
              ),
            ],
          ),
        );
      },
    );
  }

  void _load([bool isError = false]) {
    widget._loginPageBloc.add(UnLoginPageEvent());
    widget._loginPageBloc.add(LoadLoginPageEvent(isError));
  }
}
