import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib/features/scanning/data/models/product_model.dart';
import '../../../../../lib/features/scanning/domain/entities/product.dart';

void main() {
  final tProductModel = ProductModel(
    barcode: "0000000000000",
    name: "Test",
    carbohydrate_100g: 0.0,
    energy_100g: 0.0,
    fat_100g: 0.0,
    fiber_100g: 0.0,
    protein_100g: 0.0,
    salt_100g: 0.0,
    saturates_100g: 0.0,
    sodium_100g: 0.0,
    sugars_100g: 0.0,
    weight_g: 0.0
  );

  test('Should be a subclass of Product entity', () async {
    expect(tProductModel, isA<Product>());
  });
}
