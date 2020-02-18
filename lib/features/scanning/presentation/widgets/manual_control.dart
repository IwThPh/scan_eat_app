import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/theme/app_theme.dart';
import '../bloc/bloc.dart';

class ManualControls extends StatefulWidget {
  final ScanningBloc scanningBloc;

  const ManualControls(
    ScanningBloc scanningBloc, {
    Key key,
  })  : scanningBloc = scanningBloc,
        super(key: key);

  @override
  _ManualControlsState createState() => _ManualControlsState();
}

class _ManualControlsState extends State<ManualControls> {
  String _barcode = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Column(
          children: <Widget>[
            TextFormField(
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              cursorColor: Colours.offWhite,
              style: Theme.of(context).textTheme.headline.apply(
                    color: Colours.offWhite,
                  ),
              decoration: new InputDecoration(
                icon: Icon(Icons.edit),
                labelText: 'Barcode',
                focusColor: Colours.offWhite,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: Colours.offWhite,
                  ),
                ),
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
    );
  }

  void _retrieveProduct() {
    this.widget.scanningBloc.add(LoadingScanningEvent());
    this.widget.scanningBloc.add(RetrieveProduct(_barcode));
  }
}
