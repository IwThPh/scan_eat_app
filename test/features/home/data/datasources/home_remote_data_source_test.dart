import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/config.dart';
import 'package:scaneat/core/error/exception.dart';
import 'package:scaneat/features/home_page/data/datasources/home_remote_data_source.dart';
import 'package:scaneat/features/login/data/datasources/login_remote_data_source.dart';

import '../../../../samples.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  HomeRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  final tAuthModel = Samples.tAuthModel;
  final String token = tAuthModel.accessToken;
  final urlAllergen = Config.APP_URL_DEBUG + 'api/allergens';
  final urlDiet = Config.APP_URL_DEBUG + 'api/diets';
  final tAllergenListJson = Samples.tAllergenListJson;
  final tDietListJson = Samples.tDietListJson;
  final tSuccessJson = Samples.tSuccessJson;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = HomeRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getAllergens', () {
    test(
      'Should preform a POST request to Allergen URL, Expect List of Allergen json response',
      () {
        when(mockHttpClient.post(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(tAllergenListJson, 200));

        dataSource.getAllergens(token);

        verify(mockHttpClient.post(
          urlAllergen,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ));
      },
    );
  });

  group('selectAllergens', () {
    test(
      'Should preform a PATCH request to Allergen URL, Expect success response',
      () {
        when(mockHttpClient.patch(any, headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((_) async => http.Response(tSuccessJson, 200));

        var allergenIds = [1,2,3];
        dataSource.selectAllergens(token, allergenIds);

        verify(mockHttpClient.patch(
          urlAllergen,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: allergenIds
        ));
      },
    );
  });

  group('getDiets', () {
    test(
      'Should preform a POST request to Diet URL, Expect List of Diet json response',
      () {
        when(mockHttpClient.post(any, headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(tDietListJson, 200));

        dataSource.getDiets(token);

        verify(mockHttpClient.post(
          urlDiet,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ));
      },
    );
  });

  group('selectDiets', () {
    test(
      'Should preform a PATCH request to Diet URL, Expect success response',
      () {
        when(mockHttpClient.patch(any, headers: anyNamed('headers'), body: anyNamed('body')))
            .thenAnswer((_) async => http.Response(tSuccessJson, 200));

        var dietIds = [1,2,3];
        dataSource.selectDiets(token, dietIds);

        verify(mockHttpClient.patch(
          urlDiet,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          body: dietIds
        ));
      },
    );
  });
}
