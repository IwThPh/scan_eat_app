import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_label_app/features/scanning/presentation/bloc/bloc.dart';

class ManualControls extends StatefulWidget {
  @override
  _ManualControlsState createState() => _ManualControlsState();
}

class _ManualControlsState extends State<ManualControls> {
  final controller = TextEditingController();
  String inBarcode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Input Barcode',
          ),
          onChanged: (v) {
            inBarcode = v;
          },
          onSubmitted: (_) {
            addRetrieveProduct();
          },
        ),
        SizedBox(height: 20.0,),
        RaisedButton(
          child: Text('Search'),
          onPressed: addRetrieveProduct,
        ),
      ],
    );
  }

  void addRetrieveProduct() {
    controller.clear();
    BlocProvider.of<ScanningBloc>(context).add(RetrieveProduct(inBarcode));
  }
}
