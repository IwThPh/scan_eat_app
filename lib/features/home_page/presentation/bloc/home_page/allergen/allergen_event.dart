import 'dart:async';
import 'dart:developer' as developer;

import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/home_page/domain/entities/allergen.dart';
import 'package:scaneat/features/home_page/domain/usecases/select_allergen.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/allergen/bloc.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AllergenEvent {
  Future<AllergenState> applyAsync(
      {AllergenState currentState, AllergenBloc bloc});
}

class UnAllergenEvent extends AllergenEvent {
  @override
  Future<AllergenState> applyAsync(
      {AllergenState currentState, AllergenBloc bloc}) async {
    return UnAllergenState(0);
  }
}

class LoadAllergenEvent extends AllergenEvent {
  @override
  String toString() => 'LoadAllergenEvent';

  LoadAllergenEvent();

  @override
  Future<AllergenState> applyAsync(
      {AllergenState currentState, AllergenBloc bloc}) async {
    try {
      if (currentState is InAllergenState) {
        return currentState.getNewVersion();
      }

      final failureOrAllergens = await bloc.getAllergen(NoParams());

      return failureOrAllergens.fold(  
        (failure) => ErrorAllergenState(0, "Error Fetching Allergens"),
        (allergens) => InAllergenState(1, allergens),
      );
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadAllergenEvent', error: _, stackTrace: stackTrace);
      return ErrorAllergenState(0, _?.toString());
    }
  }
}

class UpdateAllergenEvent extends AllergenEvent {
  final List<Allergen> allergens;

  @override
  String toString() => 'UpdateAllergenEvent';

  UpdateAllergenEvent(this.allergens);

  @override
  Future<AllergenState> applyAsync(
      {AllergenState currentState, AllergenBloc bloc}) async {
    try {
      final failureOrMessage = await bloc.selectAllergen(Params(allergens: allergens));

      return failureOrMessage.fold(
        (failure) => ErrorAllergenState(0, "Error Fetching Allergens"),
        (message) => MessageAllergenState(1, message),
      );
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadAllergenEvent', error: _, stackTrace: stackTrace);
      return ErrorAllergenState(0, _?.toString());
    }
  }
}
