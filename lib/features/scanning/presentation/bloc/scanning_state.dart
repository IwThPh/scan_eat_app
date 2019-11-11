import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/product.dart';

abstract class ScanningState extends Equatable {
  const ScanningState();
}

class Scanning extends ScanningState {
  @override
  List<Object> get props => [];
}

class Loading extends ScanningState {
  @override
  List<Object> get props => [];
}

class Loaded extends ScanningState {
  final Product product;

  Loaded({@required this.product});

  @override
  List<Object> get props => [product];
}

class Error extends ScanningState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
