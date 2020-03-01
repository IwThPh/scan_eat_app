import 'dart:async';
import 'dart:developer' as developer;

import 'package:scaneat/features/home_page/domain/usecases/update_preference.dart';

import 'bloc.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/home_page/domain/entities/preference.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PreferenceEvent {
  Future<PreferenceState> applyAsync(
      {PreferenceState currentState, PreferenceBloc bloc});
}

class UnPreferenceEvent extends PreferenceEvent {
  @override
  Future<PreferenceState> applyAsync(
      {PreferenceState currentState, PreferenceBloc bloc}) async {
    return UnPreferenceState(0);
  }
}

class LoadPreferenceEvent extends PreferenceEvent {
  @override
  String toString() => 'LoadPreferenceEvent';

  LoadPreferenceEvent();

  @override
  Future<PreferenceState> applyAsync(
      {PreferenceState currentState, PreferenceBloc bloc}) async {
    try {
      if (currentState is InPreferenceState) {
        return currentState.getNewVersion();
      }

      final failureOrPreference = await bloc.getPreference(NoParams());

      return failureOrPreference.fold(  
        (failure) => ErrorPreferenceState(0, "Error Fetching Preference"),
        (pref) => InPreferenceState(1, pref),
      );
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadPreferenceEvent', error: _, stackTrace: stackTrace);
      return ErrorPreferenceState(0, _?.toString());
    }
  }
}

class UpdatePreferenceEvent extends PreferenceEvent {
  final Preference preference;

  @override
  String toString() => 'UpdatePreferenceEvent';

  UpdatePreferenceEvent(this.preference);

  @override
  Future<PreferenceState> applyAsync(
      {PreferenceState currentState, PreferenceBloc bloc}) async {
    try {
      final failureOrPreference = await bloc.updatePreference(Params(pref: preference));

      return failureOrPreference.fold(
        (failure) => ErrorPreferenceState(0, "Error Updating Preference"),
        (pref) => InPreferenceState(1, pref),
      );
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadAllergenEvent', error: _, stackTrace: stackTrace);
      return ErrorPreferenceState(0, _?.toString());
    }
  }
}

class ResetPreferenceEvent extends PreferenceEvent {
  @override
  String toString() => 'ResetPreferenceEvent';

  ResetPreferenceEvent();

  @override
  Future<PreferenceState> applyAsync(
      {PreferenceState currentState, PreferenceBloc bloc}) async {
    try {
      if (currentState is InPreferenceState) {
        return currentState.getNewVersion();
      }

      final failureOrPreference = await bloc.deletePreference(NoParams());

      return failureOrPreference.fold(  
        (failure) => ErrorPreferenceState(0, "Error Reseting Preference"),
        (pref) => InPreferenceState(1, pref),
      );
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'ResetPreferenceEvent', error: _, stackTrace: stackTrace);
      return ErrorPreferenceState(0, _?.toString());
    }
  }
}