import 'package:equatable/equatable.dart';
import 'package:scaneat/features/home_page/domain/entities/diet.dart';

abstract class DietState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  DietState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  DietState getStateCopy();

  DietState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnDietState extends DietState {

  UnDietState(int version) : super(version);

  @override
  String toString() => 'UnDietState';

  @override
  UnDietState getStateCopy() {
    return UnDietState(0);
  }

  @override
  UnDietState getNewVersion() {
    return UnDietState(version+1);
  }
}

/// Initialized
class InDietState extends DietState {
  final List<Diet> diets;

  InDietState(int version, this.diets) : super(version, [diets]);

  @override
  InDietState getStateCopy() {
    return InDietState(this.version, this.diets);
  }

  @override
  InDietState getNewVersion() {
    return InDietState(version+1, this.diets);
  }
}

class ErrorDietState extends DietState {
  final String errorMessage;

  ErrorDietState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorDietState';

  @override
  ErrorDietState getStateCopy() {
    return ErrorDietState(this.version, this.errorMessage);
  }

  @override
  ErrorDietState getNewVersion() {
    return ErrorDietState(version+1, this.errorMessage);
  }
}

class MessageDietState extends DietState {
  final String message;

  MessageDietState(int version, this.message): super(version, [message]);

  @override
  MessageDietState getStateCopy() {
    return MessageDietState(this.version, this.message);
  }

  @override
  ErrorDietState getNewVersion() {
    return ErrorDietState(version+1, this.message);
  }
}