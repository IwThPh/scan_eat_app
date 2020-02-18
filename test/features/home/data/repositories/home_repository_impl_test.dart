import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/core/device/network_info.dart';
import 'package:scaneat/features/home_page/data/datasources/home_remote_data_source.dart';
import 'package:scaneat/features/home_page/data/repositories/home_repository_impl.dart';
import 'package:scaneat/features/login/data/datasources/login_local_data_source.dart';
import 'package:scaneat/features/login/data/datasources/login_remote_data_source.dart';
import 'package:scaneat/features/login/data/repositories/login_repository_impl.dart';

import '../../../../samples.dart';

class MockRemoteDataSource extends Mock implements HomeRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;
  HomeRepositoryImpl repository;

  final tAllergenListJson = Samples.tAllergenListJson;
  final tAllergenList = Samples.tAllergenModelList;
  final tDietListJson = Samples.tDietListJson;
  final tDietList = Samples.tDietModelList;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = HomeRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('Online Functionality', () {
        test(
          'Should return list of allergen data when the call to remote data source is successful',
          () async {
            when(mockRemoteDataSource.getAllergens())
                .thenAnswer((_) async => tAllergenList);

            final result = await repository.getAllergens();

            verify(mockRemoteDataSource.getAllergens());
            expect(result, equals(Right(tAllergenList)));
          },
        );

        test(
          'Should return list of diet data when the call to remote data source is successful',
          () async {
            when(mockRemoteDataSource.getDiets())
                .thenAnswer((_) async => tDietList);

            final result = await repository.getDiets();

            verify(mockRemoteDataSource.getDiets());
            expect(result, equals(Right(tDietList)));
          },
        );
  });
}