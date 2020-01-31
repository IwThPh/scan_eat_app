import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {

  final TextEditingController controller;
  final String formValidator;
  final String label;
  final IconData icon;
  final bool obscure;

  const CustomTextFormField({
    Key key,
    this.controller,
    this.formValidator,
    this.label,
    this.icon,
    this.obscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller ?? null,
      validator: (value) => formValidator ?? null,
      obscureText: obscure ?? false,
      decoration: InputDecoration(
        labelText: label ?? "Provide Label",
        icon: Icon(icon) ?? null,

      ),
    );
  }
}
