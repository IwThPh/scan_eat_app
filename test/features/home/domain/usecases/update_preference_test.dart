import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/features/home_page/domain/repositories/home_repository.dart';
import 'package:scaneat/features/home_page/domain/usecases/update_preference.dart';

import '../../../../samples.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  UpdatePreference usecase;
  MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = UpdatePreference(mockHomeRepository);
  });

  final tPreference = Samples.tPreference;

  test('Retrieve Updated Preference from the repository', () async {
    when(mockHomeRepository.updatePreference(tPreference))
        .thenAnswer((_) async => Right(tPreference));
    
    final response = await usecase(Params(pref: tPreference));

    expect(response, Right(tPreference));
    verify(mockHomeRepository.updatePreference(tPreference));
    verifyNoMoreInteractions(mockHomeRepository);
  });
}