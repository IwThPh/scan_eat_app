import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../assets/theme/app_theme.dart';
import '../../../../assets/theme/colours.dart';
import '../../../../core/animations/SlideBottomRoute.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../di_container.dart';
import '../../../home_page/domain/entities/allergen.dart';
import '../../../home_page/domain/entities/diet.dart';
import '../../../product/domain/entities/product.dart';
import '../../../product/presentation/bloc/product/bloc.dart';
import '../../../product/presentation/pages/product_display.dart';
import '../../../product/presentation/pages/product_page.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class ScanningPageScreen extends StatefulWidget {
  const ScanningPageScreen({
    Key key,
    @required List<Allergen> allergens,
    @required List<Diet> diets,
  })  : _allergens = allergens,
        _diets = diets,
        super(key: key);

  final List<Allergen> _allergens;
  final List<Diet> _diets;

  @override
  ScanningPageScreenState createState() {
    return ScanningPageScreenState();
  }
}

class ScanningPageScreenState extends State<ScanningPageScreen> {
  ScanningPageScreenState();

  ScanningBloc _scanningPageBloc;

  @override
  void dispose() {
    _scanningPageBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _scanningPageBloc = sl<ScanningBloc>();
    this._load();
  }

  void _load() {
    _scanningPageBloc.add(UnScanningEvent());
    _scanningPageBloc.add(ScanProduct());
  }

  productPage(ProductBloc product) {
    Navigator.push(
      context,
      SlideBottomRoute(
          page: ProductPage(
        productBloc: product,
      )),
    );
  }

  Widget error(String message) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(message ?? 'Error'),
        ],
      ),
    );
  }

  Widget allergenInfo(List<Allergen> allergens, Product product) {
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

  Widget dietInfo(List<Diet> diets, Product product) {
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScanningBloc, ScanningState>(
      bloc: _scanningPageBloc,
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
        showDialog(
          context: context,
          builder: (_) => CustomDialog(
            content: Padding(
              padding: const EdgeInsets.all(16.0),
              child: BlocBuilder(
                bloc: _scanningPageBloc,
                builder: (context, state) {
                  if (state is LoadingScaningState) {
                    return Center(child: LoadingWidget());
                  }
                  if (state is LoadedScanningState) {
                    var productBloc = sl<ProductBloc>(param1: state.product);
                    return GestureDetector(
                      onTap: () => productPage(productBloc),
                      child: Column(
                        children: <Widget>[
                          ProductDisplay(
                            productBloc: productBloc,
                          ),
                          Container(
                            height: 10,
                          ),
                          allergenInfo(widget._allergens, state.product),
                          dietInfo(widget._diets, state.product),
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
}
