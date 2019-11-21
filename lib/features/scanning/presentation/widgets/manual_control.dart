import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/features/scanning/presentation/bloc/bloc.dart';

class ManualControls extends StatefulWidget {
  @override
  _ManualControlsState createState() => _ManualControlsState();
}

class _ManualControlsState extends State<ManualControls> {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textTheme: ButtonTextTheme.normal,
      child: Text('Manual Input'),
      onPressed: setManualInput,
    );
  }

  void setManualInput() {
    BlocProvider.of<ScanningBloc>(context).add(ManualInput());
  }
}
