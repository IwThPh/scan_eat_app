import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/home_page/domain/repositories/home_repository.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_diet.dart';

import '../../../../samples.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  GetDiet usecase;
  MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = GetDiet(mockHomeRepository);
  });

  final tDietList = Samples.tDietList;

  test('Retrieve Diet List from the repository', () async {
    when(mockHomeRepository.getDiets())
        .thenAnswer((_) async => Right(tDietList));
    
    final response = await usecase(NoParams());

    expect(response, Right(tDietList));
    verify(mockHomeRepository.getDiets());
    verifyNoMoreInteractions(mockHomeRepository);
  });
}