import 'dart:async';
import 'dart:developer' as developer;

import 'package:scaneat/features/home_page/presentation/bloc/home_page/bloc.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomePageEvent {
  Future<HomePageState> applyAsync(
      {HomePageState currentState, HomePageBloc bloc});
}

class UnHomePageEvent extends HomePageEvent {
  @override
  Future<HomePageState> applyAsync({HomePageState currentState, HomePageBloc bloc}) async {
    return UnHomePageState(0);
  }
}

class LoadHomePageEvent extends HomePageEvent {
   
  @override
  String toString() => 'LoadHomePageEvent';

  LoadHomePageEvent();

  @override
  Future<HomePageState> applyAsync(
      {HomePageState currentState, HomePageBloc bloc}) async {
    try {
      return InHomePageState(0);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadHomePageEvent', error: _, stackTrace: stackTrace);
      return ErrorHomePageState(0, _?.toString());
    }
  }
}
