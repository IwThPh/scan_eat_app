import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_diet.dart';
import 'package:scaneat/features/home_page/domain/usecases/select_diet.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/diet/bloc.dart';

class DietBloc extends Bloc<DietEvent, DietState> {
  final GetDiet getDiet;
  final SelectDiet selectDiet;

  DietBloc({
    @required GetDiet getDiet,
    @required SelectDiet selectDiet,
  })  : assert(getDiet != null),
        assert(selectDiet != null),
        getDiet = getDiet,
        selectDiet = selectDiet;

  @override
  DietState get initialState => UnDietState(0);

  @override
  Stream<DietState> mapEventToState(
    DietEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'DietBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
