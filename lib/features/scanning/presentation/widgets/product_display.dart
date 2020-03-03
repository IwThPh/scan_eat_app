import 'package:flutter/material.dart';
import 'package:scaneat/features/home_page/domain/entities/preference.dart';

import '../../../../assets/theme/app_theme.dart';
import '../../domain/entities/product.dart';

class ProductDisplay extends StatelessWidget {
  final Product product;
  final Preference preference;

  const ProductDisplay({Key key, this.product, this.preference})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      color: Colours.offWhite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            product?.name ?? "Not Defined",
            textAlign: TextAlign.center,
            style: AppTheme.theme.textTheme.headline
                .apply(color: Colours.offBlack),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ProductNutrient(
                name: 'Energy',
                value_100g: product?.energy_100g ?? 0.0,
                weight: product?.weight_g ?? 0.0,
                max: preference.energy_max,
                unit: 'Kcal',
              ),
              ProductNutrient(
                  name: 'Carbs',
                  value_100g: product?.carbohydrate_100g ?? 0.0,
                  weight: product?.weight_g ?? 0.0,
                  max: preference.carbohydrate_max,
                  s1: preference.carbohydrate_1,
                  s2: preference.carbohydrate_2,
                  unit: 'g'),
              ProductNutrient(
                  name: 'Protein',
                  value_100g: product?.protein_100g ?? 0.0,
                  weight: product?.weight_g ?? 0.0,
                  max: preference.protein_max,
                  s1: preference.protein_1,
                  s2: preference.protein_2,
                  unit: 'g'),
              ProductNutrient(
                  name: 'Fat',
                  value_100g: product?.fat_100g ?? 0.0,
                  weight: product?.weight_g ?? 0.0,
                  max: preference.fat_max,
                  s1: preference.fat_1,
                  s2: preference.fat_2,
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
  final double value_100g;
  final double weight;
  final String unit;
  final double s1;
  final double s2;
  final double max;

  const ProductNutrient({
    Key key,
    @required this.name,
    @required this.value_100g,
    @required this.weight,
    @required this.unit,
    @required this.max,
    this.s1,
    this.s2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color fg = Colours.offWhite;
    Color bg = Colours.offBlack;
    final totalValue = (value_100g / 100) * weight;
    final percentageOfMax = totalValue / max;

    if (s1 != null && s2 != null) {
      if (percentageOfMax < s1) {
        fg = Colours.green;
        bg = Colours.greenAccent;
      } else if (percentageOfMax < s2) {
        fg = Colours.orange;
        bg = Colours.orangeAccent;
      } else {
        fg = Colours.red;
        bg = Colours.redAccent;
      }
    }
    
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
                  ((value_100g / 100) * weight).round().toString().trim() +
                      unit,
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
