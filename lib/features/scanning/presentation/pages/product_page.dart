import 'package:flutter/material.dart';
import 'package:scaneat/features/scanning/domain/entities/product.dart';
import 'package:scaneat/features/scanning/presentation/widgets/product_display.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  ProductPage({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: buildBody(context)),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'product',
            child: ProductDisplay(product: product),
          ),
        ],
      ),
    );
  }
}
