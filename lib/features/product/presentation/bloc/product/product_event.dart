import 'dart:async';
import 'dart:developer' as developer;

import 'package:scaneat/features/product/domain/usecases/save_product.dart'
    as save;
import 'package:scaneat/features/product/domain/usecases/unsave_product.dart'
    as unsave;
import 'package:scaneat/features/product/presentation/bloc/product/bloc.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ProductEvent {
  Stream<ProductState> applyAsync(
      {ProductState currentState, ProductBloc bloc});

  const ProductEvent();
}

class UnProductEvent extends ProductEvent {
  @override
  Stream<ProductState> applyAsync(
      {ProductState currentState, ProductBloc bloc}) async* {
    yield UnProductState(0, currentState.product);
  }
}

class SaveProductEvent extends ProductEvent {
  final bool isSave;
  @override
  String toString() => 'LoadProductEvent';

  SaveProductEvent(this.isSave);

  @override
  Stream<ProductState> applyAsync(
      {ProductState currentState, ProductBloc bloc}) async* {
    try {
      String barcode = currentState.product.barcode;
      final failureOrProduct = isSave
          ? await bloc.saveProduct(save.Params(barcode: barcode))
          : await bloc.unsaveProduct(unsave.Params(barcode: barcode));

      yield failureOrProduct.fold(
        (failure) =>
            ErrorProductState(1, currentState.product, failure.toString()),
        (product) => InProductState(1, product),
      );
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadProductEvent', error: _, stackTrace: stackTrace);
      yield ErrorProductState(0, currentState.product, _?.toString());
    }
  }
}
