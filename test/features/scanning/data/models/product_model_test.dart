import 'package:flutter_test/flutter_test.dart';
import 'package:food_label_app/features/scanning/domain/entities/product.dart';

import '../../../../samples.dart';

void main() {
  final tProductModel = Samples.tProductModel;

  test('Should be a subclass of Product entity', () async {
    expect(tProductModel, isA<Product>());
  });
}
