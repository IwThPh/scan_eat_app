import 'dart:async';
import 'dart:developer' as developer;

import 'package:scaneat/core/error/exception.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/login/presentation/bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scaneat/features/login/domain/usecases/login_request.dart'
    as login;
import 'package:scaneat/features/login/domain/usecases/register_request.dart'
    as register;

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
    } catch (e, stackTrace) {
      developer.log('$e',
          name: 'LoadTestEvent', error: e, stackTrace: stackTrace);
      if(e is CacheException) return InLoginPageState(1);
      return ErrorLoginPageState(0, e?.toString());
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
  final String cPassword;

  @override
  String toString() => 'RegLoginPageEvent';

  RegLoginPageEvent(this.name, this.email, this.password, this.cPassword);

  @override
  Future<LoginPageState> applyAsync(
      {LoginPageState currentState, LoginPageBloc bloc}) async {
    try {
      final failureOrSuccess = await bloc.registerRequest(register.Params(
        name: name,
        email: email,
        password: password,
        cPassword: cPassword,
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
