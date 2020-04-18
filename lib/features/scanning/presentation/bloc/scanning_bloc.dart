import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
import '../../domain/usecases/get_product.dart';
import 'bloc.dart';

class ScanningBloc extends Bloc<ScanningEvent, ScanningState> {
  final GetProduct getProduct;

  ScanningBloc({
    @required GetProduct product,
  })  : assert(product != null),
        getProduct = product;

  @override
  ScanningState get initialState => UnScanningState(0);

  @override
  Stream<ScanningState> mapEventToState(
    ScanningEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoginPageBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
