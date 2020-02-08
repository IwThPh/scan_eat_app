import 'dart:async';
import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/features/login/domain/entities/auth.dart';
import 'package:scaneat/features/login/presentation/bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scaneat/features/login/domain/usecases/login_request.dart';

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

class SendLoginPageEvent extends LoginPageEvent {
  final String email;
  final String password;

  @override
  String toString() => 'SendLoginPageEvent';

  SendLoginPageEvent(this.email, this.password);

  @override
  Future<LoginPageState> applyAsync(
      {LoginPageState currentState, LoginPageBloc bloc}) async {
    try {
      final failureOrAuth = await bloc.loginRequest(Params(email: email, password: password));
      return _eitherFailureOrAuth(failureOrAuth);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadTestEvent', error: _, stackTrace: stackTrace);
      return ErrorLoginPageState(0, _?.toString());
    }
  }

  @override
  List<Object> get props => [];

  LoginPageState _eitherFailureOrAuth(Either<Failure, Auth> failureOrAuth) {
    return failureOrAuth.fold(
        (failure) => ErrorLoginPageState(0, "Error Authenticating"),
        (auth) => ErrorLoginPageState(1, auth.accessToken));
        //TODO: Handle Auth Success 
  }
}
