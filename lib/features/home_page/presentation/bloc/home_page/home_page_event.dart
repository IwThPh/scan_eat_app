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
   
  final bool isError;
  @override
  String toString() => 'LoadHomePageEvent';

  LoadHomePageEvent(this.isError);

  @override
  Future<HomePageState> applyAsync(
      {HomePageState currentState, HomePageBloc bloc}) async {
    try {
      if (currentState is InHomePageState) {
        return currentState.getNewVersion();
      }
      return InHomePageState(0);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoadHomePageEvent', error: _, stackTrace: stackTrace);
      return ErrorHomePageState(0, _?.toString());
    }
  }
}
