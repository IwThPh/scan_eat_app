import 'package:flutter/material.dart';
import 'package:food_label_app/features/scanning/domain/entities/product.dart';

class ProductDisplay extends StatelessWidget {
  final String message;
  final Product product;

  const ProductDisplay({Key key, @required this.message, this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Row(
              children: <Widget>[
                ProductNutrient(
                    name: 'Carb',
                    value: product.carbohydrate_100g,
                    weight: product.weight_g),
                ProductNutrient(
                    name: 'Protein',
                    value: product.protein_100g,
                    weight: product.weight_g),
                ProductNutrient(
                    name: 'Fat',
                    value: product.fat_100g,
                    weight: product.weight_g),
              ],
            ),
            Center(
              child: Text(
                product?.name ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductNutrient extends StatelessWidget {
  final String name;
  final double value;
  final double weight;

  const ProductNutrient({
    Key key,
    @required this.name,
    @required this.value,
    @required this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Column(
        children: <Widget>[
          Text(name),
          Text(((value / 100) * weight).round().toString().trim() + 'g'),
        ],
      ),
    );
  }
}
