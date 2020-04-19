import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/login/domain/repositories/login_repository.dart';
import 'package:scaneat/features/login/domain/usecases/logout_request.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  LogoutRequest usecase;
  MockLoginRepository mockLoginRepository;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = LogoutRequest(mockLoginRepository);
  });

  test('Clear the shared preferences of auth details', () async {
    when(mockLoginRepository.attemptLogout())
        .thenAnswer((_) async => Right(true));

    final response = await usecase(NoParams());

    expect(response, Right(true));
    verify(mockLoginRepository.attemptLogout());
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
