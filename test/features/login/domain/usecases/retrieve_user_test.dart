import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/login/domain/entities/auth.dart';
import 'package:scaneat/features/login/domain/entities/user.dart';
import 'package:scaneat/features/login/domain/repositories/login_repository.dart';
import 'package:scaneat/features/login/domain/usecases/retrieve_user.dart';

import '../../../../samples.dart';


class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  RetrieveUser usecase;
  MockLoginRepository mockLoginRepository;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = RetrieveUser(mockLoginRepository);
  });

  final Auth tAuth = Samples.tAuth;
  final String tToken = tAuth.accessToken;
  final User tUser = Samples.tUser;

  test('Retrieve User from the repository using access token', () async {
    when(mockLoginRepository.getUser())
        .thenAnswer((_) async => Right(tUser));
    
    final response = await usecase(NoParams());

    expect(response, Right(tUser));
    verify(mockLoginRepository.getUser());
    verifyNoMoreInteractions(mockLoginRepository);
  });
  
}