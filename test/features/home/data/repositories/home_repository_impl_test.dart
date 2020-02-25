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

class MockLocalDataSource extends Mock implements LoginLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;
  HomeRepositoryImpl repository;

  final tAuthModel = Samples.tAuthModel;
  final tAllergenList = Samples.tAllergenModelList;
  final List<int> tAllergenIds = tAllergenList.where((a) => a.selected).map((a)=> a.id).toList();
  final tDietList = Samples.tDietModelList;
  final List<int> tDietIds = tDietList.where((d) => d.selected).map((d)=> d.id).toList();

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = HomeRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group(
    'Online Functionality',
    () {
      group('Allergens', (){
        test(
          'Should return list of allergen data when the call to remote data source is successful',
          () async {
            when(mockLocalDataSource.getAuth())
                .thenAnswer((_) async => tAuthModel);
            when(mockRemoteDataSource.getAllergens(any))
                .thenAnswer((_) async => tAllergenList);

            final result = await repository.getAllergens();

            verify(mockRemoteDataSource.getAllergens(tAuthModel.accessToken));
            expect(result, equals(Right(tAllergenList)));
          },
        );
        test(
          'Should return success message when the call to remote data source is successful',
          () async {
            when(mockLocalDataSource.getAuth())
                .thenAnswer((_) async => tAuthModel);
            when(mockRemoteDataSource.selectAllergens(any, any))
                .thenAnswer((_) async => Samples.tSuccessJson);

            final result = await repository.selectAllergens(tAllergenList);

            verify(mockRemoteDataSource.selectAllergens(tAuthModel.accessToken, tAllergenIds));
            expect(result, equals(Right(Samples.tSuccess)));
          },
        );
      });

      group('Diets', (){
        test(
          'Should return list of diet data when the call to remote data source is successful',
          () async {
            when(mockLocalDataSource.getAuth())
                .thenAnswer((_) async => tAuthModel);
            when(mockRemoteDataSource.getDiets(any))
                .thenAnswer((_) async => tDietList);

            final result = await repository.getDiets();

            verify(mockRemoteDataSource.getDiets(tAuthModel.accessToken));
            expect(result, equals(Right(tDietList)));
          },
        );

        test(
          'Should return success message when the call to remote data source is successful',
          () async {
            when(mockLocalDataSource.getAuth())
                .thenAnswer((_) async => tAuthModel);
            when(mockRemoteDataSource.selectDiets(any, any))
                .thenAnswer((_) async => Samples.tSuccessJson);

            final result = await repository.selectDiets(tDietList);

            verify(mockRemoteDataSource.selectDiets(tAuthModel.accessToken, tDietIds));
            expect(result, equals(Right(Samples.tSuccess)));
          },
        );
      });
    },
  );
}
