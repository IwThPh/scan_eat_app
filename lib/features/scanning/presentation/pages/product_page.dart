import 'package:flutter/material.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/features/home_page/domain/entities/nutrient.dart';
import 'package:scaneat/features/home_page/domain/entities/preference.dart';
import 'package:scaneat/features/scanning/domain/entities/product.dart';
import 'package:scaneat/features/scanning/presentation/widgets/product_display.dart';

class ProductPage extends StatelessWidget {
  final Product product;
  final Preference preference;
  ProductPage({
    Key key,
    @required this.product,
    @required this.preference,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SafeArea(child: buildBody(context)),
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            product?.name ?? "Not Defined",
            textAlign: TextAlign.center,
            style: AppTheme.theme.textTheme.headline
                .apply(color: Colours.offBlack),
          ),
          Wrap(
            alignment: WrapAlignment.start,
            runAlignment: WrapAlignment.center,
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
                  name: 'Carbs',
                  value_100g: product.carbohydrate_100g,
                  per: 100,
                  pref: Nutrient(
                      nutrient_1: preference.carbohydrate_1,
                      nutrient_2: preference.carbohydrate_2,
                      nutrient_max: preference.carbohydrate_max),
                ),
                ProductNutrient(
                  name: 'Protein',
                  value_100g: product.protein_100g,
                  per: 100,
                  pref: Nutrient(
                      nutrient_1: preference.protein_1,
                      nutrient_2: preference.protein_2,
                      nutrient_max: preference.protein_max),
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
                ProductNutrient(
                  name: 'Fibre',
                  value_100g: product.fibre_100g,
                  per: 100,
                  pref: Nutrient(
                      nutrient_1: preference.fibre_1,
                      nutrient_2: preference.fibre_2,
                      nutrient_max: preference.fibre_max),
                ),
                ProductNutrient(
                  name: 'Sodium',
                  value_100g: product.sodium_100g,
                  per: 100,
                  pref: Nutrient(
                      nutrient_1: preference.sodium_1,
                      nutrient_2: preference.sodium_2,
                      nutrient_max: preference.sodium_max),
                ),
            ],
          ),
          Row(
            children: <Widget>[
              Text('Allergen Ids'),
              for (var i in product.allergenIds) Text(i.toString()),
            ],
          ),
          Row(
            children: <Widget>[
              Text('Diet Ids'),
              for (var i in product.dietIds) Text(i.toString()),
            ],
          ),
        ],
      ),
    );
  }
}
