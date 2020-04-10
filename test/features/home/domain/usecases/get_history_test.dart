import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:scaneat/core/usecases/usecase.dart';
import 'package:scaneat/features/home_page/domain/repositories/home_repository.dart';
import 'package:scaneat/features/home_page/domain/usecases/get_history.dart';

import '../../../../samples.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  GetHistory usecase;
  MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = GetHistory(mockHomeRepository);
  });

  final tProductList = Samples.tProductList;

  test('Retrieve Scan History Product List from the repository', () async {
    when(mockHomeRepository.getHistory())
        .thenAnswer((_) async => Right(tProductList));
    
    final response = await usecase(NoParams());

    expect(response, Right(tProductList));
    verify(mockHomeRepository.getHistory());
    verifyNoMoreInteractions(mockHomeRepository);
  });
}