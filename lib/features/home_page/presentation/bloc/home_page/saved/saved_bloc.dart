import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_saved.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/saved/bloc.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  final GetSaved getSaved;

  SavedBloc({
    @required GetSaved getSaved,
  }) : assert(getSaved != null),
      getSaved = getSaved;

  @override
  SavedState get initialState => UnSavedState(0);

  @override
  Stream<SavedState> mapEventToState(
    SavedEvent event,
  ) async* {
    try {
      yield* await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'SavedBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
