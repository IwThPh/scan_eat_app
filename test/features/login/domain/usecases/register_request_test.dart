import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/features/login/domain/entities/auth.dart';
import 'package:scaneat/features/login/domain/entities/validator.dart';
import 'package:scaneat/features/login/domain/repositories/login_repository.dart';
import 'package:scaneat/features/login/domain/usecases/register_request.dart';

import '../../../../samples.dart';


class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  RegisterRequest usecase;
  MockLoginRepository mockLoginRepository;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = RegisterRequest(mockLoginRepository);
  });

  final String tName = Samples.tName;
  final String tEmail = Samples.tEmail;
  final String tPassword = Samples.tPassword;

  final Auth tAuth = Samples.tAuth;
  final Validator tValidator = Samples.tValidator;

  test('Retrieve Access Token from the repository if registration is successful', () async {
    when(mockLoginRepository.attemptRegister(any, any, any, any))
        .thenAnswer((_) async => Right(Right(tAuth)));
    
    final response = await usecase(Params(name: tName, email: tEmail, password: tPassword, cPassword: tPassword));

    expect(response, Right(Right(tAuth)));
    verify(mockLoginRepository.attemptRegister(tName, tEmail, tPassword, tPassword));
    verifyNoMoreInteractions(mockLoginRepository);
  });

  test('Retrieve Validator from the repository if registration is invalid', () async {
    when(mockLoginRepository.attemptRegister(any, any, any, any))
        .thenAnswer((_) async => Right(Left(tValidator)));
    
    final response = await usecase(Params(name: tName, email: tEmail, password: tPassword, cPassword: tPassword));

    expect(response, Right(Left(tValidator)));
    verify(mockLoginRepository.attemptRegister(tName, tEmail, tPassword, tPassword));
    verifyNoMoreInteractions(mockLoginRepository);
  });

}