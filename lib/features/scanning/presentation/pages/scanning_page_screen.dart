import 'package:flutter/material.dart';
import 'dart:developer' as developer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scaneat/assets/theme/app_theme.dart';
import 'package:scaneat/assets/theme/colours.dart';
import 'package:scaneat/core/animations/SlideBottomRoute.dart';
import 'package:scaneat/core/widgets/loading_widget.dart';
import 'package:scaneat/features/home_page/domain/entities/preference.dart';
import 'package:scaneat/features/scanning/domain/entities/product.dart';
import 'package:scaneat/features/scanning/presentation/bloc/bloc.dart';
import 'package:scaneat/features/scanning/presentation/pages/product_page.dart';
import 'package:scaneat/features/scanning/presentation/widgets/widgets.dart';

class ScanningPageScreen extends StatefulWidget {
  const ScanningPageScreen({
    Key key,
    @required ScanningBloc scanningPageBloc,
    @required Preference preference,
  })  : _scanningPageBloc = scanningPageBloc,
        _preference = preference,
        super(key: key);

  final ScanningBloc _scanningPageBloc;
  final Preference _preference;

  @override
  ScanningPageScreenState createState() {
    return ScanningPageScreenState(_scanningPageBloc, _preference);
  }
}

class ScanningPageScreenState extends State<ScanningPageScreen> {
  final ScanningBloc _scanningPageBloc;
  final Preference _preference;
  ScanningPageScreenState(this._scanningPageBloc, this._preference);

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
