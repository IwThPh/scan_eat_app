import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';
import 'package:scaneat/features/home_page/domain/entities/allergen.dart';
import 'package:scaneat/features/home_page/domain/entities/diet.dart';
import 'package:scaneat/features/home_page/domain/entities/nutrient.dart';

import '../../../../assets/theme/app_theme.dart';
import '../../../home_page/domain/entities/preference.dart';
import '../../domain/entities/product.dart';

class ProductDisplay extends StatelessWidget {
  final Product product;
  final Preference preference;
  final List<Allergen> allergens;
  final List<Diet> diets;

  const ProductDisplay({
    Key key,
    this.product,
    this.preference,
    this.allergens,
    this.diets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colours.offWhite,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                product?.name ?? "Not Defined",
                textAlign: TextAlign.center,
                style: AppTheme.theme.textTheme.title
                    .apply(color: Colours.offBlack),
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                color: Colours.green,
                onPressed: () {},
              ),
            ],
          ),
          Divider(
            color: Colours.offBlack,
            height: 2,
          ),
          Text(
            'per 100g',
            textAlign: TextAlign.center,
            style: AppTheme.theme.textTheme.subtitle
                .apply(color: Colours.offBlack),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceEvenly,
              spacing: 5,
              runSpacing: 8,
              runAlignment: WrapAlignment.spaceEvenly,
              children: <Widget>[
                ProductNutrient(
                  name: 'Energy',
                  value_100g: product.energy_100g,
                  per: 100,
                  unit: 'Kcal',
                  pref: Nutrient(
                      nutrient_1: 0,
                      nutrient_2: 0,
                      nutrient_max: preference.energy_max),
                ),
                ProductNutrient(
                  name: 'Fat',
                  value_100g: product.fat_100g,
                  per: 100,
                  pref: Nutrient(
                      nutrient_1: preference.fat_1,
                      nutrient_2: preference.fat_2,
                      nutrient_max: preference.fat_max),
                ),
                ProductNutrient(
                  name: 'Saturates',
                  value_100g: product.saturates_100g,
                  per: 100,
                  pref: Nutrient(
                      nutrient_1: preference.saturated_1,
                      nutrient_2: preference.saturated_2,
                      nutrient_max: preference.saturated_max),
                ),
                ProductNutrient(
                  name: 'Sugar',
                  value_100g: product.sugars_100g,
                  per: 100,
                  pref: Nutrient(
                      nutrient_1: preference.sugar_1,
                      nutrient_2: preference.sugar_2,
                      nutrient_max: preference.sugar_max),
                ),
                ProductNutrient(
                  name: 'Salt',
                  value_100g: product.salt_100g,
                  per: 100,
                  pref: Nutrient(
                      nutrient_1: preference.salt_1,
                      nutrient_2: preference.salt_2,
                      nutrient_max: preference.salt_max),
                ),
              ],
            ),
          ),
          Divider(
            color: Colours.offBlack,
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Wrap(
              runSpacing: 5,
              spacing: 5,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: <Widget>[
                allergenInfo(),
                dietInfo(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget allergenInfo() {
    var selected = allergens.where((a) => a.selected);
    if (selected.isEmpty) return Container(width: 0, height: 0);
    var contains = selected.where((a) => product.allergenIds.contains(a.id));
    if (contains.isEmpty)
      return alertMessage(
          'No information on selected Allergens', Colours.orange);
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 5,
      children: <Widget>[
        for (var i in contains) alertMessage('Contains ' + i.name, Colours.red),
      ],
    );
  }

  Widget dietInfo() {
    var selected = diets.where((a) => a.selected);
    if (selected.isEmpty) return Container(width: 0, height: 0);
    var contains = selected.where((a) => product.dietIds.contains(a.id));
    if (contains.isEmpty)
      return alertMessage('No Dietary Information Found', Colours.orange);

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 5,
      children: <Widget>[
        for (var i in contains) alertMessage(i.name, Colours.green),
      ],
    );
  }

  Widget alertMessage(String message, Color color) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        message,
        style: AppTheme.theme.textTheme.caption.apply(color: Colors.white),
      ),
    );
  }
}

class ProductNutrient extends StatelessWidget {
  final String name;
  final double value_100g;
  final double per;
  final String unit;
  final Nutrient pref;

  const ProductNutrient({
    Key key,
    @required this.name,
    @required this.value_100g,
    @required this.per,
    this.unit = 'g',
    @required this.pref,
  }) : super(key: key);

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
                  style: Theme.of(context).textTheme.body1.merge(bodyText),
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
