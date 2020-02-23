import 'dart:async';
import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/login/domain/entities/auth.dart';
import 'package:scaneat/features/login/domain/entities/validator.dart';
import 'package:scaneat/features/login/presentation/bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scaneat/features/login/domain/usecases/login_request.dart'
    as login;
import 'package:scaneat/features/login/domain/usecases/register_request.dart'
    as register;
import 'package:scaneat/features/login/domain/usecases/retrieve_user.dart'
    as user;

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
  @override
  String toString() => 'LoadLoginPageEvent';

  LoadLoginPageEvent();

  @override
  Future<LoginPageState> applyAsync(
      {LoginPageState currentState, LoginPageBloc bloc}) async {
    try {
      final failureOrUser = await bloc.retrieveUser(NoParams());
      return failureOrUser.fold(
        (failure) => InLoginPageState(1),
        (user) => CompleteLoginPageState(1, user),
      );
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
      final failureOrAuth = await bloc.loginRequest(login.Params(
        email: email,
        password: password,
      ));

      return failureOrAuth.fold(
        (failure) => ErrorLoginPageState(0, "Error Authenticating"),
        (auth) async {
          final failureOrUser = await bloc.retrieveUser(NoParams());
          return failureOrUser.fold(
            (failure) => InLoginPageState(1),
            (user) => CompleteLoginPageState(1, user),
          );
        },
      );
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadTestEvent', error: _, stackTrace: stackTrace);
      return ErrorLoginPageState(0, _?.toString());
    }
  }

  @override
  List<Object> get props => [];
}

class RegLoginPageEvent extends LoginPageEvent {
  final String name;
  final String email;
  final String password;
  final String c_password;

  @override
  String toString() => 'RegLoginPageEvent';

  RegLoginPageEvent(this.name, this.email, this.password, this.c_password);

  @override
  Future<LoginPageState> applyAsync(
      {LoginPageState currentState, LoginPageBloc bloc}) async {
    try {
      final failureOrSuccess = await bloc.registerRequest(register.Params(
        name: name,
        email: email,
        password: password,
        c_password: c_password,
      ));

      return failureOrSuccess.fold(
        (failure) => ErrorLoginPageState(0, "Error Registering"),
        (success) => success.fold(
          (validator) => InLoginPageState(1, true, validator),
          (auth) async {
            final failureOrUser = await bloc.retrieveUser(NoParams());
            return failureOrUser.fold(
              (failure) => InLoginPageState(1, true),
              (user) => CompleteLoginPageState(1, user),
            );
          },
        ),
      );
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadTestEvent', error: _, stackTrace: stackTrace);
      return ErrorLoginPageState(0, _?.toString());
    }
  }

  @override
  List<Object> get props => [];
}
