import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/features/login/data/datasources/login_local_data_source.dart';

import 'package:scaneat/features/product/data/models/product_model.dart';
import 'package:scaneat/features/product/domain/entities/product.dart';
import 'package:scaneat/core/device/network_info.dart';
import 'package:scaneat/core/error/exception.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/features/product/data/datasources/product_remote_data_source.dart';
import 'package:scaneat/features/product/data/repositories/product_repository_impl.dart';

import '../../../../samples.dart';

class MockRemoteDataSource extends Mock implements ProductRemoteDataSource {}

class MockLocalDataSource extends Mock implements LoginLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;
  ProductRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tAuthModel = Samples.tAuthModel;

  group('saveProduct', () {
    final ProductModel tProductModel = Samples.tProductModel;
    final Product tProduct = tProductModel;
    final tBarcode = tProduct.barcode;
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
          when(mockRemoteDataSource.saveProduct(
                  tBarcode, tAuthModel.accessToken))
              .thenAnswer((_) async => tProductModel);
          // act
          final result = await repository.saveProduct(tBarcode);
          // assert
          verify(mockRemoteDataSource.saveProduct(
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
          when(mockRemoteDataSource.saveProduct(
                  tBarcode, tAuthModel.accessToken))
              .thenThrow(ServerException());
          // act
          final result = await repository.saveProduct(tBarcode);
          // assert
          verify(mockRemoteDataSource.saveProduct(
              tBarcode, tAuthModel.accessToken));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      //TODO: Handle offline sage.
    });
  });

  group('unsaveProduct', () {
    final ProductModel tProductModel = Samples.tProductModel;
    final Product tProduct = tProductModel;
    final tBarcode = tProduct.barcode;
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
          when(mockRemoteDataSource.unsaveProduct(
                  tBarcode, tAuthModel.accessToken))
              .thenAnswer((_) async => tProductModel);
          // act
          final result = await repository.unsaveProduct(tBarcode);
          // assert
          verify(mockRemoteDataSource.unsaveProduct(
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
          when(mockRemoteDataSource.unsaveProduct(
                  tBarcode, tAuthModel.accessToken))
              .thenThrow(ServerException());
          // act
          final result = await repository.unsaveProduct(tBarcode);
          // assert
          verify(mockRemoteDataSource.unsaveProduct(
              tBarcode, tAuthModel.accessToken));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      //TODO: Handle offline sage.
    });
  });
}
