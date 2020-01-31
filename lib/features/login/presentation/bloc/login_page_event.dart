import 'dart:async';
import 'dart:developer' as developer;

import 'package:scaneat/features/login/presentation/bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class LoginPageEvent extends Equatable {
  Future<LoginPageState> applyAsync(
      {LoginPageState currentState, LoginPageBloc bloc});

  const LoginPageEvent();
}

class UnLoginPageEvent extends LoginPageEvent {
  @override
  Future<LoginPageState> applyAsync(
      {LoginPageState currentState, LoginPageBloc bloc}) async {
    return UnLoginPageState(0);
  }

  @override
  List<Object> get props => [];
}

class LoadLoginPageEvent extends LoginPageEvent {
  final bool isError;

  @override
  String toString() => 'LoadLoginPageEvent';

  LoadLoginPageEvent(this.isError);

  @override
  Future<LoginPageState> applyAsync(
      {LoginPageState currentState, LoginPageBloc bloc}) async {
    try {
      if (currentState is InLoginPageState) {
        return currentState.getNewVersion();
      }
      return InLoginPageState(0);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadTestEvent', error: _, stackTrace: stackTrace);
      return ErrorLoginPageState(0, _?.toString());
    }
  }

  @override
  List<Object> get props => [];
}
