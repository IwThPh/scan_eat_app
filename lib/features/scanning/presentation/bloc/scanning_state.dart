import 'package:equatable/equatable.dart';

abstract class ScanningState extends Equatable {
  const ScanningState();
}

class InitialScanningState extends ScanningState {
  @override
  List<Object> get props => [];
}
