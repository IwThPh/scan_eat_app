import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/theme/app_theme.dart';
import '../bloc/bloc.dart';

class ManualControls extends StatefulWidget {
  @override
  _ManualControlsState createState() => _ManualControlsState();
}

class _ManualControlsState extends State<ManualControls> {
  final _formKey = GlobalKey<FormState>();
  String _barcode = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline
                    .apply(color: Colours.offWhite),
                decoration: new InputDecoration(
                  icon: Icon(Icons.edit),
                  labelText: 'Barcode',
                ),
                onFieldSubmitted: (v) {
                  _retrieveProduct();
                },
                onChanged: (String v) {
                  setState(() {
                    _barcode = v;
                  });
                },
                validator: (String v) {
                  if (v.isEmpty) return 'Value Needed';
                  return null;
                },
              ),
              FlatButton(
                textTheme: ButtonTextTheme.normal,
                child: Text('Search'),
                onPressed: _retrieveProduct,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _retrieveProduct() {
    BlocProvider.of<ScanningBloc>(context).add(RetrieveProduct(_barcode));
  }
}
