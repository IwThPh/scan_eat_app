import 'package:equatable/equatable.dart';
import 'package:scaneat/features/login/domain/entities/validator.dart';

abstract class LoginPageState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  LoginPageState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  LoginPageState getStateCopy();

  LoginPageState getNewVersion();

  @override
  List<Object> get props => [version];
}

/// UnInitialized
class UnLoginPageState extends LoginPageState {

  UnLoginPageState(int version) : super(version);

  @override
  String toString() => 'UnLoginPageState';

  @override
  UnLoginPageState getStateCopy() {
    return UnLoginPageState(0);
  }

  @override
  UnLoginPageState getNewVersion() {
    return UnLoginPageState(version+1);
  }
}

/// Initialized
class InLoginPageState extends LoginPageState {
  final Validator errors;
  final bool isReg;

  InLoginPageState(int version, [this.isReg = false, this.errors]) : super(version);

  @override
  String toString() => 'InLoginPageState';

  @override
  InLoginPageState getStateCopy() {
    return InLoginPageState(this.version);
  }

  @override
  InLoginPageState getNewVersion() {
    return InLoginPageState(version+1);
  }
}

//Error. Displays message
class ErrorLoginPageState extends LoginPageState {
  final String errorMessage;

  ErrorLoginPageState(int version, this.errorMessage): super(version, [errorMessage]);
  
  @override
  String toString() => 'ErrorLoginPageState';

  @override
  ErrorLoginPageState getStateCopy() {
    return ErrorLoginPageState(this.version, this.errorMessage);
  }

  @override
  ErrorLoginPageState getNewVersion() {
    return ErrorLoginPageState(version+1, this.errorMessage);
  }
}

/// Logged In.
class CompleteLoginPageState extends LoginPageState {
  final String token;

  CompleteLoginPageState(int version, this.token) : super(version, [ token ]);

  @override
  String toString() => 'CompleteLoginPageState';

  @override
  CompleteLoginPageState getStateCopy() {
    return CompleteLoginPageState(this.version, this.token);
  }

  @override
  CompleteLoginPageState getNewVersion() {
    return CompleteLoginPageState(this.version+1, this.token);
  }
}
