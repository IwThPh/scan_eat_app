import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:scaneat/core/error/exception.dart';
import 'package:scaneat/features/scanning/data/datasources/scanning_remote_data_source.dart';
import 'package:scaneat/features/scanning/data/models/product_model.dart';

import '../../../../samples.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  ScanningRemoteDataSource dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ScanningRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('getProduct', () {
    final tResponse = Samples.tProductJson;
    final tProductModel = ProductModel.fromJson(jsonDecode(tResponse));
    final tBarcode = tProductModel.barcode;

    test('should send a GET request to product/{barcode} endpoint', () {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(tResponse, 200));

      dataSource.getProduct(tBarcode);

      verify(mockHttpClient.get(
          'http://192.168.42.160:8000/api/product/$tBarcode',
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
