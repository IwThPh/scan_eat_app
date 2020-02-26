import 'dart:async';
import 'dart:developer' as developer;

import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/home_page/domain/entities/diet.dart';
import 'package:scaneat/features/home_page/domain/usecases/select_diet.dart';
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

class UpdateDietEvent extends DietEvent {
  final List<Diet> diets;

  @override
  String toString() => 'UpdateDietEvent';

  UpdateDietEvent(this.diets);

  @override
  Future<DietState> applyAsync(
      {DietState currentState, DietBloc bloc}) async {
    try {
      final failureOrMessage = await bloc.selectDiet(Params(diets: diets));

      return failureOrMessage.fold(
        (failure) => ErrorDietState(0, "Error Fetching Diets"),
        (message) => MessageDietState(1, message),
      );
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadDietEvent', error: _, stackTrace: stackTrace);
      return ErrorDietState(0, _?.toString());
    }
  }
}

