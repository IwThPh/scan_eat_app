import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/features/home_page/domain/repositories/home_repository.dart';
import 'package:scaneat/features/home_page/domain/usecases/select_allergen.dart';

import '../../../../samples.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  SelectAllergen usecase;
  MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = SelectAllergen(mockHomeRepository);
  });

  final tAllergenList = Samples.tAllergenList;

  test('Select Allergens from List', () async {
    when(mockHomeRepository.selectAllergens(any))
        .thenAnswer((_) async => Right(Samples.tSuccess));

    final response = await usecase(Params(allergens: tAllergenList));

    expect(response, Right(Samples.tSuccess));
    verify(mockHomeRepository.selectAllergens(tAllergenList));
    verifyNoMoreInteractions(mockHomeRepository);
  });
}
