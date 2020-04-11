import 'dart:async';
import 'dart:developer' as developer;

import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/history/bloc.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HistoryEvent {
  Stream<HistoryState> applyAsync(
      {HistoryState currentState, HistoryBloc bloc});

  const HistoryEvent();
}

class UnHistoryEvent extends HistoryEvent {
  @override
  Stream<HistoryState> applyAsync(
      {HistoryState currentState, HistoryBloc bloc}) async* {
    yield UnHistoryState(0);
  }
}

class LoadHistoryEvent extends HistoryEvent {
  @override
  String toString() => 'LoadHistoryEvent';

  LoadHistoryEvent();

  @override
  Stream<HistoryState> applyAsync(
      {HistoryState currentState, HistoryBloc bloc}) async* {
    try {
      yield UnHistoryState(0);
      final failureOrProducts = await bloc.getHistory(NoParams());
      yield failureOrProducts.fold(
        (failure) => ErrorHistoryState(0, failure.toString()),
        (products) => InHistoryState(1, products),
      );
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadHistoryEvent', error: _, stackTrace: stackTrace);
      yield ErrorHistoryState(0, _?.toString());
    }
  }
}
