import 'package:equatable/equatable.dart';
import 'package:scaneat/features/product/domain/entities/product.dart';

abstract class HistoryState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  HistoryState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  HistoryState getStateCopy();

  HistoryState getNewVersion();

  @override
  List<Object> get props => ([version, ...propss ?? []]);
}

/// UnInitialized
class UnHistoryState extends HistoryState {

  UnHistoryState(int version) : super(version);

  @override
  String toString() => 'UnHistoryState';

  @override
  UnHistoryState getStateCopy() {
    return UnHistoryState(0);
  }

  @override
  UnHistoryState getNewVersion() {
    return UnHistoryState(version+1);
  }
}

/// Initialized
class InHistoryState extends HistoryState {
  final List<Product> products;

  InHistoryState(int version, this.products) : super(version, [products]);

  @override
  String toString() => 'InHistoryState - Loaded : ${products.length}';

  @override
  InHistoryState getStateCopy() {
    return InHistoryState(this.version, this.products);
  }

  @override
  InHistoryState getNewVersion() {
    return InHistoryState(version+1, this.products);
  }
}

class ErrorHistoryState extends HistoryState {
  final String errorMessage;

  ErrorHistoryState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorHistoryState';

  @override
  ErrorHistoryState getStateCopy() {
    return ErrorHistoryState(this.version, this.errorMessage);
  }

  @override
  ErrorHistoryState getNewVersion() {
    return ErrorHistoryState(version+1, this.errorMessage);
  }
}
