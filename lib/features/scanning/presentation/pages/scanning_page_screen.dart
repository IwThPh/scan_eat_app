import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/theme/app_theme.dart';
import '../../../../assets/theme/colours.dart';
import '../../../../core/animations/SlideBottomRoute.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../home_page/domain/entities/allergen.dart';
import '../../../home_page/domain/entities/diet.dart';
import '../../../home_page/domain/entities/preference.dart';
import '../../domain/entities/product.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';
import 'product_page.dart';

class ScanningPageScreen extends StatefulWidget {
  const ScanningPageScreen({
    Key key,
    @required ScanningBloc scanningPageBloc,
    @required Preference preference,
    @required List<Allergen> allergens,
    @required List<Diet> diets,
  })  : _scanningPageBloc = scanningPageBloc,
        _preference = preference,
        _allergens = allergens,
        _diets = diets,
        super(key: key);

  final ScanningBloc _scanningPageBloc;
  final Preference _preference;
  final List<Allergen> _allergens;
  final List<Diet> _diets;

  @override
  ScanningPageScreenState createState() {
    return ScanningPageScreenState(
        _scanningPageBloc, _preference, _allergens, _diets);
  }
}

class ScanningPageScreenState extends State<ScanningPageScreen> {
  final ScanningBloc _scanningPageBloc;
  final Preference _preference;
  final List<Allergen> _allergens;
  final List<Diet> _diets;
  ScanningPageScreenState(
      this._scanningPageBloc, this._preference, this._allergens, this._diets);

  @override
  void initState() {
    super.initState();
    this._load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //ShapeBorder fo BottomSheet
    ShapeBorder sb = RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(32.0),
      ),
    );

    return BlocConsumer<ScanningBloc, ScanningState>(
      bloc: widget._scanningPageBloc,
      listenWhen: (
        ScanningState prev,
        ScanningState next,
      ) {
        return (prev is ScanScanningState &&
            (next is LoadingScaningState || next is UserInputScanningState));
      },
      listener: (
        BuildContext context,
        ScanningState currentState,
      ) {
        showModalBottomSheet<void>(
          context: context,
          shape: sb,
          backgroundColor: Colours.primary,
          builder: (_) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder(
                bloc: _scanningPageBloc,
                builder: (context, state) {
                  if (state is LoadingScaningState) {
                    return Center(child: LoadingWidget());
                  }
                  if (state is LoadedScanningState) {
                    return GestureDetector(
                      onTap: () => productPage(state.product),
                      child: Column(
                        children: <Widget>[
                          ProductDisplay(
                            product: state.product,
                            preference: _preference,
                            allergens: _allergens,
                            diets: _diets,
                          ),
                          Container(
                            height: 10,
                          ),
                          Text(
                            'Press Product Card for more info.',
                            style: AppTheme.theme.textTheme.button
                                .apply(color: Colours.offBlack),
                          )
                        ],
                      ),
                    );
                  }
                  if (state is ErrorScanningState) {
                    return error(state.message);
                  }
                  if (state is UserInputScanningState) {
                    return ManualControls(_scanningPageBloc);
                  }
                  return Container(width: 0, height: 0);
                },
              ),
            ),
          ),
        ).whenComplete(() => _scanningPageBloc.add(ScanProduct()));
      },
      builder: (
        BuildContext context,
        ScanningState currentState,
      ) {
        if (currentState is UnScanningState) {
          return Center(
            child: LoadingWidget(),
          );
        }
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Scanner(
                    scanningBloc: _scanningPageBloc,
                  ),
                ),
                MaterialButton(
                  child: Text('Manual Input'),
                  textColor: Colours.offWhite,
                  onPressed: () => _scanningPageBloc.add(ManualInput()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _load() {
    widget._scanningPageBloc.add(UnScanningEvent());
    widget._scanningPageBloc.add(ScanProduct());
  }

//TODO: This may need to be externalised into its own [ScanningEvent].
  productPage(Product product) {
    developer.log("Product Card Pressed.");
    Navigator.push(
      context,
      SlideBottomRoute(
          page: ProductPage(
        product: product,
        preference: _preference,
      )),
    );
  }

  Widget error(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(message ?? 'Error'),
          Container(
            height: 50,
          )
        ],
      ),
    );
  }
}
