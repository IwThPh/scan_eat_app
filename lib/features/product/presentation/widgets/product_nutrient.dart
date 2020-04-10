import 'package:flutter/material.dart';
import 'package:scaneat/assets/theme/colours.dart';
import 'package:scaneat/features/home_page/domain/entities/nutrient.dart';

class ProductNutrient extends StatelessWidget {
  const ProductNutrient({
    Key key,
    @required this.name,
    @required this.value_100g,
    @required this.per,
    this.unit = 'g',
    @required this.pref,
  }) : super(key: key);

  final String name;
  final double per;
  final Nutrient pref;
  final String unit;
  final double value_100g;

  @override
  Widget build(BuildContext context) {
    Color fg = Colours.offWhite;
    Color bg = Colours.offBlack;
    final totalValue = (value_100g / 100) * per;
    final percentageOfMax = totalValue / pref.nutrient_max;

    if (unit == 'g') {
      if (percentageOfMax < pref.nutrient_1) {
        fg = Colours.green;
        bg = Colours.greenAccent;
      } else if (percentageOfMax < pref.nutrient_2) {
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
      child: Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned.fill(
            bottom: -3,
            left: -3,
            child: Container(
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.all(Radius.circular(18.0)),
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(minWidth: 40),
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 2.0),
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
                  ((value_100g / 100) * per).round().toString().trim() + unit,
                  style: Theme.of(context).textTheme.body2.merge(bodyText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}