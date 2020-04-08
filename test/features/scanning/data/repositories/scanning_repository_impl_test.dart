import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/features/login/data/datasources/login_local_data_source.dart';

import 'package:scaneat/features/product/data/models/product_model.dart';
import 'package:scaneat/features/product/domain/entities/product.dart';
import 'package:scaneat/core/device/network_info.dart';
import 'package:scaneat/core/error/exception.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/features/scanning/data/datasources/scanning_remote_data_source.dart';
import 'package:scaneat/features/scanning/data/repositories/scanning_repository_impl.dart';

import '../../../../samples.dart';

class MockRemoteDataSource extends Mock implements ScanningRemoteDataSource {}

class MockLocalDataSource extends Mock implements LoginLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;
  ScanningRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ScanningRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tAuthModel = Samples.tAuthModel;

  group('getProduct', () {
    final ProductModel tProductModel = Samples.tProductModel;
    final Product tProduct = tProductModel;
    final tBarcode = tProduct.barcode;

    test('Check device is online', () async {
      when(mockLocalDataSource.getAuth()).thenAnswer((_) async => tAuthModel);
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
          when(mockLocalDataSource.getAuth())
              .thenAnswer((_) async => tAuthModel);
          when(mockRemoteDataSource.getProduct(
                  tBarcode, tAuthModel.accessToken))
              .thenAnswer((_) async => tProductModel);
          // act
          final result = await repository.getProduct(tBarcode);
          // assert
          verify(mockRemoteDataSource.getProduct(
              tBarcode, tAuthModel.accessToken));
          expect(result, equals(Right(tProduct)));
        },
      );

      test(
        'should return server failure on unsuccessful api call',
        () async {
          // arrange
          when(mockLocalDataSource.getAuth())
              .thenAnswer((_) async => tAuthModel);
          when(mockRemoteDataSource.getProduct(
                  tBarcode, tAuthModel.accessToken))
              .thenThrow(ServerException());
          // act
          final result = await repository.getProduct(tBarcode);
          // assert
          verify(mockRemoteDataSource.getProduct(
              tBarcode, tAuthModel.accessToken));
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
