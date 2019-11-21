import 'package:equatable/equatable.dart';

abstract class ScanningEvent extends Equatable {
  const ScanningEvent();
}

class RetrieveProduct extends ScanningEvent {
  final String barcode;

  RetrieveProduct(this.barcode);

  @override
  List<Object> get props => null;
}

class ScanProduct extends ScanningEvent {
  ScanProduct();
  @override
  List<Object> get props => null;
}

class ManualInput extends ScanningEvent {
  ManualInput();
  @override
  List<Object> get props => null;
}