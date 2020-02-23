import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/core/device/network_info.dart';
import 'package:scaneat/core/error/exception.dart';
import 'package:scaneat/core/error/failure.dart';
import 'package:scaneat/features/login/data/datasources/login_local_data_source.dart';
import 'package:scaneat/features/login/data/datasources/login_remote_data_source.dart';
import 'package:scaneat/features/login/data/repositories/login_repository_impl.dart';

import '../../../../samples.dart';

class MockRemoteDataSource extends Mock implements LoginRemoteDataSource {}

class MockLocalDataSource extends Mock implements LoginLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;
  LoginRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = LoginRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tAuthModel = Samples.tAuthModel;
  final tAuth = tAuthModel;

  final tValidatorModel = Samples.tValidatorModel;
  final tValidator = tAuthModel;

  final tUserModel = Samples.tUserModel;
  final tUser = tUserModel;

  final tName = Samples.tName;
  final tEmail = Samples.tEmail;
  final tPassword = Samples.tPassword;

  group('Online Functionality', () {
    test('Check device is online', () async {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      repository.attemptLogin(tEmail, tPassword);
      verify(mockNetworkInfo.isConnected);
    });
    group('attemptLogin', () {
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

        test(
          'Should return cache auth data from shared preferences, if exists',
          () async {
            // arrange
            when(mockLocalDataSource.getAuth())
                .thenAnswer((_) async => tAuthModel);
            // act
            final result = await repository.getAuth();
            // assert
            verifyZeroInteractions(mockRemoteDataSource);
            verify(mockLocalDataSource.getAuth());
            expect(result, equals(Right(tAuth)));
          },
        );

        test(
          'Should cache auth data to shared preferences, if successful',
          () async {
            // arrange
            when(mockRemoteDataSource.attemptLogin(any, any))
                .thenAnswer((_) async => tAuthModel);
            // act
            await repository.attemptLogin(tEmail, tPassword);
            // assert
            verify(mockRemoteDataSource.attemptLogin(tEmail, tPassword));
            verify(mockLocalDataSource.cacheAuth(tAuthModel));
          },
        );

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

    group('attemptRegister', () {
      group('Device is online', () {
        setUp(() {
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        });

        test(
          'Should return remote data when the call to remote data source is successful and correct',
          () async {
            when(mockRemoteDataSource.attemptRegister(
                    tName, tEmail, tPassword, tPassword))
                .thenAnswer((_) async => Right(tAuthModel));

            final result = await repository.attemptRegister(
                tName, tEmail, tPassword, tPassword);

            verify(mockRemoteDataSource.attemptRegister(
                tName, tEmail, tPassword, tPassword));
            expect(result, equals(Right(Right(tAuth))));
          },
        );

        test(
          'Should return remote data validator when the call to remote data source is successful and incorrect',
          () async {
            when(mockRemoteDataSource.attemptRegister(
                    tName, tEmail, tPassword, tPassword))
                .thenAnswer((_) async => Left(tValidatorModel));

            final result = await repository.attemptRegister(
                tName, tEmail, tPassword, tPassword);

            verify(mockRemoteDataSource.attemptRegister(
                tName, tEmail, tPassword, tPassword));
            expect(result, equals(Right(Left(tValidatorModel))));
          },
        );

        test(
          'Should cache auth data to shared preferences, if successful',
          () async {
            // arrange
            when(mockRemoteDataSource.attemptRegister(any, any, any, any))
                .thenAnswer((_) async => Right(tAuthModel));
            // act
            await repository.attemptRegister(
                tName, tEmail, tPassword, tPassword);
            // assert
            verify(mockRemoteDataSource.attemptRegister(
                tName, tEmail, tPassword, tPassword));
            verify(mockLocalDataSource.cacheAuth(tAuthModel));
          },
        );

        test(
          'Should return server failure when the call to remote data source is unsuccessful',
          () async {
            // arrange
            when(mockRemoteDataSource.attemptRegister(
                    tName, tEmail, tPassword, tPassword))
                .thenThrow(ServerException());
            // act
            final result = await repository.attemptRegister(
                tName, tEmail, tPassword, tPassword);
            // assert
            verify(mockRemoteDataSource.attemptRegister(
                tName, tEmail, tPassword, tPassword));
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
  });
  group('storeAuth', () {
    test(
      'Should return true when cache to local data source is successful',
      () async {
        when(mockLocalDataSource.cacheAuth(tAuth))
            .thenAnswer((_) async => true);

        final result = await repository.cacheAuth(tAuth);

        verify(mockLocalDataSource.cacheAuth(tAuth));
        expect(result, equals(Right(true)));
      },
    );
  });

  group('retrieveUser', () {
    test(
      'Should return remote data when the call to remote data source is successful',
      () async {
        when(mockLocalDataSource.getAuth())
            .thenAnswer((_) async => tAuthModel);
        when(mockRemoteDataSource.retrieveUser(any))
            .thenAnswer((_) async => tUserModel);

        final result = await repository.getUser();

        verify(mockRemoteDataSource.retrieveUser(tAuthModel.accessToken));
        expect(result, equals(Right(tUser)));
      },
    );
  });
}
