import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/home_page/domain/repositories/home_repository.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_preference.dart';

import '../../../../samples.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  GetPreference usecase;
  MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = GetPreference(mockHomeRepository);
  });

  final tPreference = Samples.tPreference;

  test('Retrieve Users Preference from the repository', () async {
    when(mockHomeRepository.getPreference())
        .thenAnswer((_) async => Right(tPreference));
    
    final response = await usecase(NoParams());

    expect(response, Right(tPreference));
    verify(mockHomeRepository.getPreference());
    verifyNoMoreInteractions(mockHomeRepository);
  });
}