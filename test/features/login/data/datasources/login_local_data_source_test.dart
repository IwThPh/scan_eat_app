import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/core/error/exception.dart';
import 'package:scaneat/features/login/data/datasources/login_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../samples.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  LoginLocalDataSource dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = LoginLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getAuth', () {
    final tAuthModel = Samples.tAuthModel;

    test(
      'should return AuthModel from SharedPreferences, if present.',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(Samples.tAuthJson);
        // act
        final result = await dataSource.getAuth();
        // assert
        verify(mockSharedPreferences.getString(CACHED_AUTH));
        expect(result, equals(tAuthModel));
      },
    );

    test('should throw a CacheException, if not present', () {
      // arrange
      when(mockSharedPreferences.getString(any)).thenThrow(CacheException());
      // act
      final call =
          dataSource.getAuth; //Not being called. Just stored for comparison.
      // assert
      // This is needed to test if calling a method throws an exception.
      expect(() => call(), throwsA(isInstanceOf<CacheException>()));
    });
  });

  group('cacheAuth', () {
    final tAuthModel = Samples.tAuthModel;

    test('should call SharedPreferences to cache the data', () {
      // act
      dataSource.cacheAuth(tAuthModel);
      // assert
      final expected = json.encode(tAuthModel.toJson());
      verify(mockSharedPreferences.setString(
        CACHED_AUTH,
        expected,
      ));
    });
  });
}
