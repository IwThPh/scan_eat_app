import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/features/home_page/domain/repositories/home_repository.dart';
import 'package:scaneat/features/home_page/domain/usecases/select_diet.dart';

import '../../../../samples.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  SelectDiet usecase;
  MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = SelectDiet(mockHomeRepository);
  });

  final tDietList = Samples.tDietList;

  test('Select Allergens from List', () async {
    when(mockHomeRepository.selectDiets(any))
        .thenAnswer((_) async => Right(Samples.tSuccess));

    final response = await usecase(Params(diets: tDietList));

    expect(response, Right(Samples.tSuccess));
    verify(mockHomeRepository.selectDiets(tDietList));
    verifyNoMoreInteractions(mockHomeRepository);
  });
}
