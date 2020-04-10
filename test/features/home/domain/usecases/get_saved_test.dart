import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/home_page/domain/repositories/home_repository.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_history.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_saved.dart';

import '../../../../samples.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  GetSaved usecase;
  MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = GetSaved(mockHomeRepository);
  });

  final tProductList = Samples.tProductList;

  test('Retrieve Saved Product List from the repository', () async {
    when(mockHomeRepository.getSaved())
        .thenAnswer((_) async => Right(tProductList));
    
    final response = await usecase(NoParams());

    expect(response, Right(tProductList));
    verify(mockHomeRepository.getSaved());
    verifyNoMoreInteractions(mockHomeRepository);
  });
}