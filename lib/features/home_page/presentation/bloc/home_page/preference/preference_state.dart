import 'package:equatable/equatable.dart';
import 'package:scaneat/features/home_page/domain/entities/preference.dart';

abstract class PreferenceState extends Equatable {
  /// notify change state without deep clone state
  final int version;
  
  final List propss;
  PreferenceState(this.version,[this.propss]);

  /// Copy object for use in action
  /// if need use deep clone
  PreferenceState getStateCopy();

  PreferenceState getNewVersion();

  @override
  List<Object> get props => (propss);
}

/// UnInitialized
class UnPreferenceState extends PreferenceState {

  UnPreferenceState(int version) : super(version);

  @override
  String toString() => 'UnPreferenceState';

  @override
  UnPreferenceState getStateCopy() {
    return UnPreferenceState(0);
  }

  @override
  UnPreferenceState getNewVersion() {
    return UnPreferenceState(version+1);
  }
}

/// Initialized
class InPreferenceState extends PreferenceState {
  final Preference preference;

  InPreferenceState(int version, this.preference) : super(version, [preference]);

  @override
  InPreferenceState getStateCopy() {
    return InPreferenceState(this.version, this.preference);
  }

  @override
  InPreferenceState getNewVersion() {
    return InPreferenceState(version+1, this.preference);
  }
}

class ErrorPreferenceState extends PreferenceState {
  final String errorMessage;

  ErrorPreferenceState(int version, this.errorMessage): super(version, [errorMessage]);

  @override
  ErrorPreferenceState getStateCopy() {
    return ErrorPreferenceState(this.version, this.errorMessage);
  }

  @override
  ErrorPreferenceState getNewVersion() {
    return ErrorPreferenceState(version+1, this.errorMessage);
  }
}