import 'package:dartz/dartz.dart';
import 'package:scaneat/features/product/domain/repositories/product_repository.dart';
import 'package:scaneat/features/product/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:scaneat/features/product/domain/usecases/save_product.dart';
import 'package:mockito/mockito.dart';

import '../../../../samples.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  SaveProduct usecase;
  MockProductRepository mockProductRepository;

  setUp(() {
    mockProductRepository = MockProductRepository();
    usecase = SaveProduct(mockProductRepository);
  });

  final Product tProduct = Samples.tProduct;
  final tBarcode = tProduct.barcode;
  test('Save Product from the repository using a barcode', () async {
    when(mockProductRepository.saveProduct(any))
        .thenAnswer((_) async => Right(tProduct));
    
    final response = await usecase(Params(barcode: tBarcode));

    expect(response, Right(tProduct));
    verify(mockProductRepository.saveProduct(tBarcode));
    verifyNoMoreInteractions(mockProductRepository);
  });
}
