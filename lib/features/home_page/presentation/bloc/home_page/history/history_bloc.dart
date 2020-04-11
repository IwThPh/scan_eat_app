import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_history.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/history/bloc.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetHistory getHistory;

  HistoryBloc({
    @required GetHistory getHistory,
  }) : assert(getHistory != null),
      getHistory = getHistory;

  @override
  HistoryState get initialState => UnHistoryState(0);

  @override
  Stream<HistoryState> mapEventToState(
    HistoryEvent event,
  ) async* {
    try {
      yield* await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'HistoryBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
