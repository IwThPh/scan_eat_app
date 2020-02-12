import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:scaneat/assets/theme/colours.dart';
import 'package:scaneat/features/login/presentation/bloc/bloc.dart';

import '../widgets/widgets.dart';

class LoginForm extends StatefulWidget {
  final LoginPageBloc _bloc;

  LoginForm(this._bloc);

  @override
  _LoginFormState createState() => _LoginFormState(_bloc);
}

class _LoginFormState extends State<LoginForm> {
  final LoginPageBloc _bloc;
  _LoginFormState(this._bloc);

  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //ShapeBorder for button
    ShapeBorder bb = RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.elliptical(MediaQuery.of(context).size.width + 46, 80),
      ),
    );

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CustomTextFormField(
            controller: emailController,
            label: "Email",
            icon: Icons.email,
            formValidator: (value) {
              if(value.isEmpty) return "Please enter your email address";
              if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) return "Email must be valid";
              return null;
            },
          ),
          CustomTextFormField(
            controller: passController,
            label: "Password",
            icon: Icons.lock,
            obscure: true,
            formValidator: (value) => value.isEmpty ? "Please enter your password" : null,
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: MaterialButton(
              shape: bb,
              color: Colours.green,
              textColor: Colours.offWhite,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _submit();
                }
              },
              child: Text('Login'),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    widget._bloc.add(UnLoginPageEvent());
    widget._bloc.add(
      SendLoginPageEvent(
        emailController.value.text,
        passController.value.text,
      ),
    );
    passController.clear();
  }
}
