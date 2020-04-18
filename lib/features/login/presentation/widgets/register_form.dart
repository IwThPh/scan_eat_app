import 'package:flutter/material.dart';
import 'package:scaneat/assets/theme/colours.dart';
import 'package:scaneat/features/login/domain/entities/validator.dart';
import 'package:scaneat/features/login/presentation/bloc/bloc.dart';

import '../widgets/widgets.dart';

class RegisterForm extends StatefulWidget {
  final LoginPageBloc _bloc;
  final Validator _errors;

  RegisterForm(this._bloc, [this._errors]);

  @override
  _RegisterFormState createState() => _RegisterFormState(_errors);
}

class _RegisterFormState extends State<RegisterForm> {
  final Validator _errors;
  _RegisterFormState([this._errors]);

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final cPassController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    cPassController.dispose();
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
            controller: nameController,
            label: "Name",
            error: _errors?.nameError,
            icon: Icons.person,
            formValidator: (value) => value.isEmpty ? "Please enter your name" : null,
          ),
          CustomTextFormField(
            controller: emailController,
            label: "Email",
            error: _errors?.emailError,
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
            error: _errors?.passwordError,
            icon: Icons.lock,
            obscure: true,
            formValidator: (value) => value.isEmpty ? "Please enter a password" : null,
          ),
          CustomTextFormField(
            controller: cPassController,
            label: "Confirm Password",
            icon: Icons.lock,
            obscure: true,
            formValidator: (value) => value.isEmpty ? "Please enter a password" : null,
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
                  _register();
                }
              },
              child: Text('Register'),
            ),
          ),
        ],
      ),
    );
  }

  void _register() {
    widget._bloc.add(UnLoginPageEvent());
    widget._bloc.add(
      RegLoginPageEvent(
        nameController.value.text,
        emailController.value.text,
        passController.value.text,
        cPassController.value.text,
      ),
    );
    passController.clear();
    cPassController.clear();
  }
}
