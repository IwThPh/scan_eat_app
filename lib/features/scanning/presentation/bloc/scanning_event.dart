import 'package:equatable/equatable.dart';
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
          (failure) => ErrorScanningState(1, "No Information Found"),
          (product) => LoadedScanningState(1, product: product));
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
