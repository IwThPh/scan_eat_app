import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/assets/theme/colours.dart';
import 'package:scaneat/core/widgets/custom_appbar.dart';
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

  List<Allergen> allergens;
  List<Diet> diets;
  Preference preference;

  PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.85,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    this._loadPref();
    this._loadAllergens();
    this._loadDiets();
    super.initState();
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

  Widget nutrientsPer(Product product, double per) {
    return Column(
      children: <Widget>[
        Text(
          'Information per $per g',
          style: AppTheme.theme.textTheme.caption,
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
              per: per,
              unit: 'Kcal',
              pref: Nutrient(
                  nutrient_1: 0,
                  nutrient_2: 0,
                  nutrientMax: preference.energyMax),
            ),
            ProductNutrient(
              name: 'Carbs',
              value_100g: product.carbohydrate_100g ?? 0.0,
              per: per,
              pref: Nutrient(
                  nutrient_1: preference.carbohydrate_1,
                  nutrient_2: preference.carbohydrate_2,
                  nutrientMax: preference.carbohydrateMax),
            ),
            ProductNutrient(
              name: 'Protein',
              value_100g: product.protein_100g ?? 0.0,
              per: per,
              pref: Nutrient(
                  nutrient_1: preference.protein_1,
                  nutrient_2: preference.protein_2,
                  nutrientMax: preference.proteinMax),
            ),
            ProductNutrient(
              name: 'Fat',
              value_100g: product.fat_100g ?? 0.0,
              per: per,
              pref: Nutrient(
                  nutrient_1: preference.fat_1,
                  nutrient_2: preference.fat_2,
                  nutrientMax: preference.fatMax),
            ),
            ProductNutrient(
              name: 'Saturates',
              value_100g: product.saturates_100g ?? 0.0,
              per: per,
              pref: Nutrient(
                  nutrient_1: preference.saturated_1,
                  nutrient_2: preference.saturated_2,
                  nutrientMax: preference.saturatedMax),
            ),
            ProductNutrient(
              name: 'Sugar',
              value_100g: product.sugars_100g ?? 0.0,
              per: per,
              pref: Nutrient(
                  nutrient_1: preference.sugar_1,
                  nutrient_2: preference.sugar_2,
                  nutrientMax: preference.sugarMax),
            ),
            ProductNutrient(
              name: 'Salt',
              value_100g: product.salt_100g ?? 0.0,
              per: per,
              pref: Nutrient(
                  nutrient_1: preference.salt_1,
                  nutrient_2: preference.salt_2,
                  nutrientMax: preference.saltMax),
            ),
            ProductNutrient(
              name: 'Fibre',
              value_100g: product.fibre_100g ?? 0.0,
              per: per,
              pref: Nutrient(
                  nutrient_1: preference.fibre_1,
                  nutrient_2: preference.fibre_2,
                  nutrientMax: preference.fibreMax),
            ),
            ProductNutrient(
              name: 'Sodium',
              value_100g: product.sodium_100g ?? 0.0,
              per: per,
              pref: Nutrient(
                  nutrient_1: preference.sodium_1,
                  nutrient_2: preference.sodium_2,
                  nutrientMax: preference.sodiumMax),
            ),
          ],
        ),
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
        return SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ProductTitle(productBloc: widget._productBloc),
                ),
                Container(
                  height: 200,
                  child: PageView(
                    scrollDirection: Axis.horizontal,
                    controller: _pageController,
                    children: <Widget>[
                      nutrientsPer(state.product, 100),
                      if (state.product.servingG != 100)
                        nutrientsPer(state.product, state.product.servingG),
                      if (state.product.weightG != 100)
                        nutrientsPer(state.product, state.product.weightG),
                    ],
                  ),
                ),
                Divider(
                  color: Colours.offBlack,
                  height: 2,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Allergens',
                      style: AppTheme.theme.textTheme.subtitle
                          .apply(color: Colours.offBlack),
                    ),
                    allergenInfo(state.product),
                  ],
                ),
                Divider(
                  color: Colours.offBlack,
                  height: 2,
                ),
                Column(
                  children: <Widget>[
                    Text(
                      'Diets',
                      style: AppTheme.theme.textTheme.subtitle
                          .apply(color: Colours.offBlack),
                    ),
                    dietInfo(state.product),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: Text(
          'Product Details',
          style: AppTheme.theme.textTheme.title.apply(color: Colours.offBlack),
        ),
      ),
      body: SafeArea(child: buildBody(context)),
    );
  }
}
