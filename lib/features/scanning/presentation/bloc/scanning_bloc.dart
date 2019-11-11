import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:food_label_app/features/scanning/domain/entities/product.dart';
import 'package:food_label_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:food_label_app/features/scanning/domain/usecases/get_product.dart';
import 'package:food_label_app/features/scanning/presentation/bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

class ScanningBloc extends Bloc<ScanningEvent, ScanningState> {
  final GetProduct getProduct;

  ScanningBloc({
    @required GetProduct product,
  })  : assert(product != null),
        getProduct = product;

  @override
  ScanningState get initialState => Scanning();

  @override
  Stream<ScanningState> mapEventToState(
    ScanningEvent event,
  ) async* {
    if (event is RetrieveProduct) {
      yield Loading();
      final failureOrProduct = await getProduct(Params(barcode: event.barcode));
      // yield* _eitherFailureOrProduct(failureOrProduct);
      yield failureOrProduct.fold(
        (failure) => Error(message: "Yeet"),
        (product) => Loaded(product: product)
      );
    }
  }

  Stream<ScanningState> _eitherFailureOrProduct(
      Either<Failure, Product> failureOrProduct) async* {
    yield failureOrProduct.fold(
        (failure) => Error(message: "Yeet"),
        (product) => Loaded(product: product)
      );
  }
}
