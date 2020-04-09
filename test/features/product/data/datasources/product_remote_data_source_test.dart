import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:scaneat/config.dart';

import 'package:scaneat/core/error/exception.dart';
import 'package:scaneat/features/product/data/datasources/product_remote_data_source.dart';
import 'package:scaneat/features/product/data/models/product_model.dart';

import '../../../../samples.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  ProductRemoteDataSource dataSource;
  MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('saveProduct', () {
    final tResponse = Samples.tProductJson;
    final tProductModel = ProductModel.fromJson(jsonDecode(tResponse));
    final tBarcode = tProductModel.barcode;
    final tToken = Samples.tAuth.accessToken;

    test('should send a PATCH request to product/{barcode} endpoint', () {
      when(mockHttpClient.patch(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(tResponse, 200));

      dataSource.saveProduct(tBarcode, tToken);

      verify(
        mockHttpClient.patch(
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
        when(mockHttpClient.patch(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(tResponse, 200),
        );
        // act
        final result = await dataSource.saveProduct(tBarcode, tToken);
        // assert
        expect(result, equals(tProductModel));
      },
    );

    test('should throw ServerException when status isnt 200', () async {
      when(mockHttpClient.patch(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('', 404));

      final call = dataSource.saveProduct;

      expect(() => call(tBarcode, tToken),
          throwsA(isInstanceOf<ServerException>()));
    });
  });

  group('unsaveProduct', () {
    final tResponse = Samples.tProductJson;
    final tProductModel = ProductModel.fromJson(jsonDecode(tResponse));
    final tBarcode = tProductModel.barcode;
    final tToken = Samples.tAuth.accessToken;

    test('should send a DELETE request to product/{barcode} endpoint', () {
      when(mockHttpClient.delete(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(tResponse, 200));

      dataSource.unsaveProduct(tBarcode, tToken);

      verify(
        mockHttpClient.delete(
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
        when(mockHttpClient.delete(any, headers: anyNamed('headers'))).thenAnswer(
          (_) async => http.Response(tResponse, 200),
        );
        // act
        final result = await dataSource.unsaveProduct(tBarcode, tToken);
        // assert
        expect(result, equals(tProductModel));
      },
    );

    test('should throw ServerException when status isnt 200', () async {
      when(mockHttpClient.delete(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response('', 404));

      final call = dataSource.unsaveProduct;

      expect(() => call(tBarcode, tToken),
          throwsA(isInstanceOf<ServerException>()));
    });
  });
}
