import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ScanningBloc extends Bloc<ScanningEvent, ScanningState> {
  @override
  ScanningState get initialState => InitialScanningState();

  @override
  Stream<ScanningState> mapEventToState(
    ScanningEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
