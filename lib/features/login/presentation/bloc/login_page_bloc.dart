import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:scaneat/features/login/domain/usecases/login_request.dart';
import 'package:scaneat/features/login/domain/usecases/register_request.dart';
import 'package:scaneat/features/login/domain/usecases/retrieve_user.dart';
import 'package:scaneat/features/login/presentation/bloc/bloc.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  final LoginRequest loginRequest;
  final RegisterRequest registerRequest;
  final RetrieveUser retrieveUser;

  LoginPageBloc({
    @required LoginRequest loginRequest,
    @required RegisterRequest registerRequest,
    @required RetrieveUser retrieveUser,
  })  : assert(loginRequest != null),
        assert(registerRequest != null),
        assert(retrieveUser != null),
        loginRequest = loginRequest,
        registerRequest = registerRequest,
        retrieveUser = retrieveUser;

  @override
  LoginPageState get initialState => UnLoginPageState(0);

  @override
  Stream<LoginPageState> mapEventToState(
    LoginPageEvent event,
  ) async* {
    try {
      yield await event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoginPageBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
