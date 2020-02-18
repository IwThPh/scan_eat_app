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

  final urlAllergen = Config.APP_URL_DEBUG + 'api/allergens';
  final urlDiet = Config.APP_URL_DEBUG + 'api/diets';
  final tAllergenListJson = Samples.tAllergenListJson;
  final tDietListJson = Samples.tDietListJson;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = HomeRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getAllergens', () {
    test(
      'Should preform a GET request to Allergen URL, Expect List of Allergen json response',
      () {
        when(mockHttpClient.get(any,
                headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(tAllergenListJson, 200));

        dataSource.getAllergens();

        verify(mockHttpClient.get(urlAllergen));
      },
    );
  });

  group('getDiets', () {
    test(
      'Should preform a GET request to Diet URL, Expect List of Diet json response',
      () {
        when(mockHttpClient.get(any,
                headers: anyNamed('headers')))
            .thenAnswer((_) async => http.Response(tDietListJson, 200));

        dataSource.getDiets();

        verify(mockHttpClient.get(urlDiet));
      },
    );
  });
}
