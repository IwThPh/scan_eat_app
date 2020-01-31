import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/features/login/domain/usecases/login_request.dart';
import 'package:scaneat/features/login/presentation/bloc/bloc.dart';
import 'package:scaneat/features/login/presentation/bloc/login_page_bloc.dart';
import 'package:scaneat/features/login/presentation/bloc/login_page_state.dart';

import '../../../../samples.dart';

class MockLoginRequest extends Mock implements LoginRequest {}

main() {
  LoginPageBloc bloc;
  MockLoginRequest mockLoginRequest;

  setUp(() {
    mockLoginRequest = MockLoginRequest();
    bloc = LoginPageBloc(request: mockLoginRequest);
  });

  test('Initial state should be UnLoginPageState, version: 0', () {
    expect(bloc.initialState, equals(UnLoginPageState(0)));
  });

  test(
      'Initialising Bloc from initial state should return InLoginPageState, version: 0',
      () {
    final expected = [
      UnLoginPageState(0),
      InLoginPageState(0),
    ];
    expectLater(bloc, emitsInOrder(expected));

    bloc.add(LoadLoginPageEvent(false));
  });

  group('AttemptLogin', () {
    final tAuthModel = Samples.tAuthModel;
    final tAuth = tAuthModel;
    final tEmail = Samples.tEmail;
    final tPassword = Samples.tPassword;
  });
}
