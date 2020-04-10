import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:scaneat/features/product/domain/entities/product.dart';
import 'package:scaneat/features/product/domain/usecases/save_product.dart';
import 'package:scaneat/features/product/domain/usecases/unsave_product.dart';
import 'package:scaneat/features/product/presentation/bloc/product/bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final SaveProduct saveProduct;
  final UnsaveProduct unsaveProduct;
  Product _product;

  ProductBloc({
    @required SaveProduct saveProduct,
    @required UnsaveProduct unsaveProduct,
    @required Product product,
  })  : assert(saveProduct != null),
        assert(unsaveProduct != null),
        assert(product != null),
        saveProduct = saveProduct,
        unsaveProduct = unsaveProduct,
        _product = product;

  @override
  ProductState get initialState => UnProductState(0, this._product);

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    try {
      yield* await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'ProductBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
