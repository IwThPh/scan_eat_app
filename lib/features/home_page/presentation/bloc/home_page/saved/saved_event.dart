import 'dart:async';
import 'dart:developer' as developer;

import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/saved/bloc.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SavedEvent {
  Stream<SavedState> applyAsync(
      {SavedState currentState, SavedBloc bloc});

  const SavedEvent();
}

class UnSavedEvent extends SavedEvent {
  @override
  Stream<SavedState> applyAsync(
      {SavedState currentState, SavedBloc bloc}) async* {
    yield UnSavedState(0);
  }
}

class LoadSavedEvent extends SavedEvent {
  @override
  String toString() => 'LoadSavedEvent';

  LoadSavedEvent();

  @override
  Stream<SavedState> applyAsync(
      {SavedState currentState, SavedBloc bloc}) async* {
    try {
      yield UnSavedState(0);
      final failureOrProducts = await bloc.getSaved(NoParams());
      yield failureOrProducts.fold(
        (failure) => ErrorSavedState(0, failure.toString()),
        (products) => InSavedState(1, products),
      );
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadSavedEvent', error: _, stackTrace: stackTrace);
      yield ErrorSavedState(0, _?.toString());
    }
  }
}
