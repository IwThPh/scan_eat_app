import 'package:equatable/equatable.dart';
import 'package:scaneat/features/product/domain/entities/product.dart';

abstract class SavedState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  SavedState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  SavedState getStateCopy();

  SavedState getNewVersion();

  @override
  List<Object> get props => ([version, ...propss ?? []]);
}

/// UnInitialized
class UnSavedState extends SavedState {

  UnSavedState(int version) : super(version);

  @override
  String toString() => 'UnSavedState';

  @override
  UnSavedState getStateCopy() {
    return UnSavedState(0);
  }

  @override
  UnSavedState getNewVersion() {
    return UnSavedState(version+1);
  }
}

/// Initialized
class InSavedState extends SavedState {
  final List<Product> products;

  InSavedState(int version, this.products) : super(version, [products]);

  @override
  String toString() => 'InSavedState - Loaded : ${products.length}';

  @override
  InSavedState getStateCopy() {
    return InSavedState(this.version, this.products);
  }

  @override
  InSavedState getNewVersion() {
    return InSavedState(version+1, this.products);
  }
}

class ErrorSavedState extends SavedState {
  final String errorMessage;

  ErrorSavedState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorSavedState';

  @override
  ErrorSavedState getStateCopy() {
    return ErrorSavedState(this.version, this.errorMessage);
  }

  @override
  ErrorSavedState getNewVersion() {
    return ErrorSavedState(version+1, this.errorMessage);
  }
}
