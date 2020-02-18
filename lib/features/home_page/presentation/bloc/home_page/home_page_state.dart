import 'package:equatable/equatable.dart';

abstract class HomePageState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  HomePageState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  HomePageState getStateCopy();

  HomePageState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnHomePageState extends HomePageState {

  UnHomePageState(int version) : super(version);

  @override
  String toString() => 'UnHomePageState';

  @override
  UnHomePageState getStateCopy() {
    return UnHomePageState(0);
  }

  @override
  UnHomePageState getNewVersion() {
    return UnHomePageState(version+1);
  }
}

/// Initialized
class InHomePageState extends HomePageState {
  InHomePageState(int version) : super(version);

  @override
  String toString() => 'InHomePageState';

  @override
  InHomePageState getStateCopy() {
    return InHomePageState(this.version);
  }

  @override
  InHomePageState getNewVersion() {
    return InHomePageState(version+1);
  }
}

class ErrorHomePageState extends HomePageState {
  final String errorMessage;

  ErrorHomePageState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorHomePageState';

  @override
  ErrorHomePageState getStateCopy() {
    return ErrorHomePageState(this.version, this.errorMessage);
  }

  @override
  ErrorHomePageState getNewVersion() {
    return ErrorHomePageState(version+1, this.errorMessage);
  }
}
