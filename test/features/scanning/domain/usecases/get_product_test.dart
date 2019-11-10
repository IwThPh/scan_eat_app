import 'package:dartz/dartz.dart';
import 'package:food_label_app/features/scanning/domain/entities/product.dart';
import 'package:food_label_app/features/scanning/domain/repositories/scanning_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:food_label_app/features/scanning/domain/usecases/get_product.dart';
import 'package:mockito/mockito.dart';

class MockScanningRepository extends Mock implements ScanningRepository {}

void main() {
  GetProduct usecase;
  MockScanningRepository mockScanningRepository;

  setUp(() {
    mockScanningRepository = MockScanningRepository();
    usecase = GetProduct(mockScanningRepository);
  });

  final tBarcode = '0123456789876';
  final tProduct = Product(
      barcode: tBarcode,
      name: "Test Product",
      carbohydrate_100g: 0,
      energy_100g: 0,
      fat_100g: 0,
      fiber_100g: 0,
      protein_100g: 0,
      salt_100g: 0,
      saturates_100g: 0,
      sodium_100g: 0,
      sugars_100g: 0,
      weight_g: 0);

  test('Retrieve Product from the repository using a barcode', () async {
    when(mockScanningRepository.getProduct(any))
        .thenAnswer((_) async => Right(tProduct));
    
    final response = await usecase(Params(barcode: tBarcode));

    expect(response, Right(tProduct));
    verify(mockScanningRepository.getProduct(tBarcode));
    verifyNoMoreInteractions(mockScanningRepository);
  });
}
