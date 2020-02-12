import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scaneat/assets/theme/colours.dart';

class CustomTextFormField extends StatelessWidget {

  final TextEditingController controller;
  final Function formValidator;
  final String label;
  final String error;
  final IconData icon;
  final bool obscure;

  const CustomTextFormField({
    Key key,
    this.controller,
    this.formValidator,
    this.label,
    this.error,
    this.icon,
    this.obscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller ?? null,
      validator: formValidator,
      obscureText: obscure ?? false,
      style: Theme.of(context).textTheme.body2.apply(
          color: Colours.offBlack,
        ),
      decoration: InputDecoration(
        focusColor: Colours.green,
        labelStyle: Theme.of(context).textTheme.body2.apply(
          color: Colours.offBlack,
          decorationColor: Colours.green,
        ),
        fillColor: Colours.green,
        hoverColor: Colours.green,
        labelText: label ?? "Provide Label",
        errorText: ([0,null,"",false].contains(error)) ? null : error,
        errorMaxLines: 2,
        icon: Icon(icon, color: Colours.offBlack,) ?? null,
        contentPadding: EdgeInsets.all(10)
      ),
    );
  }
}
