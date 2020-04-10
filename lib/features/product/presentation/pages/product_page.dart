import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/assets/theme/colours.dart';
import 'package:scaneat/di_container.dart';
import 'package:scaneat/features/home_page/domain/entities/allergen.dart';
import 'package:scaneat/features/home_page/domain/entities/diet.dart';
import 'package:scaneat/features/home_page/domain/entities/nutrient.dart';
import 'package:scaneat/features/home_page/domain/entities/preference.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/allergen/bloc.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/diet/bloc.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/diet/diet_bloc.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/preference/bloc.dart';
import 'package:scaneat/features/product/domain/entities/product.dart';
import 'package:scaneat/features/product/presentation/bloc/product/bloc.dart';
import 'package:scaneat/features/product/presentation/widgets/widgets.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({
    Key key,
    @required ProductBloc productBloc,
  })  : _productBloc = productBloc,
        super(key: key);

  final ProductBloc _productBloc;

  @override
  ProductPageState createState() {
    return ProductPageState();
  }
}

class ProductPageState extends State<ProductPage> {
  ProductPageState();

  Preference preference;
  List<Allergen> allergens;
  List<Diet> diets;

  @override
  void initState() {
    this._loadPref();
    this._loadAllergens();
    this._loadDiets();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _loadPref() {
    var bloc = sl<PreferenceBloc>();
    var state = bloc.state;
    if (state is InPreferenceState) {
      preference = state.preference;
    } else {
      bloc.add(LoadPreferenceEvent());
    }
  }

  void _loadAllergens() {
    var bloc = sl<AllergenBloc>();
    var state = bloc.state;
    if (state is InAllergenState) {
      allergens = state.allergens;
    } else {
      bloc.add(LoadAllergenEvent());
    }
  }

  void _loadDiets() {
    var bloc = sl<DietBloc>();
    var state = bloc.state;
    if (state is InDietState) {
      diets = state.diets;
    } else {
      bloc.add(LoadDietEvent());
    }
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
        textAlign: TextAlign.center,
        style: AppTheme.theme.textTheme.caption.apply(color: Colors.white),
      ),
    );
  }

  Widget allergenInfo(Product product) {
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

  Widget dietInfo(Product product) {
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
    return BlocBuilder(
      bloc: widget._productBloc,
      builder: (context, state) {
        if (state is ErrorProductState) {
          return LoadingWidget();
        }
        return Container(
          margin: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ProductTitle(productBloc: widget._productBloc),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: <Widget>[
                  ProductNutrient(
                    name: 'Energy',
                    value_100g: state.product.energy_100g ?? 0.0,
                    per: 100,
                    unit: 'Kcal',
                    pref: Nutrient(
                        nutrient_1: 0,
                        nutrient_2: 0,
                        nutrient_max: preference.energy_max),
                  ),
                  ProductNutrient(
                    name: 'Carbs',
                    value_100g: state.product.carbohydrate_100g ?? 0.0,
                    per: 100,
                    pref: Nutrient(
                        nutrient_1: preference.carbohydrate_1,
                        nutrient_2: preference.carbohydrate_2,
                        nutrient_max: preference.carbohydrate_max),
                  ),
                  ProductNutrient(
                    name: 'Protein',
                    value_100g: state.product.protein_100g ?? 0.0,
                    per: 100,
                    pref: Nutrient(
                        nutrient_1: preference.protein_1,
                        nutrient_2: preference.protein_2,
                        nutrient_max: preference.protein_max),
                  ),
                  ProductNutrient(
                    name: 'Fat',
                    value_100g: state.product.fat_100g ?? 0.0,
                    per: 100,
                    pref: Nutrient(
                        nutrient_1: preference.fat_1,
                        nutrient_2: preference.fat_2,
                        nutrient_max: preference.fat_max),
                  ),
                  ProductNutrient(
                    name: 'Saturates',
                    value_100g: state.product.saturates_100g ?? 0.0,
                    per: 100,
                    pref: Nutrient(
                        nutrient_1: preference.saturated_1,
                        nutrient_2: preference.saturated_2,
                        nutrient_max: preference.saturated_max),
                  ),
                  ProductNutrient(
                    name: 'Sugar',
                    value_100g: state.product.sugars_100g ?? 0.0,
                    per: 100,
                    pref: Nutrient(
                        nutrient_1: preference.sugar_1,
                        nutrient_2: preference.sugar_2,
                        nutrient_max: preference.sugar_max),
                  ),
                  ProductNutrient(
                    name: 'Salt',
                    value_100g: state.product.salt_100g ?? 0.0,
                    per: 100,
                    pref: Nutrient(
                        nutrient_1: preference.salt_1,
                        nutrient_2: preference.salt_2,
                        nutrient_max: preference.salt_max),
                  ),
                  ProductNutrient(
                    name: 'Fibre',
                    value_100g: state.product.fibre_100g ?? 0.0,
                    per: 100,
                    pref: Nutrient(
                        nutrient_1: preference.fibre_1,
                        nutrient_2: preference.fibre_2,
                        nutrient_max: preference.fibre_max),
                  ),
                  ProductNutrient(
                    name: 'Sodium',
                    value_100g: state.product.sodium_100g ?? 0.0,
                    per: 100,
                    pref: Nutrient(
                        nutrient_1: preference.sodium_1,
                        nutrient_2: preference.sodium_2,
                        nutrient_max: preference.sodium_max),
                  ),
                ],
              ),
              Container(
                height: 20,
              ),
              Divider(
                color: Colours.offBlack,
                height: 2,
              ),
              Text(
                'Allergens',
                style: AppTheme.theme.textTheme.subtitle
                    .apply(color: Colours.offBlack),
              ),
              allergenInfo(state.product),
              Container(
                height: 10,
              ),
              Divider(
                color: Colours.offBlack,
                height: 2,
              ),
              Text(
                'Diets',
                style: AppTheme.theme.textTheme.subtitle
                    .apply(color: Colours.offBlack),
              ),
              dietInfo(state.product),
            ],
          ),
        );
      },
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
