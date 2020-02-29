import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/home_page/domain/repositories/home_repository.dart';
import 'package:scaneat/features/home_page/domain/usecases/delete_preference.dart';

import '../../../../samples.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  DeletePreference usecase;
  MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = DeletePreference(mockHomeRepository);
  });

  final tPreference = Samples.tPreference;

  test('Retrieve Default Preference from the repository', () async {
    when(mockHomeRepository.deletePreference())
        .thenAnswer((_) async => Right(tPreference));
    
    final response = await usecase(NoParams());

    expect(response, Right(tPreference));
    verify(mockHomeRepository.deletePreference());
    verifyNoMoreInteractions(mockHomeRepository);
  });
}