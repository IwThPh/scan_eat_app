import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/core/animations/SlideBottomRoute.dart';
import 'package:scaneat/di_container.dart';
import 'package:scaneat/features/home_page/domain/entities/preference.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/preference/bloc.dart';
import 'package:scaneat/features/product/presentation/bloc/product/bloc.dart';
import 'package:scaneat/features/product/presentation/pages/product_page.dart';
import 'package:scaneat/features/product/presentation/widgets/widgets.dart';

import '../../../../assets/theme/app_theme.dart';
import '../../../home_page/domain/entities/nutrient.dart';

class ProductDisplay extends StatefulWidget {
  const ProductDisplay({
    Key key,
    this.productBloc,
  }) : super(key: key);

  final ProductBloc productBloc;

  @override
  _ProductDisplayState createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {
  Preference preference;

  @override
  void initState() {
    var prefBloc = sl<PreferenceBloc>();
    var state = prefBloc.state;
    if (state is InPreferenceState) {
      preference = state.preference;
    } else {
      prefBloc.add(LoadPreferenceEvent());
      prefBloc.listen((onData) {
        if (onData is InPreferenceState) preference = onData.preference;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: widget.productBloc,
      builder: (context, state) {
        if (state is ErrorProductState) {
          return LoadingWidget();
        }
        return Container(
          padding: EdgeInsets.all(4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ProductTitle(productBloc: widget.productBloc),
              Divider(
                color: Colours.offBlack,
                height: 2,
              ),
              Text(
                'Information per 100 g',
                style: AppTheme.theme.textTheme.caption,
                textAlign: TextAlign.center,
              ),
              GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  SlideBottomRoute(
                      page: ProductPage(
                    productBloc: widget.productBloc,
                  )),
                ),
                child: Padding(
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
                        value_100g: state.product.energy_100g,
                        per: 100,
                        unit: 'Kcal',
                        pref: Nutrient(
                            nutrient_1: 0,
                            nutrient_2: 0,
                            nutrientMax: preference.energyMax),
                      ),
                      ProductNutrient(
                        name: 'Fat',
                        value_100g: state.product.fat_100g,
                        per: 100,
                        pref: Nutrient(
                            nutrient_1: preference.fat_1,
                            nutrient_2: preference.fat_2,
                            nutrientMax: preference.fatMax),
                      ),
                      ProductNutrient(
                        name: 'Saturates',
                        value_100g: state.product.saturates_100g,
                        per: 100,
                        pref: Nutrient(
                            nutrient_1: preference.saturated_1,
                            nutrient_2: preference.saturated_2,
                            nutrientMax: preference.saturatedMax),
                      ),
                      ProductNutrient(
                        name: 'Sugar',
                        value_100g: state.product.sugars_100g,
                        per: 100,
                        pref: Nutrient(
                            nutrient_1: preference.sugar_1,
                            nutrient_2: preference.sugar_2,
                            nutrientMax: preference.sugarMax),
                      ),
                      ProductNutrient(
                        name: 'Salt',
                        value_100g: state.product.salt_100g,
                        per: 100,
                        pref: Nutrient(
                            nutrient_1: preference.salt_1,
                            nutrient_2: preference.salt_2,
                            nutrientMax: preference.saltMax),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
