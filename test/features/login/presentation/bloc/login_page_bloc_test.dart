import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/features/login/domain/usecases/login_request.dart';
import 'package:scaneat/features/login/domain/usecases/register_request.dart';
import 'package:scaneat/features/login/presentation/bloc/bloc.dart';
import 'package:scaneat/features/login/presentation/bloc/login_page_bloc.dart';
import 'package:scaneat/features/login/presentation/bloc/login_page_state.dart';

import '../../../../samples.dart';

class MockLoginRequest extends Mock implements LoginRequest {}

class MockRegisterRequest extends Mock implements RegisterRequest {}

main() {
  LoginPageBloc bloc;
  MockLoginRequest mockLoginRequest;
  MockRegisterRequest mockRegisterRequest;

  setUp(() {
    mockLoginRequest = MockLoginRequest();
    mockRegisterRequest = MockRegisterRequest();
    bloc = LoginPageBloc(
      loginRequest: mockLoginRequest,
      registerRequest: mockRegisterRequest,
    );
  });

  test('Initial state should be UnLoginPageState, version: 0', () {
    expect(bloc.initialState, equals(UnLoginPageState(0)));
  });

  test(
      'Initialising Bloc from initial state should return InLoginPageState, version: 1',
      () {
    final expected = [
      UnLoginPageState(0),
      InLoginPageState(1),
    ];
    expectLater(bloc, emitsInOrder(expected));

    bloc.add(LoadLoginPageEvent(false));
  });

  group('AttemptLogin', () {
    final tAuthModel = Samples.tAuthModel;
    final tAuth = tAuthModel;
    final tEmail = Samples.tEmail;
    final tPassword = Samples.tPassword;

    test('Sending a SendLoginPageEvent with user crediantials should return ',
        () {
      when(mockLoginRequest(any)).thenAnswer((_) async => Right(tAuth));

      final expected = [
        UnLoginPageState(0),
        InLoginPageState(1),
        CompleteLoginPageState(1, tAuth.accessToken.substring(0, 30)),
      ];
      expectLater(bloc, emitsInOrder(expected));

      bloc.add(LoadLoginPageEvent(false));
      bloc.add(SendLoginPageEvent(tEmail, tPassword));
    });
  });

  group('AttemptRegister', () {
    final tAuthModel = Samples.tAuthModel;
    final tAuth = tAuthModel;
    final tName = Samples.tName;
    final tEmail = Samples.tEmail;
    final tPassword = Samples.tPassword;

    test('Sending a SendLoginPageEvent with user crediantials should return ',
        () {
      when(mockRegisterRequest(any)).thenAnswer((_) async => Right(Right(tAuth)));

      final expected = [
        UnLoginPageState(0),
        InLoginPageState(1),
        CompleteLoginPageState(1, tAuth.accessToken.substring(0, 30)),
      ];
      expectLater(bloc, emitsInOrder(expected));

      bloc.add(LoadLoginPageEvent(false));
      bloc.add(RegLoginPageEvent(tName, tEmail, tPassword, tPassword));
    });
  });
}
