import 'package:flutter/material.dart';

import '../../../../assets/theme/app_theme.dart';
import '../bloc/bloc.dart';

class ManualControls extends StatefulWidget {
  const ManualControls(
    ScanningBloc scanningBloc, {
    Key key,
  })  : scanningBloc = scanningBloc,
        super(key: key);

  final ScanningBloc scanningBloc;

  @override
  _ManualControlsState createState() => _ManualControlsState();
}

class _ManualControlsState extends State<ManualControls> {
  String _barcode = "";

  void _retrieveProduct() {
    this.widget.scanningBloc.add(LoadingScanningEvent());
    this.widget.scanningBloc.add(RetrieveProduct(_barcode));
  }

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
              cursorColor: Colours.offBlack,
              style: Theme.of(context).textTheme.headline.apply(
                    color: Colours.offBlack,
                  ),
              decoration: new InputDecoration(
                icon: Icon(Icons.edit),
                labelText: 'Barcode',
                focusColor: Colours.offBlack ,
                border: UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: Colours.primaryAccent,
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
}
