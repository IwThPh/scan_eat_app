import 'package:flutter/material.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/features/home_page/domain/entities/allergen.dart';
import 'package:scaneat/features/home_page/domain/entities/diet.dart';
import 'package:scaneat/features/home_page/domain/entities/nutrient.dart';
import 'package:scaneat/features/home_page/domain/entities/preference.dart';
import 'package:scaneat/features/scanning/domain/entities/product.dart';
import 'package:scaneat/features/scanning/presentation/widgets/product_display.dart';

class ProductPage extends StatelessWidget {
  ProductPage({
    Key key,
    @required this.product,
    @required this.preference,
    @required this.allergens,
    @required this.diets,
  }) : super(key: key);

  final List<Allergen> allergens;
  final List<Diet> diets;
  final Preference preference;
  final Product product;

  Widget alertMessage(String message, Color color) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: AppTheme.theme.textTheme.caption.apply(color: Colors.white),
      ),
    );
  }

  Widget allergenInfo() {
    var contains = allergens.where((a) => product.allergenIds.contains(a.id));
    if (contains.isEmpty)
      return alertMessage(
          'No allergen information for this product', Colours.green);
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 5,
      runSpacing: 5,
      children: <Widget>[
        for (var i in contains) alertMessage(i.name, Colours.red),
      ],
    );
  }

  Widget dietInfo() {
    var contains = diets.where((a) => product.dietIds.contains(a.id));
    if (contains.isEmpty)
      return alertMessage(
          'No dietary information for this product', Colours.green);

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 5,
      runSpacing: 5,
      children: <Widget>[
        for (var i in contains) alertMessage(i.name, Colours.green),
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flex(
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    product.name,
                    textAlign: TextAlign.left,
                    style: AppTheme.theme.textTheme.title
                        .apply(color: Colours.offBlack),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.favorite_border),
                color: Colours.primary,
                onPressed: () {},
              ),
            ],
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            children: <Widget>[
              ProductNutrient(
                name: 'Energy',
                value_100g: product.energy_100g ?? 0.0,
                per: 100,
                unit: 'Kcal',
                pref: Nutrient(
                    nutrient_1: 0,
                    nutrient_2: 0,
                    nutrient_max: preference.energy_max),
              ),
              ProductNutrient(
                name: 'Carbs',
                value_100g: product.carbohydrate_100g ?? 0.0,
                per: 100,
                pref: Nutrient(
                    nutrient_1: preference.carbohydrate_1,
                    nutrient_2: preference.carbohydrate_2,
                    nutrient_max: preference.carbohydrate_max),
              ),
              ProductNutrient(
                name: 'Protein',
                value_100g: product.protein_100g ?? 0.0,
                per: 100,
                pref: Nutrient(
                    nutrient_1: preference.protein_1,
                    nutrient_2: preference.protein_2,
                    nutrient_max: preference.protein_max),
              ),
              ProductNutrient(
                name: 'Fat',
                value_100g: product.fat_100g ?? 0.0,
                per: 100,
                pref: Nutrient(
                    nutrient_1: preference.fat_1,
                    nutrient_2: preference.fat_2,
                    nutrient_max: preference.fat_max),
              ),
              ProductNutrient(
                name: 'Saturates',
                value_100g: product.saturates_100g ?? 0.0,
                per: 100,
                pref: Nutrient(
                    nutrient_1: preference.saturated_1,
                    nutrient_2: preference.saturated_2,
                    nutrient_max: preference.saturated_max),
              ),
              ProductNutrient(
                name: 'Sugar',
                value_100g: product.sugars_100g ?? 0.0,
                per: 100,
                pref: Nutrient(
                    nutrient_1: preference.sugar_1,
                    nutrient_2: preference.sugar_2,
                    nutrient_max: preference.sugar_max),
              ),
              ProductNutrient(
                name: 'Salt',
                value_100g: product.salt_100g ?? 0.0,
                per: 100,
                pref: Nutrient(
                    nutrient_1: preference.salt_1,
                    nutrient_2: preference.salt_2,
                    nutrient_max: preference.salt_max),
              ),
              ProductNutrient(
                name: 'Fibre',
                value_100g: product.fibre_100g ?? 0.0,
                per: 100,
                pref: Nutrient(
                    nutrient_1: preference.fibre_1,
                    nutrient_2: preference.fibre_2,
                    nutrient_max: preference.fibre_max),
              ),
              ProductNutrient(
                name: 'Sodium',
                value_100g: product.sodium_100g ?? 0.0,
                per: 100,
                pref: Nutrient(
                    nutrient_1: preference.sodium_1,
                    nutrient_2: preference.sodium_2,
                    nutrient_max: preference.sodium_max),
              ),
            ],
          ),
          Container(height: 20,),
          Divider(
            color: Colours.offBlack,
            height: 2,
          ),
          Text(
            'Allergens',
            style: AppTheme.theme.textTheme.subtitle
                .apply(color: Colours.offBlack),
          ),
          allergenInfo(),
          Container(height: 10,),
          Divider(
            color: Colours.offBlack,
            height: 2,
          ),
          Text(
            'Diets',
            style: AppTheme.theme.textTheme.subtitle
                .apply(color: Colours.offBlack),
          ),
          dietInfo(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SafeArea(child: buildBody(context)),
    );
  }
}
