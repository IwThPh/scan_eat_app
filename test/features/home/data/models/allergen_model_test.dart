import 'package:flutter_test/flutter_test.dart';
import 'package:scaneat/features/home_page/domain/entities/allergen.dart';

import '../../../../samples.dart';

main() {
  final tAllergenModel = Samples.tAllergenModel;

  test('Should be a subclass of Allergen entity', () async {
    expect(tAllergenModel, isA<Allergen>());
  });
}