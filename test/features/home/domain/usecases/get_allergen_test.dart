import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/home_page/domain/repositories/home_repository.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_allergen.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_diet.dart';

import '../../../../samples.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  GetAllergen usecase;
  MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = GetAllergen(mockHomeRepository);
  });

  final tAllergenList = Samples.tAllergenList;

  test('Retrieve Allergen List from the repository', () async {
    when(mockHomeRepository.getAllergens())
        .thenAnswer((_) async => Right(tAllergenList));
    
    final response = await usecase(NoParams());

    expect(response, Right(tAllergenList));
    verify(mockHomeRepository.getAllergens());
    verifyNoMoreInteractions(mockHomeRepository);
  });
}