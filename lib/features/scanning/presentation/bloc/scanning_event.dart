import 'package:equatable/equatable.dart';
import 'package:scaneat/features/product/domain/entities/product.dart';
import 'dart:developer' as developer;
import 'package:scaneat/features/scanning/domain/usecases/get_product.dart';
import 'package:scaneat/features/scanning/presentation/bloc/bloc.dart';

abstract class ScanningEvent extends Equatable {
  Future<ScanningState> applyAsync(
      {ScanningState currentState, ScanningBloc bloc});

  const ScanningEvent();
}

class UnScanningEvent extends ScanningEvent {
  @override
  Future<ScanningState> applyAsync(
      {ScanningState currentState, ScanningBloc bloc}) async {
    return UnScanningState(0);
  }

  @override
  List<Object> get props => [];
}

class LoadingScanningEvent extends ScanningEvent {
  @override
  Future<ScanningState> applyAsync(
      {ScanningState currentState, ScanningBloc bloc}) async {
    return LoadingScaningState(1);
  }

  @override
  List<Object> get props => [];
}

class RetrieveProduct extends ScanningEvent {
  final String barcode;

  RetrieveProduct(this.barcode);

  @override
  List<Object> get props => null;

  @override
  Future<ScanningState> applyAsync(
      {ScanningState currentState, ScanningBloc bloc}) async {
    try {
      final failureOrProduct = await bloc.getProduct(Params(barcode: barcode));

      return failureOrProduct.fold(
        (f) => ErrorScanningState(1, "No Information Found"),
        (p) {
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
          return LoadedScanningState(1, product: product);
        },
      );
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadTestEvent', error: _, stackTrace: stackTrace);
      return ErrorScanningState(0, _?.toString());
    }
  }
}

class ScanProduct extends ScanningEvent {
  ScanProduct();
  @override
  List<Object> get props => null;

  @override
  Future<ScanningState> applyAsync(
      {ScanningState currentState, ScanningBloc bloc}) async {
    return ScanScanningState(1);
  }
}

class ManualInput extends ScanningEvent {
  ManualInput();
  @override
  List<Object> get props => null;

  @override
  Future<ScanningState> applyAsync(
      {ScanningState currentState, ScanningBloc bloc}) async {
    return UserInputScanningState(1);
  }
}
