import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/assets/theme/colours.dart';
import 'package:scaneat/core/widgets/custom_appbar.dart';
import 'package:scaneat/di_container.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/history/bloc.dart';
import 'package:scaneat/features/home_page/presentation/widgets/widgets.dart';
import 'package:scaneat/features/product/domain/entities/product.dart';
import 'package:scaneat/features/product/presentation/bloc/product/bloc.dart';
import 'package:scaneat/features/product/presentation/pages/product_display.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  HistoryBloc bloc;

  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
    bloc = sl<HistoryBloc>();
    _load();
  }

  void _load() {
    bloc.add(LoadHistoryEvent());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: Text('Your Scan History',
            style:
                AppTheme.theme.textTheme.title.apply(color: Colours.offBlack)),
      ),
      body: BlocConsumer(
        bloc: bloc,
        listener: (context, state) {
          if (state is InHistoryState) {
            _refreshCompleter?.complete();
            _refreshCompleter = Completer();
          }
        },
        builder: (context, state) {
          if (state is InHistoryState) {
            return RefreshIndicator(
              onRefresh: () {
                bloc.add(LoadHistoryEvent());
                return _refreshCompleter.future;
              },
              child: ListView.separated(
                padding: EdgeInsets.all(8.0),
                itemCount: state.products.length,
                separatorBuilder: (context, index) {
                  return Divider(
                    color: Colours.offBlack,
                    height: 10,
                    thickness: 2,
                  );
                },
                itemBuilder: (context, index) {
                  var p = state.products[index];
                  Product product = Product(
                    barcode: p.barcode,
                    name: p.name,
                    allergenIds: p.allergenIds,
                    dietIds: p.dietIds,
                    weightG: p.weightG,
                    servingG: p.servingG,
                    energy_100g: p.energy_100g,
                    carbohydrate_100g: p.carbohydrate_100g,
                    protein_100g: p.protein_100g,
                    fat_100g: p.fat_100g,
                    fibre_100g: p.fibre_100g,
                    salt_100g: p.salt_100g,
                    sugars_100g: p.sugars_100g,
                    saturates_100g: p.saturates_100g,
                    sodium_100g: p.sodium_100g,
                    saved: p.saved,
                  );
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ProductDisplay(
                        productBloc: sl<ProductBloc>(param1: product)),
                  );
                },
              ),
            );
          }
          if (state is ErrorHistoryState) {
            return Text(state.errorMessage);
          }
          return Center(
              child: LoadingWidget(
            message: 'Loading Your Scanned Products',
          ));
        },
      ),
    );
  }
}
