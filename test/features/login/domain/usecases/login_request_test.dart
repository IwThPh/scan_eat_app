import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/features/login/domain/entities/auth.dart';
import 'package:scaneat/features/login/domain/repositories/login_repository.dart';
import 'package:scaneat/features/login/domain/usecases/login_request.dart';

import '../../../../samples.dart';


class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  LoginRequest usecase;
  MockLoginRepository mockLoginRepository;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = LoginRequest(mockLoginRepository);
  });

  final String tEmail = Samples.tEmail;
  final String tPassword = Samples.tPassword;

  final Auth tAuth = Samples.tAuth;
  test('Retrieve Access Token from the repository using login details', () async {
    when(mockLoginRepository.attemptLogin(any, any))
        .thenAnswer((_) async => Right(tAuth));
    
    final response = await usecase(Params(email: tEmail, password: tPassword));

    
    developer.log(response.toString());

    expect(response, Right(tAuth));
    verify(mockLoginRepository.attemptLogin(tEmail, tPassword));
    verifyNoMoreInteractions(mockLoginRepository);
  });
  
}