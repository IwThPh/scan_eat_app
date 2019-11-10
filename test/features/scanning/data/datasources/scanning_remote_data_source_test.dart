import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import '../../../../../lib/core/error/exception.dart';
import '../../../../../lib/core/error/failure.dart';
import '../../../../../lib/features/scanning/data/datasources/scanning_remote_data_source.dart';
import '../../../../../lib/features/scanning/data/models/product_model.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  ScanningRemoteDataSource dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ScanningRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getProduct', () {
    final tBarcode = "737628064502";
    final tResponse =
        "{\"id\":104,\"barcode\":\"0737628064502\",\"name\":\"Stir-Fry Rice Noodles\",\"weight_g\":155,\"energy_100g\":1660,\"carbohydrate_100g\":70.5,\"protein_100g\":8.97,\"fat_100g\":8.97,\"fiber_100g\":0,\"salt_100g\":2.05,\"sugar_100g\":12.8,\"saturated_100g\":1.28,\"sodium_100g\":0.819,\"created_at\":\"2019-11-10T18:22:51.000000Z\",\"updated_at\":\"2019-11-10T18:22:51.000000Z\"}";
    final tProductModel = ProductModel.fromJson(jsonDecode(tResponse));

    test('should send a GET request to product/{barcode} endpoint', () {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(tResponse, 200));

      dataSource.getProduct(tBarcode);

      verify(mockHttpClient.get(
          'https://192.168.42.160:8000/api/product/$tBarcode',
          headers: {'Content-Type': 'application-json'}));
    });

    test(
      'should return Product when code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(tResponse, 200),
        );
        // act
        final result = await dataSource.getProduct(tBarcode);
        // assert
        expect(result, equals(tProductModel));
      },
    );

    test('should throw ServerException when status isnt 200', () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('', 404));

      final call = dataSource.getProduct;

      expect(() => call(tBarcode), throwsA(isInstanceOf<ServerException>()));
    });
  });
}
