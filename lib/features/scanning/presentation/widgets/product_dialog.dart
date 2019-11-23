import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bloc.dart';
import 'widgets.dart';

class ProductDialog extends StatefulWidget {
  @override
  _ProductDialogState createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BlocBuilder<ScanningBloc, ScanningState>(
            builder: (context, state) {
              if (state is Loading) {
                return LoadingWidget();
              }
              if (state is Loaded) {
                return ProductDisplay(
                  product: state.product,
                );
              }
              if (state is UserInput) {
                return ManualControls();
              }
              if (state is Error) {
                return Text('Could Not Find Product');
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }

  void returnScanning() {
    BlocProvider.of<ScanningBloc>(context).add(ScanProduct());
    Navigator.pop(context);
  }
}
