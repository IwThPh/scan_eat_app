import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:scaneat/config.dart';

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
    final tToken = Samples.tAuth.accessToken;

    test('should send a GET request to product/{barcode} endpoint', () {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(tResponse, 200));

      dataSource.getProduct(tBarcode, tToken);

      verify(
        mockHttpClient.get(
          Config.APP_URL_DEBUG + 'api/product/$tBarcode',
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $tToken',
          },
        ),
      );
    });

    test(
      'should return Product when code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(tResponse, 200),
        );
        // act
        final result = await dataSource.getProduct(tBarcode, tToken);
        // assert
        expect(result, equals(tProductModel));
      },
    );

    test('should throw ServerException when status isnt 200', () async {
      when(mockHttpClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('', 404));

      final call = dataSource.getProduct;

      expect(() => call(tBarcode, tToken),
          throwsA(isInstanceOf<ServerException>()));
    });
  });
}
