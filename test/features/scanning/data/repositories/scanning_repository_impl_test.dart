import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';

import 'package:food_label_app/features/scanning/data/models/product_model.dart';
import 'package:food_label_app/features/scanning/domain/entities/product.dart';
import 'package:food_label_app/core/device/network_info.dart';
import 'package:food_label_app/core/error/exception.dart';
import 'package:food_label_app/core/error/failure.dart';
import 'package:food_label_app/features/scanning/data/datasources/scanning_remote_data_source.dart';
import 'package:food_label_app/features/scanning/data/repositories/scanning_repository_impl.dart';

import '../../../../samples.dart';

class MockRemoteDataSource extends Mock implements ScanningRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;
  ScanningRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ScanningRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getProduct', () {
    final ProductModel tProductModel = Samples.tProductModel;
    final Product tProduct = tProductModel;
    final tBarcode = tProduct.barcode;

    test('Check device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      repository.getProduct(tBarcode);
      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      test(
        'should return response from api',
        () async {
          // arrange
          when(mockRemoteDataSource.getProduct(tBarcode))
              .thenAnswer((_) async => tProductModel);
          // act
          final result = await repository.getProduct(tBarcode);
          // assert
          verify(mockRemoteDataSource.getProduct(tBarcode));
          expect(result, equals(Right(tProduct)));
        },
      );

      test(
        'should return server failure on unsuccessful api call',
        () async {
          // arrange
          when(mockRemoteDataSource.getProduct(tBarcode))
              .thenThrow(ServerException());
          // act
          final result = await repository.getProduct(tBarcode);
          // assert
          verify(mockRemoteDataSource.getProduct(tBarcode));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      //TODO: Handle offline scanner usage.

    });
  });
}
