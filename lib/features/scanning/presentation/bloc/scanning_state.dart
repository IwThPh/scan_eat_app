import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/product.dart';

abstract class ScanningState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  ScanningState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  ScanningState getStateCopy();

  ScanningState getNewVersion();

  @override
  List<Object> get props => [version];
}

class UnScanningState extends ScanningState {

  UnScanningState(int version) : super(version);

  @override
  List<Object> get props => [];

  @override
  ScanningState getNewVersion() {
    return UnScanningState(version + 1);
  }

  @override
  ScanningState getStateCopy() {
    return UnScanningState(version);
  }
}

class ScanScanningState extends ScanningState {

  ScanScanningState(int version) : super(version);

  @override
  List<Object> get props => [];

  @override
  ScanningState getNewVersion() {
    return ScanScanningState(version + 1);
  }

  @override
  ScanningState getStateCopy() {
    return ScanScanningState(version);
  }
}

class UserInputScanningState extends ScanningState {

  UserInputScanningState(int version) : super(version);

  @override
  List<Object> get props => [];

  @override
  ScanningState getNewVersion() {
    return UserInputScanningState(version + 1);
  }

  @override
  ScanningState getStateCopy() {
    return UserInputScanningState(version);
  }
}
class LoadingScaningState extends ScanningState {

  LoadingScaningState(int version): super(version);

  @override
  List<Object> get props => [];

  @override
  ScanningState getNewVersion() {
    return LoadingScaningState(version + 1);
  }

  @override
  ScanningState getStateCopy() {
    return LoadingScaningState(version);
  }
}

class LoadedScanningState extends ScanningState {
  final Product product;

  LoadedScanningState(int version, {@required this.product}) : super(version);

  @override
  List<Object> get props => [product];

  @override
  ScanningState getNewVersion() {
    return LoadedScanningState(version + 1, product: product);
  }

  @override
  ScanningState getStateCopy() {
    return LoadedScanningState(version, product: product);
  }
}

class ErrorScanningState extends ScanningState {
  final String message;

  ErrorScanningState(int version, this.message) : super(version);

  @override
  List<Object> get props => [message];

  @override
  ScanningState getNewVersion() {
    return ErrorScanningState(version + 1, message);
  }

  @override
  ScanningState getStateCopy() {
    return ErrorScanningState(version, message);
  }
}
