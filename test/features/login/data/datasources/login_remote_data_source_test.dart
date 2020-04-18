import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/config.dart';
import 'package:scaneat/core/error/exception.dart';
import 'package:scaneat/features/login/data/datasources/login_remote_data_source.dart';

import '../../../../samples.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  LoginRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  final tAuthJson = Samples.tAuthJson;
  final tAuthModel = Samples.tAuthModel;
  final tUserJson = Samples.tUserJson;
  final tUserModel = Samples.tUserModel;
  final tValidatorJson = Samples.tValidatorJson;
  final tName = Samples.tName;
  final tEmail = Samples.tEmail;
  final tPassword = Samples.tPassword;
  final urlLogin = Config.APP_URL_DEBUG + 'api/auth/token';
  final urlRegister = Config.APP_URL_DEBUG + 'api/auth/register';
  final urlUser = Config.APP_URL_DEBUG + 'api/user';

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = LoginRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('attemptLogin', () {
    test(
      'Should preform a POST request on a URL with correct user credentials with an application/json header, Expect Auth json response',
      () {
        when(mockHttpClient.post(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((_) async => http.Response(tAuthJson, 200));

        dataSource.attemptLogin(tEmail, tPassword);

        verify(mockHttpClient.post(urlLogin,
            body: {'username': '$tEmail', 'password': '$tPassword'}));
      },
    );

    test(
        'Should preform a POST request on a URL with incorrect user credentials with an application/json header, Expect Unauth json response',
        () {
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Error', 400));

      final call = dataSource.attemptLogin('incorrect', 'incorrect');

      expect(() => call, throwsA(isInstanceOf<ServerException>()));
    });
  });

  group('attemptRegister', () {
    test(
      'Should preform a POST request to Register URL with valid credentials, Expect Auth json response',
      () async {
        when(mockHttpClient.post(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((_) async => http.Response(tAuthJson, 200));

        final result = await dataSource.attemptRegister(
            tName, tEmail, tPassword, tPassword);

        verify(mockHttpClient.post(urlRegister, body: {
          'name': tName,
          'email': tEmail,
          'password': tPassword,
          'confirm_password': tPassword
        }));
        expect(result.isRight(), equals(true));
      },
    );

    test(
        'Should preform a POST request to Register URL with invalid credentials, Expect Validator json response',
        () async {
      when(mockHttpClient.post(any,
              headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response(tValidatorJson, 400));

      final result =
          await dataSource.attemptRegister(tName, tEmail, tPassword, tPassword);

      verify(mockHttpClient.post(urlRegister, body: {
        'name': tName,
        'email': tEmail,
        'password': tPassword,
        'confirm_password': tPassword
      }));
      expect(result.isLeft(), equals(true));
    });
  });

  group('retrieveUser', () {
    test(
      'Should preform a POST request to User URL with valid token, Expect User json response',
      () async {
        when(mockHttpClient.post(any,
                headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((_) async => http.Response(tUserJson, 200));

        final result = await dataSource.retrieveUser(tAuthModel.accessToken);

        verify(mockHttpClient.post(urlUser, headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + tAuthModel.accessToken,
        }));
        expect(result, equals(tUserModel));
      },
    );
  });
}
