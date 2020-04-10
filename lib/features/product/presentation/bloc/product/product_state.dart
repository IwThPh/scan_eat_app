import 'package:equatable/equatable.dart';
import 'package:scaneat/features/product/domain/entities/product.dart';

abstract class ProductState extends Equatable {
  /// notify change state without deep clone state
  final int version;

  final Product product;

  final List propss;
  ProductState(this.version, this.product,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  ProductState getStateCopy();

  ProductState getNewVersion();

  @override
  List<Object> get props => ([version, product, ...propss ?? []]);
}

/// Unitialized
class UnProductState extends ProductState {
  UnProductState(int version, Product product) : super(version, product);

  @override
  String toString() => 'UnProductState';

  @override
  UnProductState getStateCopy() {
    return UnProductState(this.version, this.product);
  }

  @override
  UnProductState getNewVersion() {
    return UnProductState(version+1, this.product);
  }
}

/// Initialized
class InProductState extends ProductState {
  InProductState(int version, Product product) : super(version, product);

  @override
  String toString() => 'InProductState ${product.barcode}';

  @override
  InProductState getStateCopy() {
    return InProductState(this.version, this.product);
  }

  @override
  InProductState getNewVersion() {
    return InProductState(version+1, this.product);
  }
}

/// Error
class ErrorProductState extends ProductState {
  final String message;

  ErrorProductState(int version, Product product, this.message) : super(version, product, [message]);

  @override
  String toString() => 'ErrorProductState - $message';

  @override
  ErrorProductState getStateCopy() {
    return ErrorProductState(this.version, this.product, this.message);
  }

  @override
  ErrorProductState getNewVersion() {
    return ErrorProductState(version+1, this.product, this.message);
  }
}