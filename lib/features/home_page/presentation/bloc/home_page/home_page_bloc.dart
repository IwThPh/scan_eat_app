import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:scaneat/features/home_page/presentation/bloc/home_page/bloc.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {

  HomePageBloc();

  @override
  HomePageState get initialState => UnHomePageState(0);

  @override
  Stream<HomePageState> mapEventToState(
    HomePageEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'HomePageBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
