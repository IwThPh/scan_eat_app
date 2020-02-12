import 'dart:async';
import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:scaneat/features/login/domain/entities/auth.dart';
import 'package:scaneat/features/login/domain/entities/validator.dart';
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
  final bool isError;

  @override
  String toString() => 'LoadLoginPageEvent';

  LoadLoginPageEvent(this.isError);

  @override
  Future<LoginPageState> applyAsync(
      {LoginPageState currentState, LoginPageBloc bloc}) async {
    try {
      return InLoginPageState(1);
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
        (auth) => _onSuccess(auth, bloc),
      );
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadTestEvent', error: _, stackTrace: stackTrace);
      return ErrorLoginPageState(0, _?.toString());
    }
  }

  @override
  List<Object> get props => [];

  LoginPageState _onSuccess(Auth auth, LoginPageBloc bloc) {
    return CompleteLoginPageState(1, auth.accessToken);
  }
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
        (success) => _onSuccess(success, bloc),
      );
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadTestEvent', error: _, stackTrace: stackTrace);
      return ErrorLoginPageState(0, _?.toString());
    }
  }

  @override
  List<Object> get props => [];

  LoginPageState _onSuccess(
      Either<Validator, Auth> success, LoginPageBloc bloc) {
    return success.fold(
      (validator) => InLoginPageState(1, true, validator),
      (auth) => CompleteLoginPageState(1, auth.accessToken),
    );
  }
}
