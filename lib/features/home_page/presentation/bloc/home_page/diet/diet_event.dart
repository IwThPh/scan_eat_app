import 'dart:async';
import 'dart:developer' as developer;

import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/diet/bloc.dart';
import 'package:meta/meta.dart';

@immutable
abstract class DietEvent {
  Future<DietState> applyAsync(
      {DietState currentState, DietBloc bloc});
}

class UnDietEvent extends DietEvent {
  @override
  Future<DietState> applyAsync({DietState currentState, DietBloc bloc}) async {
    return UnDietState(0);
  }
}

class LoadDietEvent extends DietEvent {
  @override
  String toString() => 'LoadDietEvent';

  LoadDietEvent();

  @override
  Future<DietState> applyAsync(
      {DietState currentState, DietBloc bloc}) async {
    try {
      if (currentState is InDietState) {
        return currentState.getNewVersion();
      }

      final failureOrDiets = await bloc.getDiet(NoParams());

      return failureOrDiets.fold(
        (failure) => ErrorDietState(0, "Error Fetching Diets"),
        (diets) => InDietState(1, diets),
      );
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadDietEvent', error: _, stackTrace: stackTrace);
      return ErrorDietState(0, _?.toString());
    }
  }
}
