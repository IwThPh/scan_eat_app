import 'package:flutter/material.dart';

import '../../../../assets/theme/app_theme.dart';
import '../../domain/entities/product.dart';

class ProductDisplay extends StatelessWidget {
  final Product product;

  const ProductDisplay({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: Colours.offWhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            product?.name ?? "Not Defined",
            textAlign: TextAlign.left,
            style: AppTheme.theme.textTheme.headline
                .apply(color: Colours.offBlack),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ProductNutrient(
                name: 'Energy',
                fg: Colours.offWhite,
                bg: Colours.offBlack,
                value: product?.energy_100g ?? 0.0,
                weight: product?.weight_g ?? 0.0,
                unit: 'Kcal',
              ),
              ProductNutrient(
                  name: 'Carb',
                  fg: Colours.green,
                  bg: Colours.greenAccent,
                  value: product?.carbohydrate_100g ?? 0.0,
                  weight: product?.weight_g ?? 0.0,
                  unit: 'g'),
              ProductNutrient(
                  name: 'Protein',
                  fg: Colours.orange,
                  bg: Colours.orangeAccent,
                  value: product?.protein_100g ?? 0.0,
                  weight: product?.weight_g ?? 0.0,
                  unit: 'g'),
              ProductNutrient(
                  name: 'Fat',
                  fg: Colours.red,
                  bg: Colours.redAccent,
                  value: product?.fat_100g ?? 0.0,
                  weight: product?.weight_g ?? 0.0,
                  unit: 'g'),
            ],
          ),
        ],
      ),
    );
  }
}

class ProductNutrient extends StatelessWidget {
  final String name;
  final double value;
  final double weight;
  final String unit;
  final Color fg;
  final Color bg;

  const ProductNutrient({
    Key key,
    @required this.name,
    @required this.value,
    @required this.weight,
    @required this.unit,
    @required this.fg,
    @required this.bg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle bodyText = (fg == Colours.offWhite)
        ? TextStyle(color: Colours.offBlack)
        : TextStyle(color: Colours.offWhite);

    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned.fill(
            bottom: -2,
            left: -2,
            child: Container(
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.all(Radius.circular(18.0)),
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(minWidth: 60),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            decoration: BoxDecoration(
              color: fg,
              borderRadius: BorderRadius.all(Radius.circular(18.0)),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  name,
                  style: Theme.of(context).textTheme.caption.merge(bodyText),
                ),
                Text(
                  ((value / 100) * weight).round().toString().trim() + unit,
                  style: Theme.of(context).textTheme.subhead.merge(bodyText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
