import 'package:dartz/dartz.dart';
import 'package:scaneat/features/scanning/domain/repositories/scanning_repository.dart';
import 'package:scaneat/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scaneat/features/scanning/domain/usecases/get_product.dart';
import 'package:mockito/mockito.dart';

import '../../../../samples.dart';

class MockScanningRepository extends Mock implements ScanningRepository {}

void main() {
  GetProduct usecase;
  MockScanningRepository mockScanningRepository;

  setUp(() {
    mockScanningRepository = MockScanningRepository();
    usecase = GetProduct(mockScanningRepository);
  });

  final Product tProduct = Samples.tProduct;
  final tBarcode = tProduct.barcode;
  test('Retrieve Product from the repository using a barcode', () async {
    when(mockScanningRepository.getProduct(any))
        .thenAnswer((_) async => Right(tProduct));
    
    final response = await usecase(Params(barcode: tBarcode));

    expect(response, Right(tProduct));
    verify(mockScanningRepository.getProduct(tBarcode));
    verifyNoMoreInteractions(mockScanningRepository);
  });
}
