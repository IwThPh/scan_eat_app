import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/features/login/domain/usecases/login_request.dart';
import 'package:scaneat/features/login/domain/usecases/logout_request.dart';
import 'package:scaneat/features/login/domain/usecases/register_request.dart';
import 'package:scaneat/features/login/domain/usecases/retrieve_user.dart';
import 'package:scaneat/features/login/presentation/bloc/bloc.dart';
import 'package:scaneat/features/login/presentation/bloc/login_page_bloc.dart';
import 'package:scaneat/features/login/presentation/bloc/login_page_state.dart';

import '../../../../samples.dart';

class MockLoginRequest extends Mock implements LoginRequest {}

class MockLogoutRequest extends Mock implements LogoutRequest {}

class MockRegisterRequest extends Mock implements RegisterRequest {}

class MockRetrieveUser extends Mock implements RetrieveUser {}

main() {
  LoginPageBloc bloc;
  MockLoginRequest mockLoginRequest;
  MockLogoutRequest mockLogoutRequest;
  MockRegisterRequest mockRegisterRequest;
  MockRetrieveUser mockRetrieveUser;

  setUp(() {
    mockLoginRequest = MockLoginRequest();
    mockLogoutRequest = MockLogoutRequest();
    mockRegisterRequest = MockRegisterRequest();
    mockRetrieveUser = MockRetrieveUser();
    bloc = LoginPageBloc(
      loginRequest: mockLoginRequest,
      logoutRequest: mockLogoutRequest,
      registerRequest: mockRegisterRequest,
      retrieveUser: mockRetrieveUser,
    );
  });


  final tUserModel = Samples.tUserModel;
  final tUser = tUserModel;

  test('Initial state should be UnLoginPageState, version: 0', () {
    expect(bloc.initialState, equals(UnLoginPageState(0)));
  });

  test(
      'Initialising Bloc from initial state should return InLoginPageState, when no token is stored.',
      () {
    when(mockRetrieveUser(any)).thenAnswer((_) async => Left(null));
    final expected = [
      UnLoginPageState(0),
      InLoginPageState(1),
    ];
    expectLater(bloc, emitsInOrder(expected));

    bloc.add(LoadLoginPageEvent());
  });

  test(
      'Initialising Bloc from initial state should return CompleteLoginPageState, when a token is stored.',
      () {
    when(mockRetrieveUser(any)).thenAnswer((_) async => Right(tUser));
    final expected = [
      UnLoginPageState(0),
      CompleteLoginPageState(1, tUser),
    ];
    expectLater(bloc, emitsInOrder(expected));

    bloc.add(LoadLoginPageEvent());
  });

  group('AttemptLogin', () {
    //TODO: Look into Consecutive stubbing for this situation
    // test('Sending a SendLoginPageEvent with user crediantials should return ',
    //     () {
    //   when(mockLoginRequest(any)).thenAnswer((_) async => Right(tAuth));
    //   var answers = [Left(null), Right(tUser)];
    //   when(mockRetrieveUser(any)).thenAnswer((_) async => answers.removeAt(0));

    //   final expected = [
    //     UnLoginPageState(0),
    //     InLoginPageState(1),
    //     CompleteLoginPageState(1, tUser),
    //   ];

    //   expectLater(bloc, emitsInOrder(expected));

    //   bloc.add(LoadLoginPageEvent());
    //   bloc.add(SendLoginPageEvent(tEmail, tPassword));
    // });
  });

  group('AttemptRegister', () {
    //TODO: Look into Consecutive stubbing for this situation
    // test('Sending a SendLoginPageEvent with user crediantials', () {
    //   when(mockRegisterRequest(any))
    //       .thenAnswer((_) async => Right(Right(tAuth)));
    //   var answers = [Left(null), Right(tUser)];
    //   when(mockRetrieveUser(any)).thenAnswer((_) async => answers.removeAt(0));

    //   final expected = [
    //     UnLoginPageState(0),
    //     InLoginPageState(1),
    //     CompleteLoginPageState(1, tUser),
    //   ];
    //   expectLater(bloc, emitsInOrder(expected));

    //   bloc.add(UnLoginPageEvent());
    //   bloc.add(LoadLoginPageEvent());
    //   bloc.add(RegLoginPageEvent(tName, tEmail, tPassword, tPassword));
    // });
  });
}
