import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:scaneat/features/home_page/domain/usecases/delete_preference.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_preference.dart';
import 'package:scaneat/features/home_page/domain/usecases/update_preference.dart';

import 'bloc.dart';

class PreferenceBloc extends Bloc<PreferenceEvent, PreferenceState> {
  final GetPreference getPreference;
  final UpdatePreference updatePreference;
  final DeletePreference deletePreference;

  PreferenceBloc({
    @required GetPreference getPreference,
    @required UpdatePreference updatePreference,
    @required DeletePreference deletePreference,
  })  : assert(getPreference != null),
        assert(updatePreference != null),
        assert(deletePreference != null),
        getPreference = getPreference,
        updatePreference = updatePreference,
        deletePreference = deletePreference;

  @override
  PreferenceState get initialState => UnPreferenceState(0);

  @override
  Stream<PreferenceState> mapEventToState(
    PreferenceEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'PreferenceBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
