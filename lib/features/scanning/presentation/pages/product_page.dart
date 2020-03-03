import 'package:flutter/material.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
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
            alignment: WrapAlignment.spaceEvenly,
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
              ProductNutrient(
                  name: 'Saturates',
                  value_100g: product?.saturates_100g ?? 0.0,
                  weight: product?.weight_g ?? 0.0,
                  max: preference.saturated_max,
                  s1: preference.saturated_1,
                  s2: preference.saturated_2,
                  unit: 'g'),
              ProductNutrient(
                  name: 'Salt',
                  value_100g: product?.salt_100g ?? 0.0,
                  weight: product?.weight_g ?? 0.0,
                  max: preference.salt_max,
                  s1: preference.salt_1,
                  s2: preference.salt_2,
                  unit: 'g'),
              ProductNutrient(
                  name: 'Fibre',
                  value_100g: product?.fibre_100g ?? 0.0,
                  weight: product?.weight_g ?? 0.0,
                  max: preference.fibre_max,
                  s1: preference.fibre_1,
                  s2: preference.fibre_2,
                  unit: 'g'),
              ProductNutrient(
                  name: 'Sodium',
                  value_100g: product?.sodium_100g ?? 0.0,
                  weight: product?.weight_g ?? 0.0,
                  max: preference.sodium_max,
                  s1: preference.sodium_1,
                  s2: preference.sodium_2,
                  unit: 'g'),
              ProductNutrient(
                  name: 'Sugar',
                  value_100g: product?.sugars_100g ?? 0.0,
                  weight: product?.weight_g ?? 0.0,
                  max: preference.sugar_max,
                  s1: preference.sugar_1,
                  s2: preference.sugar_2,
                  unit: 'g'),
            ],
          ),
        ],
      ),
    );
  }
}
