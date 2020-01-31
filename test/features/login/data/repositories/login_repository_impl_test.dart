import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/core/device/network_info.dart';
import 'package:scaneat/core/error/exception.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/features/login/data/datasources/login_remote_data_source.dart';
import 'package:scaneat/features/login/data/repositories/login_repository_impl.dart';

import '../../../../samples.dart';

class MockRemoteDataSource extends Mock implements LoginRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockRemoteDataSource mockRemoteDataSource;
  MockNetworkInfo mockNetworkInfo;
  LoginRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = LoginRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tAuthModel = Samples.tAuthModel;
  final tAuth = tAuthModel;
  final tEmail = Samples.tEmail;
  final tPassword = Samples.tPassword;
  group('attemptLogin', () {
    test('Check device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      repository.attemptLogin(tEmail, tPassword);
      verify(mockNetworkInfo.isConnected);
    });

    group('Device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'Should return remote data when the call to remote data source is successful',
        () async {
          when(mockRemoteDataSource.attemptLogin(tEmail, tPassword))
              .thenAnswer((_) async => tAuthModel);

          final result = await repository.attemptLogin(tEmail, tPassword);

          verify(mockRemoteDataSource.attemptLogin(tEmail, tPassword));
          expect(result, equals(Right(tAuth)));
        },
      );

      //TODO: Ensure that the access token is stored to shared prefs on successful.

      test(
        'Should return server failure when the call to remote data source is unsuccessful',
        () async {
          // arrange
          when(mockRemoteDataSource.attemptLogin(tEmail, tPassword))
              .thenThrow(ServerException());
          // act
          final result = await repository.attemptLogin(tEmail, tPassword);
          // assert
          verify(mockRemoteDataSource.attemptLogin(tEmail, tPassword));
          expect(result, equals(Left(ServerFailure())));
        },
      );
    });

    group('Device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'Should return not connected error',
        () async {
          //TODO: Offline logic
        },
      );
    });
  });
}
