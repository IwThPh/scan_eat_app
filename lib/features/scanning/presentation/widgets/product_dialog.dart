import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/features/scanning/presentation/pages/product_page.dart';

import '../bloc/bloc.dart';
import 'widgets.dart';

class ProductDialog extends StatelessWidget {
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
                return Column(
                  children: <Widget>[
                    Hero(
                      tag: 'product',
                      child: ProductDisplay(
                        product: state.product,
                      ),
                    ),
                    RaisedButton(
                      child: Text('View Product'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductPage(
                                      product: state.product,
                                    )));
                      },
                    ),
                  ],
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
}
