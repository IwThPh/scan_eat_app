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
  final tEmail = Samples.tEmail;
  final tPassword = Samples.tPassword;
  final url = Config.APP_URL_DEBUG + 'api/auth/token';

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

        verify(mockHttpClient.post(url,
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
}
