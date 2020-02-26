import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_allergen.dart';
import 'package:scaneat/features/home_page/domain/usecases/select_allergen.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/allergen/bloc.dart';

class AllergenBloc extends Bloc<AllergenEvent, AllergenState> {
  final GetAllergen getAllergen;
  final SelectAllergen selectAllergen;

  AllergenBloc({
    @required GetAllergen getAllergen,
    @required SelectAllergen selectAllergen,
  })  : assert(getAllergen != null),
        assert(getAllergen != null),
        getAllergen = getAllergen,
        selectAllergen = selectAllergen;

  @override
  AllergenState get initialState => UnAllergenState(0);

  @override
  Stream<AllergenState> mapEventToState(
    AllergenEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'AllergenBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
