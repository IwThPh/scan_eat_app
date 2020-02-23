import 'package:equatable/equatable.dart';
import 'package:scaneat/features/home_page/domain/entities/allergen.dart';

abstract class AllergenState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  AllergenState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  AllergenState getStateCopy();

  AllergenState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnAllergenState extends AllergenState {

  UnAllergenState(int version) : super(version);

  @override
  String toString() => 'UnAllergenState';

  @override
  UnAllergenState getStateCopy() {
    return UnAllergenState(0);
  }

  @override
  UnAllergenState getNewVersion() {
    return UnAllergenState(version+1);
  }
}

/// Initialized
class InAllergenState extends AllergenState {
  final List<Allergen> allergens;

  InAllergenState(int version, this.allergens) : super(version, [allergens]);

  @override
  InAllergenState getStateCopy() {
    return InAllergenState(this.version, this.allergens);
  }

  @override
  InAllergenState getNewVersion() {
    return InAllergenState(version+1, this.allergens);
  }
}

class ErrorAllergenState extends AllergenState {
  final String errorMessage;

  ErrorAllergenState(int version, this.errorMessage): super(version, [errorMessage]);

  @override
  ErrorAllergenState getStateCopy() {
    return ErrorAllergenState(this.version, this.errorMessage);
  }

  @override
  ErrorAllergenState getNewVersion() {
    return ErrorAllergenState(version+1, this.errorMessage);
  }
}
